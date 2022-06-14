module crdt

fn test_add() {
	mut orset := new_orset<string>()
	element := 'some-test-element'
	assert orset.contains(element) == false
	orset.add(element)
	assert orset.contains(element)
}

fn test_remove() {
	mut orset := new_orset<string>()
	element := 'some-test-element'
	assert orset.contains(element) == false
	orset.add(element)
	assert orset.contains(element)
	orset.remove(element)
	assert orset.contains(element) == false
}

fn test_merge() {
	mut orset := new_orset<string>()
	element := 'some-test-element'
	assert orset.contains(element) == false
	orset.add(element)
	assert orset.contains(element)
	mut other_orset := new_orset<string>()
	other_orset.merge(orset)
	assert other_orset.contains(element)
	other_orset.remove(element)
	orset.merge(other_orset)
	assert orset.contains(element) == false
}
