function is_d_separated(dag::DAG, var1::Symbol, var2::Symbol, vars::Union{Set{Symbol}, Vector{Symbol}})::Bool
    n1 = node(dag, var1)
    n2 = node(dag, var2)
    cond_nodes = map(v -> node(dag, v), vars)
    is_d_separated(dag, n1, n2, cond_nodes)
end

function is_d_separated(dag::DAG, n1::Int, n2::Int, vars::Union{Set{Int}, Vector{Int}})::Bool
    println("Check d-separation of $n1 with $n2 conditioned on $vars")
    false
end


export
    is_d_separated
