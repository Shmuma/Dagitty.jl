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
    for (n1, n2) ∈ combinations(nodes, 2)
        rest = [n for n ∈ nodes if n != n1 && n != n2]
        for cond ∈ powerset(rest)
            if is_d_separated(dag, [n1], [n2], cond)
                ci = ConditionalIndependence(dag.labels[n1], dag.labels[n2], dag.labels[cond])
                push!(result, ci)
            end
        end
    end
    result
end


"""
    implied_conditional_independencies_min

From given DAG return all pair-wise conditional independencies of nodes with
minimal condition set.

# Examples
```jldoctest
julia> using Dagitty

julia> plant_dag = Dagitty.DAG(:H_0 => :H_1, :F => :H_1, :T => :F)
DAG: {4, 3} directed simple Int64 graph with labels [:F, :H_0, :H_1, :T])

julia> implied_conditional_independencies_min(plant_dag)
3-element Vector{ConditionalIndependence}:
 ConditionalIndependence(:F, :H_0, Symbol[])
 ConditionalIndependence(:H_0, :T, Symbol[])
 ConditionalIndependence(:H_1, :T, [:F])

```
"""
function implied_conditional_independencies_min(dag::DAG)::Vector{ConditionalIndependence}
    s = implied_conditional_independencies(dag)
    [
        a for a ∈ s
        if !any(b -> b.x == a.x && b.y == a.y && b.cond != a.cond && b.cond ⊆ a.cond, s)
    ]
end


export
    ConditionalIndependence,
    implied_conditional_independencies,
    implied_conditional_independencies_min
