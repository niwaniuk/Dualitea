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
	rng.randomize()
	var rails = 1
	if rail_fence:
		label.text = text
		rails = rng.randi_range(3, min(len(text) / 2, 12))
		initialize_railfence(rails)
	if caesar:
		var use_text = text
		if rail_fence: use_text = label.text
		shift_cipher(rng.randi_range(5, 20), use_text)
	if (len(text) > 8):
		label.theme.get_font("SupermercadoOne", "DynamicFont").size = 72 / (len(text) / 8)
	particles.emission_rect_extents = Vector2(get_viewport_rect().size.x, 1)
	particles.position = Vector2(0, 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func shift_cipher(amount, new_text = ''):
	if (check_cipher()): return
	if (!new_text): new_text = label.text
	for i in len(new_text):
		if (new_text[i] == '_' or new_text[i] == '\n'): continue
		var curr_alphabet_index = alphabet.find(new_text[i])
		var new_alphabet_index = curr_alphabet_index + amount
		if (new_alphabet_index) > (len(alphabet)-1): new_alphabet_index -= (len(alphabet))
		elif (new_alphabet_index) < 0: new_alphabet_index += (len(alphabet))
		new_text[i] = alphabet[new_alphabet_index]
	label.text = new_text
	
func check_cipher():
	if ((rail_fence and (get_diagonal_string_from_rails() == text)) or label.text == text):
			particles.set_emitting(true)
			get_parent().get_node("TileMap").set_cell(31, 13,-1)
			return true
			
func set_cipher():
	rail_fence = false
	text = label.text
	particles.set_emitting(true)
		
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
	
func get_diagonal_string_from_rails():
	var cipher_array = label.text.split('\n')
	
	var rails = 0
	for i in len(label.text):
		if (label.text[i] == '\n'):
			rails += 1
	rails += 1
	
	var result = ""
	
	var down = false
	var row = 0
	var col = 0
	
	for i in len(text):
		if (row == 0):
			down = true
		elif (row == rails - 1):
			down = false
			
		if (cipher_array[row][col] != '*' and cipher_array[row][col] != '\n'):
			result += cipher_array[row][col]
			col += 1
			
		
		if down and row < rails - 1: row += 1
		elif !down and row > 0: row -= 1

	print(result)
	return result
		
	
func shift_rail_fences(amount):
	if (check_cipher()): return
	var rails = 0
	for i in len(label.text):
		if (label.text[i] == '\n'):
			rails += 1
	rails += 1 + amount
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
		
	
