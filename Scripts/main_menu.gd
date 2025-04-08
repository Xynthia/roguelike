extends Node2D


func _on_play_pressed() -> void:
	$Intro.visible = false
	$Play.visible = true
	

func _on_quit_pressed() -> void:
	get_tree().quit()
	

func _on_start_pressed() -> void:
	if $Play/VBoxContainer/SpinBox.value == 0:
		PlayerData.seed = randi_range(1, 100000)
	else:
		PlayerData.seed = $Play/VBoxContainer/SpinBox.value
	
	PlayerData.health = PlayerData.max_health
	PlayerData.level = 1
	PlayerData.coins = 0
	PlayerData.enemies_defeated = 0
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
	

func _on_back_pressed() -> void:
	$Intro.visible = true
	$Play.visible = false
	
