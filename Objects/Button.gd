extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !Global.is_textbox_visible(self) and Input.is_action_just_pressed("select"):
		var overlap = get_overlapping_bodies()
		for body in overlap:
			if body is Player:
				print('bloop')
