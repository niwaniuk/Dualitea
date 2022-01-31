extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.get_spawn_side("Ending") == "r":
		remove_child($LeftPlayer)
	else:
		remove_child($RightPlayer)
		
	if Global.get_has_all_tea():
		remove_child($AreaTransition2)
	else:
		remove_child($AreaTransition3)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
