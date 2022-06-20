module crdt

fn test_lookup() {
	mut gset := new_gset<string>()
	element := 'some-test-element'
	assert gset.lookup(element) == false
}

fn test_add() {
	mut gset := new_gset<string>()
	element := 'some-test-element'
	assert gset.lookup(element) == false
	gset.add(element)
	assert gset.lookup(element)
}

fn test_code() {
	mut gset := new_gset<string>()
	element := 'some-test-element'
	assert gset.lookup(element) == false
	gset.add(element)
	assert gset.len() == 1
}
