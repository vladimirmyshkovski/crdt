module crdt

fn test_add() {
	mut twophaseset := new_two_phase_set<string>()
	element := 'some-test-element'
	assert twophaseset.contains(element) == false
	twophaseset.add(element)
	assert twophaseset.contains(element)
}

fn test_remove() {
	mut twophaseset := new_two_phase_set<string>()
	element := 'some-test-element'
	assert twophaseset.contains(element) == false
	twophaseset.add(element)
	assert twophaseset.contains(element)
	twophaseset.remove(element)
	assert twophaseset.contains(element) == false
}
