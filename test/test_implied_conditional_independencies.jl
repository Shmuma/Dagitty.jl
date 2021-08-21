g = DAG(:A => :M, :A => :D, :M => :D)
r = implied_conditional_independencies(g)
println(r)

@test true
