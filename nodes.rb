require_relative 'system.rb'
require_relative 'types.rb'

module Apex
  class IntegerLiteral < Treetop::Runtime::SyntaxNode
    def value( scope )
      ApexInteger.new text_value.to_i
    end
  end

  class StringLiteral < Treetop::Runtime::SyntaxNode
    def value( scope )
      ApexString.new text_value.to_s[1..-2]
    end
  end

  class NullLiteral < Treetop::Runtime::SyntaxNode
    def value( scope )
      nil
    end
  end

  class TrueLiteral < Treetop::Runtime::SyntaxNode
    def value( scope )
      ApexBoolean.new true
    end
  end

  class FalseLiteral < Treetop::Runtime::SyntaxNode
    def value( scope )
      ApexBoolean.new false
    end
  end

  class Identifier < Treetop::Runtime::SyntaxNode
    def name
      text_value.to_s
    end

    def value(scope)
      scope.get name
    end
  end

  class ParenthesizedExpression < Treetop::Runtime::SyntaxNode
    def subexpression
      elements[0]
    end

    def value( scope )
      subexpression.value( scope )
    end
  end

  class LogicalOrExpression < Treetop::Runtime::SyntaxNode
    def head_condition
      elements[0]
    end

    def tail_condition
      elements[1]
    end

    def value( scope )
      head_condition.value( scope ) | tail_condition.value( scope )
    end
  end

  class LogicalAndExpression < Treetop::Runtime::SyntaxNode
    def head_condition
      elements[0]
    end

    def tail_condition
      elements[1]
    end

    def value( scope )
      head_condition.value( scope ) & tail_condition.value( scope )
    end
  end

  class InfixExpression < Treetop::Runtime::SyntaxNode
    def left_clause
      elements[0]
    end

    def right_clause
      elements[2]
    end

    def operator
      elements[1]
    end

    def value( scope )
      operator.operate left_clause.value( scope ), right_clause.value( scope )
    end
  end

  class EqualsOperator < Treetop::Runtime::SyntaxNode
    def operate( left_value, right_value )
      left_value == right_value
    end
  end

  class NotEqualsOperator < Treetop::Runtime::SyntaxNode
    def operate( left_value, right_value )
      ~(left_value == right_value)
    end
  end

  class AdditionOperator < Treetop::Runtime::SyntaxNode
    def operate( left_value, right_value )
      left_value + right_value
    end
  end

  class SubtractionOperator < Treetop::Runtime::SyntaxNode
    def operate( left_value, right_value )
      left_value - right_value
    end
  end

  class MultiplicationOperator < Treetop::Runtime::SyntaxNode
    def operate( left_value, right_value )
      left_value * right_value
    end
  end

  class DivisionOperator < Treetop::Runtime::SyntaxNode
    def operate( left_value, right_value )
      left_value / right_value
    end
  end

  class LessThanOperator < Treetop::Runtime::SyntaxNode
    def operate( left_value, right_value )
      left_value < right_value
    end
  end

  class GreaterOrEqualsOperator < Treetop::Runtime::SyntaxNode
    def operate( left_value, right_value )
      left_value >= right_value
    end
  end

  class LessOrEqualsOperator < Treetop::Runtime::SyntaxNode
    def operate( left_value, right_value )
      left_value <= right_value
    end
  end

  class GreaterThanOperator < Treetop::Runtime::SyntaxNode
    def operate( left_value, right_value )
      left_value > right_value
    end
  end

  class TernaryExpression < Treetop::Runtime::SyntaxNode
    def condition
      elements[0]
    end

    def true_clause
      elements[1]
    end

    def false_clause
      elements[2]
    end

    def value( scope )
      if condition.value( scope ).value
        true_clause.value( scope )
      else
        false_clause.value( scope )
      end
    end
  end

  class Statement < Treetop::Runtime::SyntaxNode
    def expression
      elements[0]
    end
  end

  class AssignmentExpression < Treetop::Runtime::SyntaxNode
    def assignee
      elements[0]
    end

    def operator
      elements[1]
    end

    def assigner
      elements[2]
    end

    def value(scope)
      scope.set_var( assignee.name, assigner.value(scope) )
      scope.get_var assignee.name
    end
  end

  class AssignmentSubassignment < Treetop::Runtime::SyntaxNode
    def assignee
      elements[0]
    end

    def operator
      elements[1]
    end

    def assigner
      elements[2]
    end

    def value( scope )
      scope.set_var( assignee.name, assigner.value(scope) )
      scope.get_var assignee.name
    end
  end

  class Declaration < Treetop::Runtime::SyntaxNode
    def type
      elements[start]
    end

    def name
      elements[start+1]
    end

    def assignment
      elements[start+2] if has_assignment? 
    end

    def has_assignment?
      elements[start+2].is_a? DeclarationAssignment
    end

    def rest
      if has_assignment?
        elements[start+3]
      else
        elements[start+2]
      end
    end

    def has_rest?
      ( has_assignment? && elements[start+3].is_a?(DeclarationRest)) \
      || elements[start+2].is_a?(DeclarationRest)
    end

    def value( scope )
      raise "RedeclarationError: #{name.name}" if scope.contains? name.name
      scope.declare name.name, type.name
      if has_assignment?
        v = assignment.value( scope )
        v.typecheck type.value( scope )
        scope.set_var( name.name, v )
      end
      if has_rest?
        rest.declare type, scope
      else
        name.value scope
      end
    end

    private

    def start
      0
    end
  end

  class DeclarationAssignment < Treetop::Runtime::SyntaxNode
    def expression
      elements[0]
    end

    def value( scope )
      expression.value( scope )
    end
  end

  class DeclarationRest < Declaration
    def start
      -1
    end

    def type
      @type
    end

    def declare( t, scope )
      @type = t
      value scope
    end
  end

  class AssignmentChain < Treetop::Runtime::SyntaxNode
  end

  class AssignmentPart < Treetop::Runtime::SyntaxNode
  end

  class PrefixExpression < Treetop::Runtime::SyntaxNode
  end

  class PostfixExpression < Treetop::Runtime::SyntaxNode
  end

  class IncrementOperator < Treetop::Runtime::SyntaxNode
  end

  class DecrementOperator < Treetop::Runtime::SyntaxNode
  end

  class UnaryExpression < Treetop::Runtime::SyntaxNode
    def clause
      elements[1]
    end

    def operator
      elements[0]
    end

    def value( scope )
      operator.operate clause.value( scope )
    end
  end

  class InvertOperator < Treetop::Runtime::SyntaxNode
    def operate( clause_value )
      ~clause_value
    end
  end

  class NegationOperator < Treetop::Runtime::SyntaxNode
    def operate( clause_value )
      -clause_value
    end
  end

  class NullipotentOperator < Treetop::Runtime::SyntaxNode
    def operate( clause_value )
      +clause_value
    end
  end

  module AssignmentOperator
  end
end
