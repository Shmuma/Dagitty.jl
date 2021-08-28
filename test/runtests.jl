using Dagitty
using Test

tests = [
    "DAG",
    "implied_conditional_independencies",
    "utils",
    "is_d_separated",
    "adj_sets",
]

for t ∈ tests
    @testset "$t" begin
        include("test_$(t).jl")
    end
end
