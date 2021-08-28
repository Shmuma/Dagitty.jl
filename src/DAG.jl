using LightGraphs

"""
    DAGHasLoops

Exception, thrown when loops are detected on DAG construction.

# Examples
```jldoctest
julia> using Dagitty

julia> g = DAG(:A => :B, :B => :A)
ERROR: DAGHasLoops()
```
"""
struct DAGHasLoops <: Exception end

"""
    LabelNotFound

Exception thrown on attempt to resolve label which is not present in the DAG.

# Examples
```jldoctest
julia> using Dagitty

julia> g = DAG(:A => :B)
DAG: {2, 1} directed simple Int64 graph with labels [:A, :B])

julia> node(g, :C)
"""
struct LabelNotFound <: Exception
    label::Symbol
end

"""
    DAG

Structure with fields:
* `graph::SimpleDiGraph` - underlying directed graph
* `labels::Vector{Symbol}` - vector of each nodes' label

Could be constructed by passing list of `Pair{Symbol, Symbol}`

# Examples
```jldoctest
julia> using Dagitty

julia> g = DAG(:A => :B)
DAG: {2, 1} directed simple Int64 graph with labels [:A, :B])

julia> g.graph
{2, 1} directed simple Int64 graph

julia> g.labels
2-element Vector{Symbol}:
 :A
 :B

julia> g = DAG(:A => :A)
ERROR: DAGHasLoops()
```
"""
struct DAG
    graph::SimpleDiGraph
    labels::Vector{Symbol}
end

DAG(edges::Pair{Symbol, Symbol}...) = DAG(edges)

function DAG(edges)
    labels = collect(unique(Iterators.flatten(edges)))
    sort!(labels)
    vert_count = length(labels)
    lab_indices = Dict(zip(labels, Base.OneTo(vert_count)))
    graph = SimpleDiGraph(vert_count)
    for (a, b) ∈ edges
        has_edge(graph, a, b) && continue
        add_edge!(graph, lab_indices[a], lab_indices[b])
    end
    simplecyclescount(graph) > 0 && throw(DAGHasLoops())
    DAG(graph, labels)
end

function Base.show(io::IO, g::DAG)
    println(io, "DAG: $(g.graph) with labels $(g.labels))")
end


export
    DAG,
    DAGHasLoops,
    LabelNotFound
