using Combinatorics

"""
    all_backdoor_adjustment_sets(dag, x, y)

Obtain all sets of variables to be controlled to close backdoor paths from variable x to y.
"""
all_backdoor_adjustment_sets(dag::DAG, x::Symbol, y::Symbol)::Vector{Vector{Symbol}} =
    nodes_labels.((dag, ), all_backdoor_adjustment_sets(dag, node(dag, x), node(dag, y)))

function all_backdoor_adjustment_sets(dag::DAG, x::Int, y::Int)::Vector{Vector{Int}}
    is_valid_backdoor_adjustment_set(dag, x, y, Int[]) && return [Int[]]

    possible_vars = Int[]
    for (idx, parent) ∈ enumerate(bfs_parents(dag.graph, x))
        parent > 0 && continue
        idx == y && continue
        push!(possible_vars, idx)
    end

    valid_sets::Vector{Vector{Int}} = []
    for s ∈ powerset(possible_vars, 1)
        super_complete = Bool[]
        for vs ∈ valid_sets
            push!(super_complete, intersect(vs, s) == vs)
        end
        any(super_complete) && continue
        if is_valid_backdoor_adjustment_set(dag, x, y, s)
            push!(valid_sets, s)
        end
    end
    valid_sets
end


"""
    is_valid_backdoor_adjustment_set

Checks that given set z is a valid "backdoor adjustment set", i.e.
z being observed disconnects x from y.
"""
is_valid_backdoor_adjustment_set(dag::DAG, x::Int, y::Int, z::Vector{Int})::Bool =
    is_d_separated(dag, [x], [y], union(z, [x]), ignore_edges=[x => y])

export
    all_backdoor_adjustment_sets,
    is_valid_backdoor_adjustment_set
