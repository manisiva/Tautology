require "test/unit"
require_relative "../lib/tautology"

class TestTautology < Test::Unit::TestCase

  # Test for expression and variables
  def test_expression
    tt = Tautology.new("(a & b) | c")
    assert_equal "(a & b) | c", tt.expression
    assert_equal ["a", "b", "c"], tt.variables
  end

  # Test for truthtables
  def test_truthtable_arrays
    tt = Tautology.new("a")
    arr_1 = [[true], [false]]
    assert_equal arr_1, tt.generate_truthtable_arrays(1)
    tt = Tautology.new("a & b")
    arr_2 = [[true, true], [true, false], [false, true], [false, false]]
    assert_equal arr_2, tt.generate_truthtable_arrays(2)
  end

  # Test expressions
  def test_evaluate_expression
    tt = Tautology.new("a")
    arr_1 =  [false]
    assert_equal false, tt.evaluate_expression(arr_1)
    tt = Tautology.new("a | !a")
    arr_2 = [true]
    assert_equal true, tt.evaluate_expression(arr_2)
  end

  # Test tautology of an expression
  def test_tautology
    tt = Tautology.new("a")
    assert_equal(false, tt.check_tautology)
    tt = Tautology.new("a & b")
    assert_equal(false, tt.check_tautology)
    tt = Tautology.new("(!a | (a & a))")
    assert_equal(true, tt.check_tautology)
  end

  # Test Exception Raised
  def test_raise_expression
    assert_raise( InvalidExpressionError ) { Tautology.new('a1') }
    assert_raise( InvalidExpressionError ) { Tautology.new('a @ !a') }
    assert_raise( LimitExceededError ) { Tautology.new('(a | ( b &  c) | ( d & e) | ( (f | g ) & (h & i)) | !a | ( j | k) )') }
  end

end
