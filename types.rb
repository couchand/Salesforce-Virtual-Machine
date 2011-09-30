module Apex

  class ApexObject
  end

  class ApexBoolean < ApexObject
    def typecheck(t)
      raise "TypeError" unless t == ApexBoolean
    end

    def initialize(v)
      @v = v
    end

    def ==(b)
      raise "TypeError" unless b.is_a? ApexBoolean
      ApexBoolean.new( @v == b.value )
    end

    def value
      @v
    end

    def ~@
      ApexBoolean.new(!@v)
    end

    def |(b)
      raise "TypeError" unless b.is_a? ApexBoolean
      if @v
        ApexBoolean.new(true)
      else
        b
      end
    end

    def &(b)
      raise "TypeError" unless b.is_a? ApexBoolean
      if @v
        if b.value
          ApexBoolean.new(true)
        else
          ApexBoolean.new(false)
        end
      else
        ApexBoolean.new(false)
      end
    end
  end

  class ApexInteger < ApexObject
    def typecheck(t)
      raise "TypeError #{t}" unless t == ApexInteger
    end

    def initialize(i)
      @i = i
    end

    def value
      @i
    end

    def -@
      ApexInteger.new( -@i )
    end

    def +@
      ApexInteger.new( +@i )
    end

    def ==(b)
      if b.nil?
        @v.nil?
      else
        raise "TypeError" unless b.is_a? ApexInteger
        ApexBoolean.new( @i == b.value )
      end
    end

    def >(b)
      raise "TypeError" unless b.is_a? ApexInteger
      ApexBoolean.new( @i > b.value )
    end

    def <(b)
      raise "TypeError" unless b.is_a? ApexInteger
      ApexBoolean.new( @i < b.value )
    end

    def >=(b)
      raise "TypeError" unless b.is_a? ApexInteger
      ApexBoolean.new( @i >= b.value )
    end

    def <=(b)
      raise "TypeError" unless b.is_a? ApexInteger
      ApexBoolean.new( @i <= b.value )
    end

    def +(b)
      raise "TypeError" unless b.is_a? ApexInteger
      ApexInteger.new( @i + b.value )
    end

    def -(b)
      raise "TypeError" unless b.is_a? ApexInteger
      ApexInteger.new( @i - b.value )
    end

    def *(b)
      raise "TypeError" unless b.is_a? ApexInteger
      ApexInteger.new( @i * b.value )
    end

    def /(b)
      raise "TypeError" unless b.is_a? ApexInteger
      ApexInteger.new( @i / b.value )
    end
  end

  class ApexString < ApexObject
    def typecheck(t)
      raise "TypeError" unless t == ApexString
    end

    def initialize(v)
      @v = v
    end

    def ==(b)
      if b.nil?
        @v.nil?
      else
        raise "TypeError" unless b.is_a? ApexString
#puts "me #{@v} you #{b.value}"
        ApexBoolean.new( @v == b.value )
      end
    end

    def +(b)
      raise "TypeError" unless b.is_a? ApexString
      ApexString.new( @v + b.value )
    end

    def value
      @v
    end
  end

end
