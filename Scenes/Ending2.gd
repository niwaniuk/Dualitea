extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.get_spawn_side("Ending2") == "r":
		remove_child($LeftPlayer)
	else:
		remove_child($RightPlayer)
