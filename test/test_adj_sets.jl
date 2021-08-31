g = DAG(:X => :Y, :U => :X, :A => :U, :A => :C, :C => :Y, :U => :B, :C => :B)

@test all_backdoor_adjustment_sets(g, :X, :Y) == [[:A], [:C], [:U]]

@test is_valid_backdoor_adjustment_set(g, node(g, :X), node(g, :Y), nodes_indices(g, [:C]))
@test is_valid_backdoor_adjustment_set(g, node(g, :X), node(g, :Y), nodes_indices(g, [:A]))
@test is_valid_backdoor_adjustment_set(g, node(g, :X), node(g, :Y), nodes_indices(g, [:U]))
