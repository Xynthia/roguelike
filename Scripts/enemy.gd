extends CharacterBody2D

var health : int = 3
var damage : int = 1
var attack_chance : float = 0.5

@onready var player = get_tree().get_nodes_in_group("Player")[0]

func move() -> void:
	if randf() < 0.5:
		return
	
	var direction : Vector2 = Vector2.ZERO
	var can_move : bool = false
	
	while(can_move == false):
		direction = get_random_direction()
		
		var space_rid = get_world_2d().space
		var space_state = PhysicsServer2D.space_get_direct_state(space_rid)
		var query = PhysicsRayQueryParameters2D.create(global_position, global_position + Vector2(64, 64) * direction)
		var result = space_state.intersect_ray(query)
		
		if not result and position + 6 * direction != player.position:
			can_move = true
		
		if result:
			if result.collider.is_in_group("Wall"):
				return
		
		position += 64 * direction

func get_random_direction() -> Vector2:
	var ran : int = randi_range(0, 3)
	
	match ran:
		0:
			return Vector2.UP
		1:
			return Vector2.DOWN
		2:
			return Vector2.RIGHT
		3:
			return Vector2.LEFT
	
	return Vector2.ZERO

func take_damage(damage_taken : int) -> void:
	health -= damage_taken
	
	if health <= 0:
		queue_free()
	
	$AnimationPlayer.play("hit")
	
	if randf() > attack_chance:
		player.take_damage(damage)
