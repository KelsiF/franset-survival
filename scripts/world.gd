extends Node2D

signal changeInventory
signal clickTree

func _ready() -> void:
	Main.changeInventory.connect(_changeInventoryFunc)
	Main.clickTree.connect(_fakeTreeFunc)
	

func _changeInventoryFunc():
	pass

func _fakeTreeFunc():
	pass
