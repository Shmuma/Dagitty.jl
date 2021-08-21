using Dagitty
using Test

tests = [
    "DAG",
    "implied_conditional_independencies",
    "utils"
]

for t ∈ tests
    @testset "$t" begin
        include("test_$(t).jl")
    end
end
