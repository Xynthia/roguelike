extends Node2D

func _ready() -> void:
	$Intro/VBoxContainer/Stats.text = "Level Reached: " + str(PlayerData.level) + "\n" + "Enemies Defeated: " + str(PlayerData.enemies_defeated) + "\n" + "Coins Collected: " + str(PlayerData.coins)

func _on_back_to_main_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
