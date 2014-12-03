require_relative 'expression_evaluator'

class Tautology
  attr_reader :expression, :variables

  # Initialize the expression and variables based on the expression passed
  # Original expression passed is stored in an instance variable
  # All letters are converted to lower case and variables are
  # extracted from the expression against the valid operators and stored in array
  # Duplicates variables are removed from the array
  # Check the cardinality of the passed expression
  def initialize(tautology_expression)
    @orginal_expression = tautology_expression
    @expression = tautology_expression.downcase
    temp_variables = ['(', ')', '&' , '|', '!'].inject(@expression){ |expression, operator| expression.gsub(operator, ' ') }
    @variables = temp_variables.gsub(/\s+/, '').split('').uniq
    check_cardinality
  end

  # Checks the expression passed for limit and invalid characters and raises error
  def check_cardinality
    @variables_length = @variables.length
    raise LimitExceededError if @variables_length > 10
    @variables.each do |v|
      raise InvalidExpressionError unless v =~ /^[a-zA-Z]*$/
    end
  end

  # Generates truthtable based on the number of variables passed
  def generate_truthtable_arrays(num)
    truthtable_arr = []
    truthtable_num = 2 ** num
    (0...(truthtable_num)).each do |i|
      temp_val = truthtable_num - 1 -i
      temp = Array.new(num)
      (0...num).each do |j|
        temp[j]  = temp_val[num - 1 -j ] == 1
      end
      truthtable_arr << temp
    end
    truthtable_arr
  end

  # Checks if the given expression is tautology or not
  def check_tautology
    tautology_arr = []
    generate_truthtable_arrays(@variables_length).each do |array|
      tautology_arr << "#{(evaluate_expression(array) ? 'T' : 'F')}"
    end
    return tautology_arr.include?("F") ? false : true unless tautology_arr.empty?
  end

  # Evaluates the expression with variables and truth table array
  def evaluate_expression(array)
    ExpressionEvaluator.new(@expression, Hash[@variables.zip(array)]).evaluate
  end
end


