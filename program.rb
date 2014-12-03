require_relative "lib/tautology"

#Input
expressions = ["a","a & b","a | (b|c)","!a & !b","a | !a","(!a & (a | !a))" ,"(!a | (a & a))","(!a | (b & !a ))","(a | !a)","(a & (!b | b)) | (!a & (!b | b))"]

#Output
expressions.each do |exp|
  tt = Tautology.new(exp)
  p exp
  p tt.check_tautology
end
