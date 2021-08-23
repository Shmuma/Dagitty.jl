using Dagitty

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
println("Before test")
r = is_d_separated(g,
    [:asia, :smoking],
    [:dyspnea, :xray],
    [:bronchitis, :either]
)
# r = is_d_separated(g,
#     [:tuberculosis, :cancer],
#     [:bronchitis],
#     [:smoking, :xray]
# )
println("Result: $r")
