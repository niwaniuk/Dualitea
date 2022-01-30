extends MarginContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var text :String = ''

var alphabet = "abcdefghijklmnopqrstuvwxyz "

onready var container = $HBoxContainer
onready var label = $HBoxContainer/Label
onready var particles = $CPUParticles2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	label.text = text
	shift_cipher(rng.randi_range(5, 20))
	print(label.get_size())
	particles.emission_rect_extents = Vector2((40 * len(text)) / 2, 1)
	particles.position = Vector2((40 * len(text)) / 2, 43)
	particles.amount = 20 * len(text)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func shift_cipher(amount):
	var new_text = label.text
	for i in len(new_text):
		var curr_alphabet_index = alphabet.find(new_text[i])
		var new_alphabet_index = curr_alphabet_index + amount
		if (new_alphabet_index) > (len(alphabet)-1): new_alphabet_index -= (len(alphabet))
		elif (new_alphabet_index) < 0: new_alphabet_index += (len(alphabet))
		new_text[i] = alphabet[new_alphabet_index]
	label.text = new_text
	
func check_cipher():
	if (label.text == text):
		particles.set_emitting(true)
