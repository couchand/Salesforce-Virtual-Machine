require_relative 'parser.rb'

p = Parser.load
sc = Apex::Scope.new

[
  { :e => Apex::ApexBoolean.new(true),		:a => 'true?true:false' },
  { :e => Apex::ApexBoolean.new(true),		:a => '!true?false:true' },
 # { :e => ,	:a => 'true?null:false' },
  { :e => Apex::ApexInteger.new(5),		:a => 'true?5:6' },
  #'int j = k = 5',
  { :e => Apex::ApexBoolean.new(true),		:a => 'false || false || true' },
  { :e => Apex::ApexInteger.new(5),		:a => 'true || false?5:6' },
  { :e => Apex::ApexBoolean.new(false),		:a => 'false || !(false || true)' },
  { :e => Apex::ApexBoolean.new(true),		:a => 'true && true && !false' },
  { :e => Apex::ApexBoolean.new(false),		:a => 'true && !(false || true)' },
  { :e => Apex::ApexString.new('foobar'),	:a => "'foobar'" },
  { :e => Apex::ApexString.new('expected'),	:a => "( (true?'foo':'bar') == 'foo' )?'expected':'unexpected'" },
  { :e => Apex::ApexBoolean.new(false),		:a => "5==6" },
  { :e => Apex::ApexBoolean.new(false),		:a => "5!=5" },
  { :e => Apex::ApexBoolean.new(false),		:a => "'test1'=='test2'" },
  { :e => Apex::ApexBoolean.new(false),		:a => "(true?'foo':'bar')==(false?'foo':'bar')" },
  { :e => Apex::ApexBoolean.new(false),		:a => "'another'!='another'" },
  { :e => Apex::ApexBoolean.new(true),		:a => "6 < 7" },
  { :e => Apex::ApexBoolean.new(false),		:a => "7 < 6" },
  { :e => Apex::ApexBoolean.new(false),		:a => "6 < 6" },
  { :e => Apex::ApexBoolean.new(true),		:a => "7 >= 6" },
  { :e => Apex::ApexBoolean.new(false),		:a => "6 >= 7" },
  { :e => Apex::ApexBoolean.new(true),		:a => "6 >= 6" },
  { :e => Apex::ApexBoolean.new(false),		:a => "6 > 7" },
  { :e => Apex::ApexBoolean.new(true),		:a => "7 > 6" },
  { :e => Apex::ApexBoolean.new(false),		:a => "6 > 6" },
  { :e => Apex::ApexBoolean.new(false),		:a => "7 <= 6" },
  { :e => Apex::ApexBoolean.new(true),		:a => "6 <= 7" },
  { :e => Apex::ApexBoolean.new(true),		:a => "6 <= 6" },
  { :e => Apex::ApexBoolean.new(false),		:a => "6 < 7 == 6 >= 7" },
  { :e => Apex::ApexBoolean.new(true),		:a => "6 == 2 + 4" },
  { :e => Apex::ApexBoolean.new(true),		:a => "7 == 12 - 5" },
  { :e => Apex::ApexBoolean.new(true),		:a => "7 != 7 + 7" },
  { :e => Apex::ApexBoolean.new(true),		:a => "6 != 6 - 6" },
  { :e => Apex::ApexBoolean.new(true),		:a => "6 < 3 + 4" },
  { :e => Apex::ApexBoolean.new(true),		:a => "7 < 22 - 5" },
  { :e => Apex::ApexBoolean.new(true),		:a => "7 < 7 + 7" },
  { :e => Apex::ApexBoolean.new(true),		:a => "6 > 6 - 6" },
  { :e => Apex::ApexBoolean.new(true),		:a => "6 == 2 * 3" },
  { :e => Apex::ApexBoolean.new(true),		:a => "2 == 6 / 3" },
  { :e => Apex::ApexBoolean.new(true),		:a => "6 == 7 + -1" },
  { :e => Apex::ApexBoolean.new(true),		:a => "7 == 6 + +1" },
  { :e => Apex::ApexBoolean.new(true),		:a => "6 == 7 || 6 >= 7 || 6 < 7" },
  { :e => Apex::ApexBoolean.new(false),		:a => "2 * 3 < 8 && 2 + 3 > 8 || 6 - 7 > 0 && 6 + 7 >= 0" },
  { :e => Apex::ApexBoolean.new(true),		:a => "true && true && true && 2 < 3 && 5<6&&7>1" },
  { :e => Apex::ApexBoolean.new(true),		:a => "4 == 1 + 1 + 1 + 1" },
  { :e => Apex::ApexBoolean.new(true),		:a => "1 == 1 * 1 * 1 * 1" },
  { :e => Apex::ApexInteger.new(12),		:a => "3 * 4 / 2 * 2" },
  { :e => Apex::ApexInteger.new(7),		:a => "3 + 4 - 2 + 2" },
  { :e => Apex::ApexBoolean.new(true),		:a => "2 * 3 > 5" },
  { :e => Apex::ApexBoolean.new(true),		:a => "2 * 3 < 7" },
  { :e => Apex::ApexBoolean.new(true),		:a => "2 * 3 == 6" },
  { :e => Apex::ApexBoolean.new(false),		:a => "2 * 3 != 6" },
  { :e => Apex::ApexBoolean.new(true),		:a => "2 * 3 >= 5" },
  { :e => Apex::ApexBoolean.new(true),		:a => "2 * 3 <= 7" },
  { :e => Apex::ApexBoolean.new(true),		:a => "!false" },
  { :e => Apex::ApexInteger.new(-5),		:a => "-5" },
  { :e => Apex::ApexInteger.new(-5),		:a => "0 - +5" },
  { :e => Apex::ApexInteger.new(1),		:a => "Integer i = 1" },
  { :e => Apex::ApexInteger.new(1),		:a => "i" },
  { :e => Apex::ApexString.new('foobar'),	:a => "String s = 'foobar'" },
  { :e => Apex::ApexBoolean.new(false),		:a => "Boolean b = false" },
  { :e => Apex::ApexBoolean.new(true),		:a => "Boolean c = false, e = true" },
  { :e => Apex::ApexBoolean.new(true),		:a => "Boolean d = b = true" },
  { :e => Apex::ApexString.new('foobar'),	:a => "s" },
  { :e => Apex::ApexBoolean.new(true),		:a => "b" },
  { :e => Apex::ApexBoolean.new(true),		:a => "d" },
  { :e => Apex::ApexBoolean.new(true),		:a => "e" },
  { :e => Apex::ApexBoolean.new(false),		:a => "c" }
].each do |test_expression|
  e = test_expression[:e].value
  if e.nil?
    e = 'null'
  elsif e.is_a? String
    e = "'#{e}'"
  end

  puts "Test: #{e} equals #{test_expression[:a]}"
  t = Parser.parse( test_expression[:a].downcase, :root => 'expression' )

#if !t
#  puts p.failure_reason
#  puts p.failure_line
#  puts p.failure_column
#else

  begin
    o = t.value sc
    v = o.value
    if v.nil?
      v = 'null'
    elsif v.is_a? String
      v = "'#{v}'"
    end

    if (~(o == test_expression[:e])).value
      puts "Expected: #{e}\tActual: #{v}"

      puts 'Inspect:'
      puts t.inspect
    end
  rescue Exception => e
    puts 'Inspect:'
    puts t.inspect

    puts e.message
    puts e.backtrace.inspect
#    puts p.parse( test_expression ).inspect
  end
#end #if failure else clause
end

