extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var next_scene = ""
export var side = "l"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_Area2D_body_entered(body):
	if body is Player:
		if side == "l":
			Global.set_spawn_side(next_scene, "r")
		else:
			Global.set_spawn_side(next_scene, "l")
		get_tree().change_scene("res://Scenes/" + next_scene + ".tscn")
			
