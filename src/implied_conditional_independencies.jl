using Combinatorics
import Base: ==

struct ConditionalIndependence
    var1::Symbol
    var2::Symbol
    cond::Vector{Symbol}
end

==(a::ConditionalIndependence, b::ConditionalIndependence) = a.var1 == b.var1 && a.var2 == b.var2 && a.cond == b.cond

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
