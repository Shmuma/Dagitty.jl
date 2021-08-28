g = DAG(
    :X => :Y,
    :U => :X,
    :A => :U,
    :A => :C,
    :C => :Y,
    :U => :B,
    :C => :B
)

@test_broken all_backdoor_adjustment_sets(g, :X, :Y) == [[:C], [:A], [:U]]
