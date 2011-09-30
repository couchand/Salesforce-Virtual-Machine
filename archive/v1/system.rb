module Apex
  class Scope
    def initialize
      @containers = {}
      @vars = {}
      @types = { 'integer' => ApexInteger, 'boolean' => ApexBoolean, 'string' => ApexString }
    end

    def setup( c, v, t )
      @containers = c.clone
      @vars = v.clone
      @types = t.clone
    end

    def local_copy
      new_scope = Scope.new
      new_scope.setup @containers, @vars, @types
      new_scope
    end

    def contains?( name )
      @containers.has_key? name
    end

    def get( name )
#      puts "get #{name} from #{caller[0]}"
      g_type( name ) || g_var( name )
    end

    def declare( name, type )
      raise "UnknownType: #{type}" unless @types.has_key? type
      raise "Redeclaration" if @containers.has_key? name
      @containers[name] = @types[type]
    end

    def set_var( name, value )
      raise "TypeError" unless value.is_a? @containers[name]
      @vars[name] = value
    end

    def get_var( name )
      raise "UnknownVar" unless @vars.has_key? name
      g_var( name )
    end

    def set_type( name, value )
      raise "ClassError" unless value.is_a? Class
      @types[name] = value
    end

    def get_type( name )
      raise "UnknownType: #{name}" unless @types.has_key? name
#      puts "get type #{name} from #{caller[0]}"
      g_type( name )
    end

    private

    def g_var( name )
      @vars[name]
    end

    def g_type( name )
      @types[name]
    end
  end
end
