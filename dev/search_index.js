var documenterSearchIndex = {"docs":
[{"location":"DAG/#DAG","page":"DAG","title":"DAG","text":"","category":"section"},{"location":"DAG/","page":"DAG","title":"DAG","text":"Directed Acyclic Graph with labeled nodes. This structure is a very thin wrapper around SimpleDiGraph from LightGraphs package.","category":"page"},{"location":"DAG/","page":"DAG","title":"DAG","text":"DAG\nDAGHasLoops","category":"page"},{"location":"DAG/#Dagitty.DAG","page":"DAG","title":"Dagitty.DAG","text":"DAG\n\nStructure with fields:\n\ngraph::SimpleDiGraph - underlying directed graph\nlabels::Vector{Symbol} - vector of each nodes' label\n\nCould be constructed by passing list of Pair{Symbol, Symbol}\n\nExamples\n\njulia> using Dagitty\n\njulia> g = DAG(:A => :B)\nDAG: {2, 1} directed simple Int64 graph with labels [:A, :B])\n\njulia> g.graph\n{2, 1} directed simple Int64 graph\n\njulia> g.labels\n2-element Vector{Symbol}:\n :A\n :B\n\njulia> g = DAG(:A => :A)\nERROR: DAGHasLoops()\n\n\n\n\n\n","category":"type"},{"location":"DAG/#Dagitty.DAGHasLoops","page":"DAG","title":"Dagitty.DAGHasLoops","text":"DAGHasLoops\n\nException, thrown when loops are detected on DAG construction.\n\nExamples\n\njulia> using Dagitty\n\njulia> g = DAG(:A => :B, :B => :A)\nERROR: DAGHasLoops()\n\n\n\n\n\n","category":"type"},{"location":"d_separation/#D-separation","page":"D-separation","title":"D-separation","text":"","category":"section"},{"location":"d_separation/","page":"D-separation","title":"D-separation","text":"D-Separation is a method to find from causal DAG which variables are indendent on each other given some set of conditioned variables.","category":"page"},{"location":"d_separation/","page":"D-separation","title":"D-separation","text":"is_d_separated\nConditionalIndependence\nimplied_conditional_independencies","category":"page"},{"location":"d_separation/#Dagitty.is_d_separated","page":"D-separation","title":"Dagitty.is_d_separated","text":"is_d_separated(dag, x, y, cond)\n\nChecks that X variables are independent on Y variables being conditioned on third set of variables. Three sets could be given as vectors of node labels (Symbol) or as vectors of node indices in the underlying graph. Used NetworkX d_separated implementation.\n\nExamples\n\njulia> using Dagitty\n\njulia> g = DAG(:A => :C, :C => :B)\nDAG: {3, 2} directed simple Int64 graph with labels [:A, :B, :C])\n\njulia> is_d_separated(g, [:A], [:B], [:C])\ntrue\n\njulia> is_d_separated(g, [:A], [:C], [:B])\nfalse\n\njulia> is_d_separated(g, [1], [2], [3])\ntrue\n\n\n\n\n\n","category":"function"},{"location":"d_separation/#Dagitty.ConditionalIndependence","page":"D-separation","title":"Dagitty.ConditionalIndependence","text":"ConditionalIndependence\n\nStructure representing conditional independency between two variables given conditioned set of variables.\n\n\n\n\n\n","category":"type"},{"location":"d_separation/#Dagitty.implied_conditional_independencies","page":"D-separation","title":"Dagitty.implied_conditional_independencies","text":"implied_conditional_independencies(dag)\n\nFrom given DAG find all pair-wise conditional independencies of nodes. Returns vector of ConditionalIndependence structures.\n\nExamples\n\njulia> using Dagitty\n\njulia> g = DAG(:A => :C, :C => :B)\nDAG: {3, 2} directed simple Int64 graph with labels [:A, :B, :C])\n\njulia> implied_conditional_independencies(g)\n1-element Vector{ConditionalIndependence}:\n ConditionalIndependence(:A, :B, [:C])\n\n\n\n\n\n","category":"function"},{"location":"d_separation/#Benchmark-of-D-separation","page":"D-separation","title":"Benchmark of D-separation","text":"","category":"section"},{"location":"d_separation/","page":"D-separation","title":"D-separation","text":"I've done simple benchmark on \"asia graph\" (taken from NetworkX test suite). Code is in bench/t1.{py,jl}. Results:","category":"page"},{"location":"d_separation/","page":"D-separation","title":"D-separation","text":"Python:","category":"page"},{"location":"d_separation/","page":"D-separation","title":"D-separation","text":"test1: 82.38 us\ntest2: 81.57 us","category":"page"},{"location":"d_separation/","page":"D-separation","title":"D-separation","text":"Julia:","category":"page"},{"location":"d_separation/","page":"D-separation","title":"D-separation","text":"test1:  8.322 μs (194 allocations: 16.67 KiB)\ntest2:  9.539 μs (225 allocations: 19.23 KiB)","category":"page"},{"location":"#Dagitty.jl","page":"Dagitty.jl","title":"Dagitty.jl","text":"","category":"section"},{"location":"","page":"Dagitty.jl","title":"Dagitty.jl","text":"This project started as rewrite of Dagitty R package on Julia language. The main motivation was porting of \"Statistical Rethinking\" book examples to Julia, which could be found on this website: shmuma.github.io/rethinking-2ed-julia. So, methods from Dagitty R package are being ported on \"as needed\" basis.","category":"page"},{"location":"","page":"Dagitty.jl","title":"Dagitty.jl","text":"At the moment, package provides the following functionality:","category":"page"},{"location":"","page":"Dagitty.jl","title":"Dagitty.jl","text":"Declaration of DAGs as set of labelled nodes and edges\nDrawing of those DAGs using GraphPlot package\nCheck for D-separation between two sets of nodes conditioned on third set of nodes\nDiscovery of pairwise conditional independent variables.","category":"page"},{"location":"#Basic-examples","page":"Dagitty.jl","title":"Basic examples","text":"","category":"section"},{"location":"","page":"Dagitty.jl","title":"Dagitty.jl","text":"julia> g = DAG(:A => :D, :A => :M)\nDAG: {3, 2} directed simple Int64 graph with labels [:A, :D, :M])\n\n# Draw DAG\njulia> drawdag(g)","category":"page"},{"location":"","page":"Dagitty.jl","title":"Dagitty.jl","text":"(Image: DAG visualisation)","category":"page"},{"location":"","page":"Dagitty.jl","title":"Dagitty.jl","text":"julia> implied_conditional_independencies(g)\n1-element Vector{ConditionalIndependence}:\n ConditionalIndependence(:D, :M, [:A])","category":"page"},{"location":"utils/#Utilities","page":"Utilities","title":"Utilities","text":"","category":"section"},{"location":"utils/","page":"Utilities","title":"Utilities","text":"Below is the documentation of several utility functions which are hard to put in some specific category.","category":"page"},{"location":"utils/","page":"Utilities","title":"Utilities","text":"node\ndrawdag","category":"page"},{"location":"utils/#Dagitty.node","page":"Utilities","title":"Dagitty.node","text":"node(dag, label)\n\nResolve node label in DAG: by node label return underlying graph node index\n\nExamples\n\njulia> using Dagitty\n\njulia> g = DAG(:A => :C, :C => :B)\nDAG: {3, 2} directed simple Int64 graph with labels [:A, :B, :C])\n\njulia> node(g, :C)\n3\n\n\n\n\n\n","category":"function"},{"location":"utils/#Dagitty.drawdag","page":"Utilities","title":"Dagitty.drawdag","text":"drawdag(dag; layout=spring_layout, ...)\n\nDraws dag with given layout method (check GraphPlot package for their description)\n\n\n\n\n\ndrawdag(dag, locs_x, locs_y)\n\nDraws dag with given locations of every node\n\nExamples\n\njulia> g = DAG(:A => :C, :C => :B)\nDAG: {3, 2} directed simple Int64 graph with labels [:A, :B, :C])\n\njulia> drawdag(g, [0, 0, 1], [0, 1, 1])\n\n\n\n\n\n","category":"function"}]
}