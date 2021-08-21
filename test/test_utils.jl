g = DAG(:A => :M, :A => :D, :M => :D)

@test node(g, :A) == 1
@test isnothing(node(g, :U))
