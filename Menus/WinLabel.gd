extends Label

#variables
var win_message_array = ["Nice Job!", "Awesome!", "Wow...just Wow", "Easy", "Pretty Good", "You're a Natural", "So good at pressing buttons"]

#rng
var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	text = win_message_array[rng.randi_range(0, win_message_array.size()-1)]
