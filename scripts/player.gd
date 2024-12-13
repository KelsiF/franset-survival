extends CharacterBody2D

@export var speed = 100

func _ready() -> void:
	pass

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	
	if Input.is_action_pressed("left"):
		$AnimatedSprite2D.flip_h = true
	if Input.is_action_pressed("right"):
		$AnimatedSprite2D.flip_h = false

func _physics_process(delta):
	get_input()
	move_and_slide()
	if Input.is_action_pressed("right") or Input.is_action_pressed("left"):
		$AnimatedSprite2D.play("walk")
	if Input.is_action_pressed("up"):
		$AnimatedSprite2D.play("walk_up")
	if Input.is_action_pressed("down"):
		$AnimatedSprite2D.play("walk_down")
	
	if velocity == Vector2(0.0, 0.0):
		$AnimatedSprite2D.play("idle")

func _process(delta: float) -> void:
	if Input.is_action_just_released("camera_plus"):
		$Camera2D.zoom = $Camera2D.zoom + Vector2(0.5, 0.5)
	if Input.is_action_just_released("camera_minus"):
		$Camera2D.zoom = $Camera2D.zoom - Vector2(0.5, 0.5)
