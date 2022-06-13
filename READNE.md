# A V implementation of CRDTs
Inspired by https://github.com/neurodrone/crdt

The following state-based counters and sets have currently been implemented.

## Counters

### G-Counter

A grow-only counter (G-Counter) can only increase in one direction. The increment operation increases the value of current replica by 1. The merge operation combines values from distinct replicas by taking the maximum of each replica.

```v
gcounter := crdt.new_gcounter()

// We can increase the counter monotonically by 1.
gcounter.increment()

// Twice.
gcounter.increment()

// Or we can pass in an arbitrary delta to apply as an increment.
gcounter.inc_val(2)

// Should print '4' as the result.
println(gcounter.count())

another_counter := crdt.new_gcounter()

// We can merge counter between each other
another_counter.merge(gcounter)
gcounter.merge(another_counter)
assert another_counter.count() == gcounter.count() 
```
