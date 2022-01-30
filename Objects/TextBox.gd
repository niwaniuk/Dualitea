extends CanvasLayer

# Adapted from https://www.youtube.com/watch?v=QEHOiORnXIk

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var textbox_container = $TextboxContainer
onready var end_symbol = $TextboxContainer/MarginContainer/HBoxContainer/EndSymbol
onready var text = $TextboxContainer/MarginContainer/HBoxContainer/Text

const CHAR_READ_RATE = 0.02

signal textbox_closed

var text_queue = []

# Called when the node enters the scene tree for the first time.
func _ready():
	hide_textbox()

func hide_textbox():
	end_symbol.text = ''
	text.text = ''
	textbox_container.hide()
	emit_signal('textbox_closed')
	
func show_textbox():
	textbox_container.show()
	
func queue_text(next_text):
	text_queue.push_back(next_text)
	
func display_text():
	var next_text = text_queue.pop_front()
	if (next_text):
		end_symbol.text = ''
		text.percent_visible = 0.0
		show_textbox()
		text.text = next_text
		$Tween.interpolate_property(text, "percent_visible", 0.0, 1.0, len(next_text) * CHAR_READ_RATE, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
		)
		$Tween.start()
	
func end_textbox():
	end_symbol.text = "v"
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !$Tween.is_active() and text.text == '' and !text_queue.empty():
		display_text()
	if (Input.is_action_just_pressed("select")):
		if (text.text != ''):
			if ($Tween.is_active()):
				text.percent_visible = 1.0
				$Tween.stop_all()
				end_textbox()
			elif (text_queue.empty()):
				hide_textbox()
			else:
				display_text()


func _on_Tween_tween_all_completed():
	end_textbox()
