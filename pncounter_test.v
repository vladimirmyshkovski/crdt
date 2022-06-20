module crdt

fn test_increment() {
	mut pncounter := new_pncounter()
	pncounter.increment()
	assert pncounter.count() == 1
}

fn test_decrement() {
	mut pncounter := new_pncounter()
	pncounter.decrement()
	assert pncounter.count() == -1
}

fn test_merge() {
	mut first_pncounter := new_pncounter()
	first_pncounter.increment()
	assert first_pncounter.count() == 1
	mut second_pncounter := new_pncounter()
	second_pncounter.decrement()
	assert second_pncounter.count() == -1
	first_pncounter.merge(second_pncounter)
	assert first_pncounter.count() == 0
	assert second_pncounter.count() == -1
	second_pncounter.merge(first_pncounter)
	assert second_pncounter.count() == 0
}
