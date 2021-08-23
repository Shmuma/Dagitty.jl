using Combinatorics
import Base: ==

"""
    ConditionalIndependence

Structure representing conditional independency between two variables given conditioned set of variables.
"""
struct ConditionalIndependence
    x::Symbol
    y::Symbol
    cond::Vector{Symbol}
end

==(a::ConditionalIndependence, b::ConditionalIndependence) = a.x == b.x && a.y == b.y && a.cond == b.cond

"""
    implied_conditional_independencies(dag)

From given DAG find all pair-wise conditional independencies of nodes.
Returns vector of `ConditionalIndependence` structures.

# Examples
```jldoctest
julia> using Dagitty

julia> g = DAG(:A => :C, :C => :B)
DAG: {3, 2} directed simple Int64 graph with labels [:A, :B, :C])

julia> implied_conditional_independencies(g)
1-element Vector{ConditionalIndependence}:
 ConditionalIndependence(:A, :B, [:C])
```
"""
function implied_conditional_independencies(dag::DAG)::Vector{ConditionalIndependence}
    max_set = length(dag.labels) - 2
    result = Vector{ConditionalIndependence}()
    nodes = Base.OneTo(length(dag.labels))
    # TODO: check that combinations is enough for check. I have a feeling we have to check all unordered pairs of nodes,
    # but combinations returns only ordered ones
    for (n1, n2) ∈ combinations(nodes, 2)
    # for n1 ∈ nodes, n2 ∈ nodes
    #     n1 == n2 && continue
        rest = [n for n ∈ nodes if n != n1 && n != n2]
        for cond ∈ powerset(rest, 1, max_set)
            if is_d_separated(dag, [n1], [n2], cond)
                ci = ConditionalIndependence(dag.labels[n1], dag.labels[n2], dag.labels[cond])
                push!(result, ci)
            end
        end
    end
    result
end


export
    ConditionalIndependence,
    implied_conditional_independencies
