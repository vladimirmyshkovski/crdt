module crdt

fn test_contains() {
	mut lwweset := new_lwweset<string>()
	assert lwweset.contains('some-test-element') == false
}

fn test_add() {
	mut lwweset := new_lwweset<string>()
	assert lwweset.contains('some-test-element') == false
	lwweset.add('some-test-element')
	assert lwweset.contains('some-test-element')
}

fn test_remove() {
	mut lwweset := new_lwweset<string>()
	assert lwweset.contains('some-test-element') == false
	lwweset.add('some-test-element')
	assert lwweset.contains('some-test-element')
	lwweset.remove('some-test-element')
	assert lwweset.contains('some-test-element') == false
}

fn test_merge() {
	mut lwweset := new_lwweset<string>()
	assert lwweset.contains('some-test-element') == false
	lwweset.add('some-test-element')
	assert lwweset.contains('some-test-element')
	lwweset.remove('some-test-element')
	assert lwweset.contains('some-test-element') == false
	mut another_lwweset := new_lwweset<string>()
	another_lwweset.add('another-test-element')
	assert another_lwweset.contains('another-test-element')
	lwweset.merge(another_lwweset)
	assert lwweset.contains('another-test-element')
	another_lwweset.merge(lwweset)
	assert another_lwweset.add_map == lwweset.add_map
	assert another_lwweset.rm_map == lwweset.rm_map
}
