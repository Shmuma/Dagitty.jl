g = DAG(:X => :Y, :U => :X, :A => :U, :A => :C, :C => :Y, :U => :B, :C => :B)

@test all_backdoor_adjustment_sets(g, :X, :Y) == [[:A], [:C], [:U]]

@test is_valid_backdoor_adjustment_set(g, node(g, :X), node(g, :Y), nodes_indices(g, [:C]))
@test is_valid_backdoor_adjustment_set(g, node(g, :X), node(g, :Y), nodes_indices(g, [:A]))
@test is_valid_backdoor_adjustment_set(g, node(g, :X), node(g, :Y), nodes_indices(g, [:U]))

# Waffles example from Rethinking book
g = DAG(:S => :W, :S => :A, :S => :M, :A => :M, :M => :D, :A => :D, :W => :D)
@test all_backdoor_adjustment_sets(g, :W, :D) == [[:S], [:A, :M]]

# Another example
g = DAG(:E => :W, :U => :W)
@test all_backdoor_adjustment_sets(g, :E, :W) == [Symbol[]]

# test from rethinking
g = DAG(:X => :Y, :X => :Z, :Z => :Y, :A => :Z, :A => :X)
@test all_backdoor_adjustment_sets(g, :X, :Y) == [[:A]]
