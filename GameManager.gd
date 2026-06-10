extends Node

signal elixir_changed(new_amount: int)

var current_elixir: int = 10
const COST_REVEAL: int = 1
const COST_SWAP: int = 2

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

func check_win_condition(package_weights: Array) -> bool:
	for i in range(package_weights.size() - 1):
		if package_weights[i] > package_weights[i + 1]:
			return false
			
	return true 
