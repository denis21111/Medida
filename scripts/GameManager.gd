extends Node

signal elixir_changed(new_amount: int)
signal level_won
signal algorithm_error

var current_elixir: int = 10
var start_elixir: int = 10 
const COST_REVEAL: int = 1
const COST_SWAP: int = 2

var pakete_anzahl: int = 9
var feste_start_reihenfolge: Array = [] 

var active_packages: Array = []
var revealer_packages: Array = []
var selected_package = null 

var aktiver_algorithmus: String = "NONE"
var korrekte_tausch_reihenfolge: Array = []
var aktueller_pruef_schritt: int = 0

func initialize_level_packages(packages_in_level: Array):
	current_elixir = start_elixir
	
	active_packages = packages_in_level
	var m = active_packages.size()
	
	if feste_start_reihenfolge.size() == m:
		for i in range(m):
			active_packages[i].weight = feste_start_reihenfolge[i]
	else:
		var weights = []
		for i in range(1, m + 1):
			weights.append(i)
		weights.shuffle()
		for i in range(m):
			active_packages[i].weight = weights[i]
		
	if aktiver_algorithmus == "SELECTION_SORT":
		generiere_selection_sort_loesung()

func generiere_selection_sort_loesung():
	korrekte_tausch_reihenfolge.clear()
	aktueller_pruef_schritt = 0
	
	var temp_weights = []
	for pkg in active_packages:
		temp_weights.append(pkg.weight)
		
	var n = temp_weights.size()
	for i in range(n - 1):
		var min_index = i
		for j in range(i + 1, n):
			if temp_weights[j] < temp_weights[min_index]:
				min_index = j
		
		if min_index != i:
			korrekte_tausch_reihenfolge.append([i, min_index])
			var temp = temp_weights[i]
			temp_weights[i] = temp_weights[min_index]
			temp_weights[min_index] = temp

func swap_packages(index1: int, index2: int):
	var m = active_packages.size()
 
	if index1 < 0 or index1 >= m or index2 < 0 or index2 >= m:
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
			get_tree().change_scene_to_file("res://scenes/VictoryScreen.tscn")
			
func swap_packages_by_node(pkg1, pkg2) -> bool:
	var idx1 = active_packages.find(pkg1)
	var idx2 = active_packages.find(pkg2)

	if idx1 < 0 or idx2 < 0:
		return false
		
	if aktiver_algorithmus == "SELECTION_SORT" and korrekte_tausch_reihenfolge.size() > 0:
		if aktueller_pruef_schritt < korrekte_tausch_reihenfolge.size():
			var erwarteter_tausch = korrekte_tausch_reihenfolge[aktueller_pruef_schritt]
			var spieler_tausch = [min(idx1, idx2), max(idx1, idx2)]
			
			if spieler_tausch[0] == erwarteter_tausch[0] and spieler_tausch[1] == erwarteter_tausch[1]:
				aktueller_pruef_schritt += 1
			else:
				current_elixir -= 2
				elixir_changed.emit(current_elixir)
				emit_signal("algorithm_error")
				
				pkg1.modulate = Color(1, 1, 1)
				pkg2.modulate = Color(1, 1, 1)
				
				if current_elixir <= 0:
					get_tree().change_scene_to_file("res://scenes/LoseScreen.tscn")
				return false
		
	if not request_swap():
		if current_elixir <= 0:
			get_tree().change_scene_to_file("res://scenes/LoseScreen.tscn")
		return false
		
	active_packages[idx1] = pkg2
	active_packages[idx2] = pkg1

	var temp_pos = pkg1.position
	pkg1.position = pkg2.position
	pkg2.position = temp_pos
	
	if idx1 < revealer_packages.size() and idx2 < revealer_packages.size():
		var r1 = revealer_packages[idx1]
		var r2 = revealer_packages[idx2]
		var r_temp = r1.position
		r1.position = r2.position
		r2.position = r_temp
		revealer_packages[idx1] = r2
		revealer_packages[idx2] = r1
		
	pkg1.modulate = Color(1, 1, 1)
	pkg2.modulate = Color(1, 1, 1)

	if check_win_condition():
		emit_signal("level_won")
			
	return true

func request_reveal() -> bool:
	if current_elixir >= COST_REVEAL:
		current_elixir -= COST_REVEAL
		elixir_changed.emit(current_elixir)
		return true
	if current_elixir <= 0:
		get_tree().change_scene_to_file("res://scenes/LoseScreen.tscn")
	return false

func request_swap() -> bool:
	if current_elixir >= COST_SWAP:
		current_elixir -= COST_SWAP
		elixir_changed.emit(current_elixir)
		return true
	if current_elixir <= 0:
		get_tree().change_scene_to_file("res://scenes/LoseScreen.tscn")
	return false

func check_win_condition() -> bool:
	var m = active_packages.size()
	for i in range(m - 1):
		if active_packages[i].weight > active_packages[i + 1].weight:
			return false
	return true
