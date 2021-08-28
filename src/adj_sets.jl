all_backdoor_adjustment_sets(dag::DAG, x::Symbol, y::Symbol)::Vector{Vector{Symbol}} =
    nodes_labels.((dag, ), all_backdoor_adjustment_sets(dag, node(dag, x), node(dag, y)))

function all_backdoor_adjustment_sets(dag::DAG, x::Int, y::Int)::Vector{Vector{Int}}
    [Int[]]
end


export
    all_backdoor_adjustment_sets
