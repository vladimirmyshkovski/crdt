module crdt

// PNCounter represents a state-based PN-Counter. It is
// implemented as sets of two G-Counters, one that tracks
// increments while the other decrements.
struct PNCounter {
mut:
	p_counter GCounter
	n_counter GCounter
}

// new_pncounter returns a new *PNCounter with both its
// G-Counters initialized.
fn new_pncounter() PNCounter {
	return PNCounter{
		p_counter: new_gcounter()
		n_counter: new_gcounter()
	}
}

// increment monotonically increments the current value of the
// PN-Counter by one.
fn (mut pn PNCounter) increment() {
	pn.inc_val(1)
}

// int_val increments the current value of the PN-Counter
// by the delta incr that is provided. The value of delta
// has to be >= 0. If the value of delta is < 0, then this
// implementation panics.
fn (mut pn PNCounter) inc_val(incr int) {
	pn.p_counter.int_val(incr)
}

// decrement monotonically decrements the current value of the
// PN-Counter by one.
fn (mut pn PNCounter) decrement() {
	pn.dec_val(1)
}

// dec_val adds a decrement to the current value of
// PN-Counter by the value of delta decr. Similar to
// inc_val, the value of decr cannot be less than 0.
fn (mut pn PNCounter) dec_val(decr int) {
	pn.n_counter.int_val(decr)
}

// count returns the current value of the counter. It
// subtracts the value of negative G-Counter from the
// positive grow-only counter and returns the result.
// Because this counter can grow in either direction,
// negative integers as results are possible.
fn (mut pn PNCounter) count() int {
	return pn.p_counter.count() - pn.n_counter.count()
}

// Merge combines both the PN-Counters and saves the result
// in the invoking counter. Respective G-Counters are merged
// i.e. +ve with +ve and -ve with -ve, but not computation
// is actually performed.
fn (mut pn PNCounter) merge(pnpn PNCounter) {
	pn.p_counter.merge(pnpn.p_counter)
	pn.n_counter.merge(pnpn.n_counter)
}
