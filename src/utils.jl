"""
    node(dag, label)

Resolve node label in DAG: by node label return underlying graph node index

# Examples
```jldoctest
julia> using Dagitty

julia> g = DAG(:A => :C, :C => :B)
DAG: {3, 2} directed simple Int64 graph with labels [:A, :B, :C])

julia> node(g, :C)
3
```
"""
node(dag::DAG, label::Symbol)::Union{Int,Nothing} = findfirst(x -> x == label, dag.labels)


export
    node
