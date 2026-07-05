extends Node

signal elixir_changed(new_amount: int)
signal level_won

var current_elixir: int = 10
const COST_REVEAL: int = 1
const COST_SWAP: int = 2

var active_packages: Array = []
var selected_package = null #playerB erste paket 

func initialize_level_packages(packages_in_level: Array):
	active_packages = packages_in_level
	var m = active_packages.size()

	var weights = []
	for i in range(1, m + 1):
		weights.append(i)
	
	weights.shuffle()
	
	for i in range(m):
		active_packages[i].weight = weights[i]

func swap_packages_by_node(pkg1, pkg2):
	if not request_swap():
		return
		
	var idx1 = active_packages.find(pkg1)
	var idx2 = active_packages.find(pkg2)

	if idx1 < 0 or idx2 < 0:
		print("Fehler: Ungültiger Index für den Tausch.")
		return
		
		
	active_packages[idx1] = pkg2
	active_packages[idx2] = pkg1

	var temp_pos = pkg1.global_position
	pkg1.global_position = pkg2.global_position
	pkg2.global_position = temp_pos
		
	pkg1.modulate = Color(1, 1, 1)
	pkg2.modulate = Color(1, 1, 1)

	if check_win_condition():
		print("Gewonnen! Das Level ist korrekt sortiert.")
		emit_signal("level_won")
			


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
