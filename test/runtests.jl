using Dagitty
using Test

@testset "Dagitty.jl" begin
    d = DAG(:A => :M, :A => :D, :M => :D)
    @test d.labels == [:A, :D, :M]
end
