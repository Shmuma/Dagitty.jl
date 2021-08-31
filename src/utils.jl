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
function node(dag::DAG, label::Symbol)::Int
    r = findfirst(x -> x == label, dag.labels)
    isnothing(r) && throw(LabelNotFound(label))
    r
end


"""
    nodes_indices(dag, labels)

Convert vector of node labels to vector of underlying graph node indices

# Examples
```
julia> using Dagitty

julia> g = DAG(:A => :C, :C => :B)
DAG: {3, 2} directed simple Int64 graph with labels [:A, :B, :C])

julia> nodes_indices(g, [:A, :C])
2-element Vector{Int64}:
 1
 3

```
"""
nodes_indices(dag::DAG, labels::Vector{Symbol})::Vector{Int} = Vector{Int}(node.((dag,), labels))

"""
    nodes_labels(dag, indices)

From vector of indices return vector of node labels.

# Examples
```
julia> using Dagitty

julia> g = DAG(:A => :C, :C => :B)
DAG: {3, 2} directed simple Int64 graph with labels [:A, :B, :C])

julia> nodes_labels(g, [1, 3])
2-element Vector{Symbol}:
 :A
 :C

```
"""
nodes_labels(dag::DAG, indices::Vector{Int})::Vector{Symbol} = dag.labels[indices]


"""
    edges_indicse(dag, edges)

Convert list of edges (pairs of symbols) into list of node indices' pairs.

# Examples
```jldoctest
julia> using Dagitty

julia> g = DAG(:A => :B)
DAG: {2, 1} directed simple Int64 graph with labels [:A, :B])

julia> edges_indices(g, [:A => :B, :B => :A])
2-element Vector{Pair{Int64, Int64}}:
 1 => 2
 2 => 1
```
"""
edges_indices(dag::DAG, edges::Vector{DAGEdge})::Vector{Pair{Int, Int}} =
    map(e -> node(dag, e[1]) => node(dag, e[2]), edges)

export
    node,
    nodes_indices,
    nodes_labels,
    edges_indices
