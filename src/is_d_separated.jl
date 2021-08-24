"""
    is_d_separated(dag, x, y, cond)

Checks that X variables are independent on Y variables being conditioned on third set of variables.
Three sets could be given as vectors of node labels (`Symbol`) or as vectors of node indices in the underlying graph.
Used NetworkX `d_separated` implementation.

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
```
"""
function is_d_separated(dag::DAG, x::Vector{Symbol}, y::Vector{Symbol}, cond::Vector{Symbol})::Bool
    f = v -> node(dag, v)
    is_d_separated(dag, Vector{Int}(map(f, x)), Vector{Int}(map(f, y)), Vector{Int}(map(f, cond)))
end


function is_d_separated(dag::DAG, x::Vector{Int}, y::Vector{Int}, cond::Vector{Int})::Bool
    gr = SimpleDiGraph(dag.graph)
    in_xyz = n -> (n ∈ x || n ∈ y || n ∈ cond)
    leaves = [n for n in vertices(gr) if outdegree(gr, n) == 0]

    while !isempty(leaves)
        leaf = popfirst!(leaves)
        in_xyz(leaf) && continue
        for n ∈ collect(inneighbors(gr, leaf))
            rem_edge!(gr, n, leaf)
            if outdegree(gr, n) == 0
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

    comps = weakly_connected_components(gr)
    x_comps = map(c -> !isempty(intersect(c, x)), comps)
    y_comps = map(c -> !isempty(intersect(c, y)), comps)
    !any(x_comps .& y_comps)
end

export
    is_d_separated
