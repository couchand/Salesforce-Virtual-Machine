require 'parser.rb'

p = Parser.load


[
  'true?true:false',
  '!true?false:true',
  'true?null:false',
  'true?5:6',
  #'int j = k = 5',
  'false || false || true',
  'true || false?5:6',
  'true||false ? 5 : 6',
  'false || !(false || true)',
  'true && true && !false',
  'true && !(false || true)',
  "'foobar'",
  "( (true?'foo':'bar') == 'foo' )?'expected':'unexpected'",
  "5==6?'unexpected':'expected'",
  "5!=5?'unexpected':'expected'",
  "'test1'=='test2'?'unexpected':'expected'",
  "(true?'foo':'bar')==(false?'foo':'bar')?'unexpected':'expected'",
  "'another'!='another'?'unexpected':'expected'",
  "6 < 7 ? 'expected' : 'unexpected'",
  "7 < 6 ? 'unexpected' : 'expected'",
  "6 < 6 ? 'unexpected' : 'expected'",
  "7 >= 6 ? 'expected' : 'unexpected'",
  "6 >= 7 ? 'unexpected' : 'expected'",
  "6 >= 6 ? 'expected' : 'unexpected'",
  "6 > 7 ? 'unexpected' : 'expected'",
  "7 > 6 ? 'expected' : 'unexpected'",
  "6 > 6 ? 'unexpected' : 'expected'",
  "7 <= 6 ? 'unexpected' : 'expected'",
  "6 <= 7 ? 'expected' : 'unexpected'",
  "6 <= 6 ? 'expected' : 'unexpected'",
  "6 < 7 == 6 >= 7 ? 'unexpected' : 'expected'",
  "6 == 2 + 4 ? 'expected' : 'unexpected'",
  "7 == 12 - 5 ? 'expected' : 'unexpected'",
  "7 != 7 + 7 ? 'expected' : 'unexpected'",
  "6 != 6 - 6 ? 'expected' : 'unexpected'",
  "6 < 3 + 4 ? 'expected' : 'unexpected'",
  "7 < 22 - 5 ? 'expected' : 'unexpected'",
  "7 < 7 + 7 ? 'expected' : 'unexpected'",
  "6 > 6 - 6 ? 'expected' : 'unexpected'",
  "6 == 2 * 3 ? 'expected' : 'unexpected'",
  "2 == 6 / 3 ? 'expected' : 'unexpected'",
  "6 == 7 + -1 ? 'expected' : 'unexpected'",
  "7 == 6 + +1 ? 'expected' : 'unexpected'",
  "6 == 7 || 6 >= 7 || 6 < 7 ? 'expected' : 'unexpected'",
  "2 * 3 < 8 && 2 + 3 > 8 || 6 - 7 > 0 && 6 + 7 >= 0 ? 'unexpected':'expected'",
  "true && true && true && 2 < 3 && 5<6&&7>1 ?'expected':'unexpected'",
  "4 == 1 + 1 + 1 + 1 ? 'expected' : 'unexpected'",
  "1 == 1 * 1 * 1 * 1 ? 'expected' : 'unexpected'"
]#TODO: check syntax

[
  { :e => 12,	:a => "3 * 4 / 2 * 2" },
  { :e => 7,	:a => "3 + 4 - 2 + 2" }
].each do |test_expression|
  puts "Test: #{test_expression[:e]} equals #{test_expression[:a]}"
  t = Parser.parse( test_expression[:a] )
  begin
    v = t.value
    if v.nil?
      v = 'null'
    elsif v.is_a? String
      v = "'#{v}'"
    end

    if v != test_expression[:e]
      puts "Expected: #{test_expression[:e]}\tActual: #{v}"

      puts 'Inspect:'

      puts t.inspect
    end
  rescue
    puts 'Inspect:'
    puts t.inspect

    puts p.parse( test_expression ).inspect
  end
end

