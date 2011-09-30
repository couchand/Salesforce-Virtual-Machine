module Apex
  class IntegerLiteral < Treetop::Runtime::SyntaxNode
    def value
      text_value.to_i
    end
  end

  class StringLiteral < Treetop::Runtime::SyntaxNode
    def value
      text_value.to_s[1..-2]
    end
  end

  class NullLiteral < Treetop::Runtime::SyntaxNode
    def value
      nil
    end
  end

  class TrueLiteral < Treetop::Runtime::SyntaxNode
    def value
      true
    end
  end

  class FalseLiteral < Treetop::Runtime::SyntaxNode
    def value
      false
    end
  end

  class Declaration < Treetop::Runtime::SyntaxNode
    def type
      elements[0]
    end
    def name
      elements[1]
    end
  end

  class Identifier < Treetop::Runtime::SyntaxNode
  end

  class ParenthesizedExpression < Treetop::Runtime::SyntaxNode
    def subexpression
      elements[0]
    end

    def value
      subexpression.value
    end
  end

  class LogicalOrExpression < Treetop::Runtime::SyntaxNode
    def head_condition
      elements[0]
    end

    def tail_condition
      elements[1]
    end

    def value
      if head_condition.value
        true
      elsif tail_condition.value
        true
      else
        false
      end
    end
  end

  class LogicalAndExpression < Treetop::Runtime::SyntaxNode
    def head_condition
      elements[0]
    end

    def tail_condition
      elements[1]
    end

    def value
      if !head_condition.value
        false
      elsif !tail_condition.value
        false
      else
        true
      end
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

    def value
      operator.operate left_clause.value, right_clause.value
    end
  end

  class EqualsOperator < Treetop::Runtime::SyntaxNode
    def operate( left_value, right_value )
      if left_value == right_value
        true
      else
        false
      end
    end
  end

  class NotEqualsOperator < Treetop::Runtime::SyntaxNode
    def operate( left_value, right_value )
      if left_value == right_value
        false
      else
        true
      end
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
      if left_value < right_value
        true
      else
        false
      end
    end
  end

  class GreaterOrEqualsOperator < Treetop::Runtime::SyntaxNode
    def operate( left_value, right_value )
      if left_value < right_value
        false
      else
        true
      end
    end
  end

  class LessOrEqualsOperator < Treetop::Runtime::SyntaxNode
    def operate( left_value, right_value )
      if left_value > right_value
        false
      else
        true
      end
    end
  end

  class GreaterThanOperator < Treetop::Runtime::SyntaxNode
    def operate( left_value, right_value )
      if left_value > right_value
        true
      else
        false
      end
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

    def value
      if condition.value
        true_clause.value
      else
        false_clause.value
      end
    end
  end

  class AssignmentExpression < Treetop::Runtime::SyntaxNode
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

    def value
      operator.operate clause.value
    end
  end

  class InvertOperator < Treetop::Runtime::SyntaxNode
    def operate( clause_value )
      !clause_value
    end
  end

  class NegationOperator < Treetop::Runtime::SyntaxNode
    def operate( clause_value )
      -clause_value
    end
  end

  class NullipotentOperator < Treetop::Runtime::SyntaxNode
    def operate( clause_value )
      clause_value
    end
  end

  module AssignmentOperator
  end
end
