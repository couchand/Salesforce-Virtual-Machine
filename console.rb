require_relative 'parser.rb'

devmode = false
p = Parser.load
sc = Apex::Scope.new

loop do
  print '> '

  statement = readline.chomp.strip.downcase

  break if statement.start_with? "quit"

  while !statement.end_with? ';'

    print '  '

    next_line = readline.chomp.strip.downcase
    break if next_line.start_with? "quit"

    statement += ' ' + next_line

  end

  begin
    t = Parser.parse( statement )

  begin
    local_scope = sc.local_copy
    o = t.expression.value local_scope
    v = o.value

    sc = local_scope

    if v.nil?
      v = 'null'
    elsif v.is_a? String
      v = "'#{v}'"
    end

    puts "= #{v}"

    if devmode
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

  rescue Exception => e
    puts p.failure_reason
    puts p.failure_line
    puts p.failure_column

  end #if failure else clause
end

