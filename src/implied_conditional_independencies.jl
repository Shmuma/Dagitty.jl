using Combinatorics

struct ConditionalIndependence
    var1::Symbol
    var2::Symbol
    cond::Set{Symbol}
end

function implied_conditional_independencies(dag::DAG)::Vector{ConditionalIndependence}
    max_set = length(dag.labels) - 2
    result = Vector{ConditionalIndependence}()
    nodes = Base.OneTo(length(dag.labels))
    for (n1, n2) ∈ combinations(nodes, 2)
        rest = [n for n ∈ nodes if n != n1 && n != n2]
        for cond ∈ powerset(rest, 1, max_set)
            if is_d_separated(dag, n1, n2, cond)
                push!(ConditionalIndependence(var1, var2, cond))
            end
        end
    end
    result
end


export
    ConditionalIndependence,
    implied_conditional_independencies
