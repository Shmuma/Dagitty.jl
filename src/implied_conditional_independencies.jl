using Combinatorics

struct ConditionalIndependence
    var1::Symbol
    var2::Symbol
    cond::Set{Symbol}
end

function implied_conditional_independencies(dag::DAG)::Vector{ConditionalIndependence}
    max_set = length(dag.labels) - 2
    for (var1, var2) ∈ combinations(dag.labels, 2)
        rest = [l for l ∈ dag.labels if l != var1 && l != var2]
        for cond ∈ powerset(rest, 1, max_set)
            println("Checking d-separability of $var1 against $var2 given $cond")
        end
    end
    []
end


export
    ConditionalIndependence,
    implied_conditional_independencies
