using LightGraphs
using Base.Iterators: Iterators


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
        # TODO: check for cycles (just in case)
        add_edge!(graph, lab_indices[a], lab_indices[b])
    end
    DAG(graph, labels)
end

function Base.show(io::IO, g::DAG)
    println(io, "DAG: $(g.graph) with labels $(g.labels))")
end
