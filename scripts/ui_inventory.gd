extends Node2D

var wood = 0

func _ready() -> void:
	update_text()
	Main.changeInventory.connect(updateWood)

func updateWood():
	wood += 1

func update_text():
	var i = 0
	
	while i == 0:
		$Label.text = "Item: stone axe\nwood: " + str(wood)
		await get_tree().create_timer(0.1).timeout
