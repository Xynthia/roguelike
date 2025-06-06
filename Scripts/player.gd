class_name Player
extends CharacterBody2D

signal player_moved
var has_key : bool = false

func player_input() -> void:
	if Input.is_action_just_pressed("Down"):
		velocity = Vector2.DOWN
		move(velocity)
	if Input.is_action_just_pressed("Up"):
		velocity = Vector2.UP
		move(velocity)
	if Input.is_action_just_pressed("Left"):
		velocity = Vector2.LEFT
		move(velocity)
	if Input.is_action_just_pressed("Right"):
		velocity = Vector2.RIGHT
		move(velocity)
	if Input.is_action_just_pressed("Attack_Down"):
		try_attack(Vector2.DOWN)
	if Input.is_action_just_pressed("Attack_Up"):
		try_attack(Vector2.UP)
	if Input.is_action_just_pressed("Attack_Left"):
		try_attack(Vector2.LEFT)
	if Input.is_action_just_pressed("Attack_Right"):
		try_attack(Vector2.RIGHT)
	
	

func move(direction : Vector2) -> void:
	var space_rid = get_world_2d().space
	var space_state = PhysicsServer2D.space_get_direct_state(space_rid)
	var query = PhysicsRayQueryParameters2D.create(global_position, global_position + Vector2(16, 16) * direction)
	var result = space_state.intersect_ray(query)
	
	if result:
		if result.collider.is_in_group("Wall"):
			return
	
	position += 16 * direction
	
	$SFX.stream = load("res://assets/SFX/walk.wav")
	$SFX.play()
	
	player_moved.emit()
	

func try_attack(direction: Vector2) -> void:
	var space_rid = get_world_2d().space
	var space_state = PhysicsServer2D.space_get_direct_state(space_rid)
	var query = PhysicsRayQueryParameters2D.create(global_position, global_position + Vector2(16, 16) * direction)
	var result = space_state.intersect_ray(query)
	
	print(PlayerData.health)
	
	if result:
		if result.collider.is_in_group("Enemy"):
			result.collider.take_damage(1)
		
	

func take_damage(damage_taken : int) -> void:
	PlayerData.health -= damage_taken
	
	$AnimationPlayer.play("hit")
	$SFX.stream = load("res://assets/SFX/Hit.wav")
	$SFX.play()
	
	if PlayerData.health <= 0:
		get_tree().change_scene_to_file("res://Scenes/death_menu.tscn")
	

func _physics_process(delta: float) -> void:
	player_input()
	
