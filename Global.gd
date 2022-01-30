extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func is_textbox_visible(node):
	var textbox = get_textbox(node)
	return textbox and textbox.get_node("TextboxContainer").visible
	
func get_textbox(node):
	var textbox
	var game = node.get_parent()
	if game and game.has_node("TextBox"): return game.get_node("TextBox")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
