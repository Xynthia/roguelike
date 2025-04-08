extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if body.has_key:
			PlayerData.level += 1
			PlayerData.seed += randi_range(1, 40000)
			Sfx.get_child(3).play()
			get_tree().reload_current_scene.call_deferred()
