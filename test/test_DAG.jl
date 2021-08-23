using LightGraphs

@testset "DAG.jl" begin
    d = DAG(:A => :M, :A => :D, :M => :D)
    @test d.labels == [:A, :D, :M]

    @test_throws DAGHasLoops DAG(:A => :B, :B => :A)
    @test_throws DAGHasLoops DAG(:A => :A)

    d = DAG(:A => :B, :A => :B)
    @test ne(d.graph) == 1
end
