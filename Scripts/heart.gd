extends Node2D

func _on_body_entered(body) -> void:
	if body.is_in_group("Player"):
		if PlayerData.health < PlayerData.max_health:
			PlayerData.health += 1
			Sfx.get_child(1).play()
			queue_free()
