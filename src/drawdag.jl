using GraphPlot

drawdag(dag::DAG; layout::Function=spring_layout, keyargs...) =
    drawdag(dag, layout(dag.graph)...; keyargs...)

function drawdag(dag::DAG, locs_x, locs_y; keyargs...)
    gplot(dag.graph, locs_x, locs_y; nodelabel=dag.labels)
end

export
    drawdag
