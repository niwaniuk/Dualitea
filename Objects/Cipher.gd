extends MarginContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var text :String = ''
export var caesar :bool = true
export var rail_fence :bool = false

var alphabet = "abcdefghijklmnopqrstuvwxyz "

onready var container = $HBoxContainer
onready var label = $HBoxContainer/Label
onready var particles = $CPUParticles2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	if caesar: shift_cipher(rng.randi_range(5, 20), text)
	rng.randomize()
	if rail_fence: initialize_railfence(rng.randi_range(3, min(len(text) / 2, 12)))
	particles.emission_rect_extents = Vector2((40 * len(text)) / 2, 1)
	particles.position = Vector2((40 * len(text)) / 2, 43)
	particles.amount = 20 * len(text)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func shift_cipher(amount, new_text = ''):
	if (check_cipher()): return
	if (!new_text): new_text = label.text
	for i in len(new_text):
		if (new_text[i] == '_'): continue
		var curr_alphabet_index = alphabet.find(new_text[i])
		var new_alphabet_index = curr_alphabet_index + amount
		if (new_alphabet_index) > (len(alphabet)-1): new_alphabet_index -= (len(alphabet))
		elif (new_alphabet_index) < 0: new_alphabet_index += (len(alphabet))
		new_text[i] = alphabet[new_alphabet_index]
	label.text = new_text
	
func check_cipher():
	if ((rail_fence and (get_string_from_rails() == text)) or label.text == text):
			particles.set_emitting(true)
			return true
		
func initialize_railfence(rails):
	var cipher_array = []
	for i in rails:
		cipher_array.append("_".repeat(len(text)))
		
	var down = false
	var row = 0
	
	for j in len(text):
		if (row == 0 or row == rails - 1):
			down = !down
			
		cipher_array[row][j] = text[j]
		
		if down: row += 1
		else: row -= 1
		
	var rail_fence_cipher = ""
	for i in rails:
		rail_fence_cipher += cipher_array[i]
		if i != rails - 1: rail_fence_cipher += '\n'
	print(rail_fence_cipher)
	var cipher_text = get_string_from_rails(rail_fence_cipher)
	label.text = cipher_text
	
	
func get_string_from_rails(rail_fence_cipher = ""):
	var string_text = ""
	if (!rail_fence_cipher): rail_fence_cipher = label.text
	for i in len(rail_fence_cipher):
		if (rail_fence_cipher[i] != '_' and rail_fence_cipher[i] != '\n'): string_text += rail_fence_cipher[i]
	return string_text
	
func shift_rail_fences(amount):
	var rails = 0
	for i in len(label.text):
		if (label.text[i] == '\n'):
			rails += 1
	print(rails)
	rails += 1 + amount
	print(rails)
	if (rails > min(len(text) / 2, 12) + 3 or rails < 1): return
	var cipher_text = get_string_from_rails()
	var cipher_array = []
	for i in rails:
		cipher_array.append("_".repeat(len(text)))
		
	var down = false
	var row = 0
	
	for j in len(cipher_text):
		if (row == 0 or row == rails - 1):
			down = !down
			
		cipher_array[row][j] = "*"
		
		if down and row < rails - 1: row += 1
		elif !down and row > 0: row -= 1
		
	var index = 0
	for i in rails:
		for j in len(cipher_text):
			if (cipher_array[i][j] == '*'):
				cipher_array[i][j] = cipher_text[index]
				index += 1
			if index == len(cipher_text): break
		if index == len(cipher_text): break
	
	var rail_fence_cipher = ""
	for i in rails:
		rail_fence_cipher += cipher_array[i]
		if i != rails - 1: rail_fence_cipher += '\n'
		
	label.text = rail_fence_cipher
		
	
