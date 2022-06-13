module crdt

fn test_one() {
	first := [5, 10, 15]
	second := [10, 5, 15]

	mut first_counter := new_pncounter()
	mut second_counter := new_pncounter()

	for i in 0 .. 3 {
		for z in 0 .. first[i] {
			first_counter.increment()
		}
		for z in 0 .. second[i] {
			second_counter.increment()
		}
		first_counter.merge(second_counter)
		second_counter.merge(first_counter)
	}
	assert first_counter.p_counter.counter == second_counter.p_counter.counter
	assert first_counter.n_counter.counter == second_counter.n_counter.counter
	assert first_counter.count() == second_counter.count()

	for i in 0 .. 3 {
		for z in 0 .. first[i] {
			first_counter.decrement()
		}
		for z in 0 .. second[i] {
			second_counter.decrement()
		}
		first_counter.merge(second_counter)
		second_counter.merge(first_counter)
	}
	assert first_counter.p_counter.counter == second_counter.p_counter.counter
	assert first_counter.n_counter.counter == second_counter.n_counter.counter
	assert first_counter.count() == second_counter.count()
}
