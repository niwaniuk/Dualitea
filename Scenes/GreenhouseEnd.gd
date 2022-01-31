extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.get_spawn_side("GreenhouseEnd") == "r":
		remove_child($LeftPlayer)
	else:
		remove_child($RightPlayer)
	Global.set_has_all_tea(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
