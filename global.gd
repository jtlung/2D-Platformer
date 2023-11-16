extends Node
var lives = 3
var time = 180
var score = 0
var currentlevel = 1
var over = false


# Called when the node \ the scene tree for the first time.
func _ready():
	pass
	
func reset():
	lives = 3
	time = 180
	score = 0

func updateLives(num):
	lives += num
	var HUD = get_node_or_null("/root/Game/UI/HUD")
	HUD.updateLives()

func updateScore(num):
	score +=num
	var HUD = get_node_or_null("/root/Game/UI/HUD")
	HUD.updateScore()
	
func updateTime(tim):
	Global.time += tim
	
func loadCurrentLevel():
	if lives > 0:
		get_tree().change_scene_to_file("res://level"+str(currentlevel)+".tscn")
	else:
		over = true
		get_tree().paused = true
		var menu = get_node_or_null("/root/Game/UI/OVER")
		menu.show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("Menu"):
		var menu = get_node_or_null("/root/Game/UI/Menu")
		if menu == null:
			get_tree().quit()
		else:
			if menu.visible:
				get_tree().paused = false
				menu.hide()
			else:
				get_tree().paused = true
				menu.show()
