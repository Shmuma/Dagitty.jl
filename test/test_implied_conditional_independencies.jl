g = DAG(:A => :M, :A => :D)

@test implied_conditional_independencies(g) == []
