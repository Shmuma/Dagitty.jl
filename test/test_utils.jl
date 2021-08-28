g = DAG(:A => :M, :A => :D, :M => :D)

@test node(g, :A) == 1
@test_throws LabelNotFound(:U) node(g, :U)

@test nodes_indices(g, [:A, :M]) == [1, 3]
@test_throws LabelNotFound(:X) nodes_indices(g, [:A, :X])

@test nodes_labels(g, [1, 3]) == [:A, :M]
