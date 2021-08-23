# path grath
g = DAG(:A => :B, :B => :C)
@test is_d_separated(g, [1], [3], [2])
@test !is_d_separated(g, [1], [3], Int[])

# fork graph
g = DAG(:A => :B, :A => :C)
@test is_d_separated(g, [:B], [:C], [:A])
@test !is_d_separated(g, [:B], [:C], Symbol[])

# collider graph
g = DAG(:A => :B, :C => :B)
@test is_d_separated(g, [:A], [:C], Symbol[])
@test !is_d_separated(g, [:A], [:C], [:B])

# asia graph
g = DAG(
    :asia => :tuberculosis,
    :smoking => :cancer,
    :smoking => :bronchitis,
    :tuberculosis => :either,
    :cancer => :either,
    :either => :xray,
    :either => :dyspnea,
    :bronchitis => :dyspnea
)
# this test is wrong - dyspnea is in isolated component, but xray is on the main
@test !is_d_separated(g,
    [:asia, :smoking],
    [:dyspnea, :xray],
    [:bronchitis, :either]
)
@test is_d_separated(g,
    [:tuberculosis, :cancer],
    [:bronchitis],
    [:smoking, :xray]
)
