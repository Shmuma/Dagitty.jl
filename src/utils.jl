"""
    node(dag, label)

Resolve node label in DAG: by node label return underlying graph node index
"""
node(dag::DAG, label::Symbol)::Union{Int,Nothing} = findfirst(x -> x == label, dag.labels)


export
    node
