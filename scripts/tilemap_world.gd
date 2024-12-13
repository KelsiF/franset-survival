extends Node2D

@export var noise_height_text : NoiseTexture2D
var noise : Noise

var width : int = 800
var height : int = 800

var noise_val_arr = []

@onready var tile_map = $TileMapLayer

var water_atlas = Vector2i(0, 0)
var land_atlas = Vector2i(0, 0)

func _ready() -> void:
	noise = noise_height_text.noise
	generate_world()

func generate_world():
	noise.seed = randi()
	print(noise.seed)
	for x in range(-width/2, width/2):
		for y in range(-height/2, height/2):
			var noise_val : float = noise.get_noise_2d(x, y)
			if noise_val > 0.0:
				tile_map.set_cell(Vector2(x, y), 0, land_atlas)
			elif noise_val < 0.0:
				tile_map.set_cell(Vector2(x, y), 1, land_atlas)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("generate world"):
		generate_world()
