function is_d_separated(dag::DAG, x::Vector{Symbol}, y::Vector{Symbol}, cond::Vector{Symbol})::Bool
    f = v -> node(dag, v)
    is_d_separated(dag, map(f, x), map(f, y), map(f, cond))
end

function is_d_separated(dag::DAG, x::Vector{Int}, y::Vector{Int}, cond::Vector{Int})::Bool
    xyz = Set(union(x, y, cond))
    gr = SimpleDiGraph(dag.graph)
    leaves = [n for n in vertices(gr) if outdegree(gr, n) == 0]

    while !isempty(leaves)
        leaf = popfirst!(leaves)
        leaf ∈ xyz && continue
        for n ∈ inneighbors(gr, leaf)
            if outdegree(gr, n) == 1
                push!(leaves, n)
            end
        end
        rem_vertex!(gr, leaf)
    end

    # remove edges from Z set
    for s ∈ cond
        for d ∈ outneighbors(gr, s)
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
