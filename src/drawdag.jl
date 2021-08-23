using GraphPlot

"""
    drawdag(dag; layout=spring_layout, ...)

Draws dag with given layout method (check GraphPlot package for their description)
"""
drawdag(dag::DAG; layout::Function=spring_layout, keyargs...) =
    drawdag(dag, layout(dag.graph)...; keyargs...)

"""
    drawdag(dag, locs_x, locs_y)

Draws dag with given locations of every node

# Examples

```julia
julia> g = DAG(:A => :C, :C => :B)
DAG: {3, 2} directed simple Int64 graph with labels [:A, :B, :C])

julia> drawdag(g, [0, 0, 1], [0, 1, 1])
```
"""
function drawdag(dag::DAG, locs_x, locs_y; keyargs...)
    gplot(dag.graph, locs_x, locs_y; nodelabel=dag.labels)
end

export
    drawdag
