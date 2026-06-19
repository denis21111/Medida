extends Node

signal elixir_changed(new_amount: int)

var current_elixir: int = 10
const COST_REVEAL: int = 1
const COST_SWAP: int = 2

var active_packages: Array = []

func initialize_level_packages(packages_in_level: Array):
	active_packages = packages_in_level
	var m = active_packages.size()

	var weights = []
	for i in range(1, m + 1):
		weights.append(i)
	
	weights.shuffle()
	
	for i in range(m):
		active_packages[i].weight = weights[i]

func swap_packages(index1: int, index2: int):
	var m = active_packages.size()

	if index1 < 0 or index1 >= m or index2 < 0 or index2 >= m:
		print("Fehler: Ungültiger Index für den Tausch.")
		return
		
	if request_swap():
		var pkg1 = active_packages[index1]
		var pkg2 = active_packages[index2]
		
		active_packages[index1] = pkg2
		active_packages[index2] = pkg1

		var temp_pos = pkg1.global_position
		pkg1.global_position = pkg2.global_position
		pkg2.global_position = temp_pos

		if check_win_condition():
			print("Gewonnen! Das Level ist korrekt sortiert.")

func request_reveal() -> bool:
	if current_elixir >= COST_REVEAL:
		current_elixir -= COST_REVEAL
		elixir_changed.emit(current_elixir)
		return true
	return false

func request_swap() -> bool:
	if current_elixir >= COST_SWAP:
		current_elixir -= COST_SWAP
		elixir_changed.emit(current_elixir)
		return true
	return false

func check_win_condition() -> bool:
	var m = active_packages.size()
	for i in range(m - 1):
		if active_packages[i].weight > active_packages[i + 1].weight:
			return false
			
	return true
