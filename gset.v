module crdt

// Gset is a grow-only set.
struct GSet<T> {
mut:
	main_set map[T]T
}

// new_gset returns an instance of GSet.
fn new_gset<T>() GSet<T> {
	return GSet<T>{
		main_set: map[T]T{}
	}
}

// add lets you add an element to grow-only set.
fn (mut g GSet<T>) add(elem T) {
	g.main_set[elem] = T{}
}

// contains returns true if an element exists within the
// set or false otherwise.
fn (mut g GSet<T>) contains(elem T) bool {
	return elem in g.main_set
}

// len returns the no. of elements present within GSet.
fn (mut g GSet<T>) len() int {
	return g.main_set.len
}

// elements returns all the elements present in the set.
fn (mut g GSet<T>) elements() []T {
	mut elements := []T{}
	for _, element in g.main_set {
		elements << element
	}
	return elements
}
