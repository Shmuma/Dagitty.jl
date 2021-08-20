using Dagitty
using Test

tests = ["DAG"]

for t ∈ tests
    @testset "$t" begin
        include("test_$(t).jl")
    end
end
