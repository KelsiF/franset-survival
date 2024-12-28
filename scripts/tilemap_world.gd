extends Node2D

@export var noise_height_text : NoiseTexture2D
var noise : Noise

var width : int = 800
var height : int = 800

var noise_val_arr = []

@onready var tile_map = $TileMapLayer
@onready var tile_trees = $trees

var water_atlas = Vector2i(0, 0)
var land_atlas = Vector2i(0, 0)

var tree = preload("res://scenes/tree.tscn")
var fake_tree = preload("res://scenes/fake-objects/fake_tree.tscn")

var tree_health = 5

func _ready() -> void:
	noise = noise_height_text.noise
	generate_world()

func generate_world():
	var rng = RandomNumberGenerator.new()
	
	noise.seed = randi()
	print(noise.seed)
	for x in range(-width/2, width/2):
		for y in range(-height/2, height/2):
			
			
			var noise_val : float = noise.get_noise_2d(x, y)
			if noise_val > 0.0:
				tile_map.set_cell(Vector2(x, y), 0, land_atlas)
			elif noise_val < 0.0:
				tile_map.set_cell(Vector2(x, y), 1, land_atlas)
			if noise_val > 0.1:
				var chance_tree = rng.randi_range(1, 10)
				if chance_tree == 1:
					var cell = tile_map.get_cell_source_id(Vector2i(x, y))
					if cell == 0:
						tile_trees.set_cell(Vector2(x, y), 0, Vector2i.ZERO, 1)
					else:
						return false

			# 0 - земля, 1 - вода

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("generate world"):
		generate_world()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("left_click"):
		get_clicked_tile()

func get_clicked_tile():
	var clicked_cell = tile_trees.local_to_map(tile_trees.get_local_mouse_position()) 
	var mouse_pos = get_global_mouse_position()
	var cell_id = tile_trees.get_cell_source_id(clicked_cell)
	
	
	if cell_id == 0 and tree_health > 0:
		tree_health -= 1
		print(tree_health)
		Main.changeInventory.emit()
		Main.clickTree.emit()
	if tree_health <= 0:
		tile_trees.erase_cell(clicked_cell)
		tree_health = 5
