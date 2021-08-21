g = DAG(:A => :M, :A => :D, :M => :D)
@test implied_conditional_independencies(g) == []

g = DAG(:A => :M, :A => :D)
r = implied_conditional_independencies(g)

@test r == [ConditionalIndependence(:D, :M, [:A])]
