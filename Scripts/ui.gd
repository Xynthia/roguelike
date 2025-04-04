extends CanvasLayer

@onready var player : CharacterBody2D = get_tree().get_first_node_in_group("Player")
@onready var Generation : Node = $"../Generation"
@onready var grid : PackedScene = load("res://Scenes/minimap_grid.tscn")

func _ready() -> void:
	generate_minimap()

func _process(delta: float) -> void:
	update_minimap()
	
	$StatBar/Coins.text = str(PlayerData.coins)
	
	if player.has_key == true:
		$StatBar/Key.visible = true
	else:
		$StatBar/Key.visible = false
	
	match PlayerData.health:
		8:
			$"HealthBar/Heart1".frame = 2
			$"HealthBar/Heart2".frame = 2
			$"HealthBar/Heart3".frame = 2
			$"HealthBar/Heart4".frame = 2
		7:
			$"HealthBar/Heart1".frame = 2
			$"HealthBar/Heart2".frame = 2
			$"HealthBar/Heart3".frame = 2
			$"HealthBar/Heart4".frame = 1
		6:
			$"HealthBar/Heart1".frame = 2
			$"HealthBar/Heart2".frame = 2
			$"HealthBar/Heart3".frame = 2
			$"HealthBar/Heart4".frame = 0
		5:
			$"HealthBar/Heart1".frame = 2
			$"HealthBar/Heart2".frame = 2
			$"HealthBar/Heart3".frame = 1
			$"HealthBar/Heart4".frame = 0
		4:
			$"HealthBar/Heart1".frame = 2
			$"HealthBar/Heart2".frame = 2
			$"HealthBar/Heart3".frame = 0
			$"HealthBar/Heart4".frame = 0
		3:
			$"HealthBar/Heart1".frame = 2
			$"HealthBar/Heart2".frame = 1
			$"HealthBar/Heart3".frame = 0
			$"HealthBar/Heart4".frame = 0
		2:
			$"HealthBar/Heart1".frame = 2
			$"HealthBar/Heart2".frame = 0
			$"HealthBar/Heart3".frame = 0
			$"HealthBar/Heart4".frame = 0
		1:
			$"HealthBar/Heart1".frame = 1
			$"HealthBar/Heart2".frame = 0
			$"HealthBar/Heart3".frame = 0
			$"HealthBar/Heart4".frame = 0
		0:
			$"HealthBar/Heart1".frame = 0
			$"HealthBar/Heart2".frame = 0
			$"HealthBar/Heart3".frame = 0
			$"HealthBar/Heart4".frame = 0

func generate_minimap() -> void:
	$MiniMap/GridContainer.columns = Generation.map_width
	
	for i in range(Generation.map_height):
		for j in range(Generation.map_width):
			var panel = grid.instantiate()
			if Generation.map[j][i] == false:
				panel.modulate = Color(1, 1, 1, 0)
			else:
				panel.is_room = true
			
			panel.pos = Vector2i(j, i)
			$MiniMap/GridContainer.add_child(panel)
		
	

func update_minimap() -> void:
	var pos : Vector2i = player.global_position / 272
	var panels = $MiniMap/GridContainer.get_children()
	
	for panel in panels:
		if panel.is_room:
			panel.modulate = "ffffff"
		if panel.pos == pos:
			panel.modulate = "00b5e6"
