"""
    is_d_separated(dag, x, y, cond; ignore_edges)

Checks that X variables are independent on Y variables being conditioned on third set of variables.
Three sets could be given as vectors of node labels (`Symbol`) or as vectors of node indices in the underlying graph.
Used NetworkX `d_separated` implementation.

Argument `ignore_edges` can contain list of node pairs of edges to be ignored during the test.

# Examples
```jldoctest
julia> using Dagitty

julia> g = DAG(:A => :C, :C => :B)
DAG: {3, 2} directed simple Int64 graph with labels [:A, :B, :C])

julia> is_d_separated(g, [:A], [:B], [:C])
true

julia> is_d_separated(g, [:A], [:C], [:B])
false

julia> is_d_separated(g, [1], [2], [3])
true

julia> g = DAG(:A => :B, :A => :C, :C => :B)
DAG: {3, 3} directed simple Int64 graph with labels [:A, :B, :C])

julia> is_d_separated(g, [:A], [:B], [:C], ignore_edges=[:A => :B])
true

```
"""
is_d_separated(
    dag::DAG, x::Vector{Symbol}, y::Vector{Symbol}, cond::Vector{Symbol};
    ignore_edges::Vector{DAGEdge} = DAGEdge[]
)::Bool =
    is_d_separated(
        dag,
        nodes_indices(dag, x),
        nodes_indices(dag, y),
        nodes_indices(dag, cond),
        ignore_edges=edges_indices(dag, ignore_edges)
    )

# TODO: Have a feeling that this code could be optimized:
# * why do we remove leaves? They are influence nothing
# * why we're removing in edjes to Z, but not Z nodes completely?
# So, looks like we can get the same in simpler method:
# - remove z nodes from DAG
# - find connected components
# - check that x and y are belong to different components
function is_d_separated(
    dag::DAG, x::Vector{Int}, y::Vector{Int}, cond::Vector{Int};
    ignore_edges::Vector{Pair{Int, Int}} = Pair{Int,Int}[]
)::Bool
    gr = SimpleDiGraph(dag.graph)
    in_xyz = n -> (n ∈ x || n ∈ y || n ∈ cond)
    leaves = [n for n in vertices(gr) if !in_xyz(n) && outdegree(gr, n) == 0]

    while !isempty(leaves)
        leaf = popfirst!(leaves)
        for n ∈ collect(inneighbors(gr, leaf))
            rem_edge!(gr, n, leaf)
            if !in_xyz(n) && outdegree(gr, n) == 0
                push!(leaves, n)
            end
        end
        for d ∈ collect(outneighbors(gr, leaf))
            rem_edge!(gr, leaf, d)
        end
    end

    # remove edges from Z set
    for s ∈ cond
        for d ∈ collect(outneighbors(gr, s))
            rem_edge!(gr, s, d)
        end
    end

    # remove edges we were asked to remove
    for (s, d) ∈ ignore_edges
        rem_edge!(gr, s, d)
    end

    comps = weakly_connected_components(gr)
    x_comps = map(c -> !isempty(intersect(c, x)), comps)
    y_comps = map(c -> !isempty(intersect(c, y)), comps)
    !any(x_comps .& y_comps)
end

export
    is_d_separated
