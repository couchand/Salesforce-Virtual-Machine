module Apex
  class Scope
    def initialize
      @containers = {}
      @vars = {}
      @types = { 'integer' => ApexInteger, 'boolean' => ApexBoolean, 'string' => ApexString }
      @parent = nil
    end

    def setup( c, t, p )
      @containers = c.clone
      @types = t.clone
      @parent = p
    end

    def local_copy
      new_scope = Scope.new
      new_scope.setup @containers, @types, self
      new_scope
    end

    def has_parent?
      !@parent.nil?
    end

    def contains?( name )
      @containers.has_key? name or (has_parent? and @parent.contains? name)
    end

    def get( name )
#      puts "get #{name} from #{caller[0]}"
      g_type( name ) or g_var( name ) or (has_parent? ? @parent.get( name ) : nil)
    end

    def declare( name, type )
      raise "UnknownType: #{type}" unless @types.has_key? type
      raise "Redeclaration" if @containers.has_key? name
      @containers[name] = @types[type]
    end

    def set_var( name, value )
      raise "TypeError" unless value.is_a? @containers[name]
      if (has_parent? and @parent.contains? name)
      then
        @parent.set_var( name, value )
      else
        @vars[name] = value
      end
    end

    def get_var( name )
      raise "UnknownVar" unless (contains? name or (has_parent? and @parent.contains? name))
      g_var( name ) or @parent.get_var( name )
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
