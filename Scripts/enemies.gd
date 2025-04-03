extends Node

var enemies : Array
var player : CharacterBody2D

func _ready() -> void:
	player = get_tree().get_nodes_in_group("Player")[0]
	SignalBus.player_moved.connect(_on_player_moved)
	check_enemies()

func check_enemies() -> void:
	enemies = get_tree().get_nodes_in_group("Enemy")

func _on_player_moved() -> void:
	for enemy in enemies:
		if is_instance_valid(enemy):
			enemy.move()
