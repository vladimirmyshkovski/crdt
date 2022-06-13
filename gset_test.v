module crdt

fn test_contains() {
	mut gset := new_gset<string>()
	element := 'some-test-element'
	assert gset.contains(element) == false
}

fn test_add() {
	mut gset := new_gset<string>()
	element := 'some-test-element'
	assert gset.contains(element) == false
	gset.add(element)
	assert gset.contains(element)
}

fn test_code() {
	mut gset := new_gset<string>()
	element := 'some-test-element'
	assert gset.contains(element) == false
	gset.add(element)
	assert gset.len() == 1
}
