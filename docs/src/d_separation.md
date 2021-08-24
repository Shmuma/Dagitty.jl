# D-separation

D-Separation is a method to find from causal DAG which variables are indendent on each other given some set of conditioned variables.

```@docs
is_d_separated
ConditionalIndependence
implied_conditional_independencies
```

## Benchmark of D-separation

I've done simple benchmark on "asia graph" (taken from NetworkX test suite). Code is in `bench/t1.{py,jl}`. Results:

Python:
```
test1: 82.38 us
test2: 81.57 us
```

Julia:
```
test1:  7.998 μs (191 allocations: 16.58 KiB)
test2:  9.079 μs (225 allocations: 19.30 KiB)
```
