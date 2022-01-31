extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var text_triggers = [
	false,
	false,
	false, 
	false,
	false,
	false, 
	false,
	false,
	false, 
	false,
	false,
	false, 
	false,
	false,
	false,
	false, 
	false,
	false,
	false,
	false, 
	false
]

var spawn_side = {
	"Start": "l",
	"Ending": "l"
}

var got_all_tea = false

func is_textbox_visible(node):
	var textbox = get_textbox(node)
	return textbox and textbox.get_node("TextboxContainer").visible
	
func get_textbox(node):
	var textbox
	var game = node.get_parent()
	if game and game.has_node("TextBox"): return game.get_node("TextBox")
	
func get_textbox_trigger_val(index):
	return text_triggers[index]
	
func set_textbox_trigger_val(index, val):
	text_triggers[index] = val
	
func get_spawn_side(scene_name):
	return spawn_side[scene_name]
	
func set_spawn_side(scene_name, val):
	spawn_side[scene_name] = val
	
func get_has_all_tea():
	return got_all_tea
	
func set_has_all_tea(flag):
	got_all_tea = flag
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
