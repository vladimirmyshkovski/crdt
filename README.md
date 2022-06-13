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
gcounter.increment_value(2)

// Should print '4' as the result.
println(gcounter.count())

another_counter := crdt.new_gcounter()

// We can merge counter between each other
another_counter.merge(gcounter)
gcounter.merge(another_counter)
assert another_counter.count() == gcounter.count() 
```

### PN-Counter

A positive-negative counter (PN-Counter) is a CRDT that can both increase or
decrease and converge correctly in the light of commutative
operations. Both `.increment()` and `.decrement()` operations are allowed and thus
negative values are possible as a result.

```v
pncounter := crdt.new_pncounter()

// We can increase the counter by 1.
pncounter.increment()

// Or more.
pncounter.increment_value(100)

// And similarly decrease its value by 1.
pncounter.decrement()

// Or more.
pncounter.decrement_value(100)

// End result should equal '0' here.
println(pncounter.count())
```
