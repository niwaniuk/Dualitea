extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (Array) var text_queue = []
export var one_shot :bool
export var on_button_press :bool
export var on_load :bool
export var index :int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	if (one_shot and Global.get_textbox_trigger_val(index)):
		set_deferred("monitoring", false) 
		return
	if (on_load):
		trigger_textbox()

func set_text_queue(new_text_queue):
	text_queue = new_text_queue
	
func set_one_shot(new_one_shot):
	one_shot = new_one_shot

func trigger_textbox():
	var textbox = Global.get_textbox(self)
	if (textbox):
		set_deferred("monitoring", false) 
		Global.set_textbox_trigger_val(index, true)
		for text in text_queue:
			textbox.queue_text(text)	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !Global.is_textbox_visible(self) and monitoring and Input.is_action_just_pressed("select"):
		var overlap = get_overlapping_bodies()
		for body in overlap:
			if body is Player:
				trigger_textbox()
				break


func _on_Area2D_body_entered(body):
	if body is Player and !on_button_press:
		trigger_textbox()
			


func _on_TextBox_textbox_closed():
	if (!one_shot):
		set_deferred("monitoring", true) 
		Global.set_textbox_trigger_val(index, false)
