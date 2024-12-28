extends Node2D

func _ready() -> void:
	$AnimatedSprite2D.play("default")
	Main.clickTree.connect(_fakeTreeFunc)

func _fakeTreeFunc():
	var frame = $AnimatedSprite2D.get_frame()
	$AnimatedSprite2D.set_frame_and_progress(frame+1, 0.0)
	pass
