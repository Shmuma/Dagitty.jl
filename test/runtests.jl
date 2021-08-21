using Dagitty
using Test

tests = [
    "DAG",
    "implied_conditional_independencies"
]

for t ∈ tests
    @testset "$t" begin
        include("test_$(t).jl")
    end
end
