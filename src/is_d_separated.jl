function is_d_separated(dag::DAG, var1::Symbol, var2::Symbol, vars::Union{Set{Symbol}, Vector{Symbol}})::Bool
    n1 = node(dag, var1)
    n2 = node(dag, var2)
    cond_nodes = Set(map(v -> node(dag, v), vars))
    is_d_separated(dag, n1, n2, cond_nodes)
end

is_d_separated(dag::DAG, n1::Int, n2::Int, cond::Vector{Int})::Bool = is_d_separated(dag, n1, n2, Set(cond))

function is_d_separated(dag::DAG, n1::Int, n2::Int, cond::Set{Int})::Bool
    println("Check d-separation of $n1 with $n2 conditioned on $cond")
    all(p -> _path_d_separated(dag, p, cond), all_simple_paths(dag.graph, n1, n2))
end

function _path_d_separated(dag::DAG, path::Vector{Int}, cond::Set{Int})::Bool
    println("$path")
    false
end


export
    is_d_separated
