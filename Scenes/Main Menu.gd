extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Start.connect("pressed", self, "_start")
	$Credits.connect("pressed", self, "_credits")
	$Exit.connect("pressed", self, "_exit")

func _start():
	get_tree().change_scene("res://Scenes/Start.tscn")
func _credits():
	get_tree().change_scene("res://Scenes/Credits.tscn")
func _exit():
	get_tree().quit()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
