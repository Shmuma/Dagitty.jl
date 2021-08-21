"""
# node

Resolve node label in DAG
"""
node(dag::DAG, label::Symbol)::Union{Int,Nothing} = findfirst(x -> x == label, dag.labels)


export
    node
