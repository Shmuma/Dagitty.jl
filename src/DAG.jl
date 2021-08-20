using LightGraphs
using Base.Iterators: Iterators

struct DAGHasLoops <: Exception end

struct DAG
    graph::SimpleDiGraph
    labels::Vector{Symbol}
end

DAG(edges::Pair{Symbol, Symbol}...) = DAG(edges)

function DAG(edges)
    labels = unique(Iterators.flatten(edges))
    sort!(labels)
    vert_count = length(labels)
    lab_indices = Dict(zip(labels, Base.OneTo(vert_count)))
    graph = SimpleDiGraph(vert_count)
    for (a, b) ∈ edges
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
    DAGHasLoops
