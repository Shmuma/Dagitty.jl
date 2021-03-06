using BenchmarkTools
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

print("test1:")
b1 = @btime is_d_separated(g,
    [:asia, :smoking],
    [:dyspnea, :xray],
    [:bronchitis, :either]
)

print("test2:")
b2 = @btime is_d_separated(g,
    [:tuberculosis, :cancer],
    [:bronchitis],
    [:smoking, :xray]
)
