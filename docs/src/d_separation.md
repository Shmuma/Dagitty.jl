# D-separation

D-Separation is a method to find from causal DAG which variables are indendent on each other given some set of conditioned variables.

## Benchmark of D-separation

I've done simple benchmark on "asia graph" (taken from NetworkX test suite). Code is in `bench/t1.{py,jl}`. Results:

Python:
```
test1: 95.59 us
test2: 97.65 us
```

Julia:
```
test1: 10.191 μs (205 allocations: 17.78 KiB)
test2: 11.556 μs (236 allocations: 20.33 KiB)
```

## Functions
```@docs
is_d_separated
ConditionalIndependence
implied_conditional_independencies
```
