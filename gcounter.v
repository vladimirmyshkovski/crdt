module main

import rand

// GCounter represent a G-counter in CRDT, which is
// a state-based grow-only counter that only supports
// increments.
pub struct GCounter {
	// ident provides a unique identity to each replica.
	ident string
	// counter maps identity of each replica to their
	// entry values i.e. the counter value they individually
	// have.
mut:
	counter map[string]int
}

// new_gcounter returns a GCounter by pre-assigning a unique
// identity to it.
pub fn new_gcounter() GCounter {
	return GCounter{
		ident: rand.uuid_v4().str() // uuid.NewV4().String(),
		counter: map[string]int{}
	}
}

// increment increments the GCounter by the value of 1 everytime it
// is called.
fn (mut g GCounter) increment() {
	g.int_val(1)
}

// inc_val allows passing in an arbitrary delta to increment the
// current value of counter by. Only positive values are accepted.
// If a negative value is provided the implementation will panic.
fn (mut g GCounter) int_val(incr int) {
	if incr < 0 {
		panic('Cannot decrement a gcounter')
	}
	g.counter[g.ident] += incr
}

// count returns the total count of this counter across all the
// present replicas.
fn (mut g GCounter) count() int {
	mut total := 0
	for key in g.counter.keys() {
		total += g.counter[key]
	}
	return total
}

// Merge combines the counter values across multiple replicas.
// The property of idempotency is preserved here across
// multiple merges as when no state is changed across any replicas,
// the result should be exactly the same everytime.
fn (mut g GCounter) merge(c &GCounter) {
	for key in c.counter.keys() {
		val := c.counter[key]
		v := g.counter[key] or {
			g.counter[key] = val
			continue
		}
		if v < val {
			g.counter[key] = val
		}
	}
}
