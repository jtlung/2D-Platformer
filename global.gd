extends Node
var lives = 3
var time = 180
var score = 0
var prevScore = 0
var currentlevel = 1
var finallevel = 3
var musicTime = 0
var over = false


# Called when the node \ the scene tree for the first time.
func _ready():
	pass
	
func reset():
	currentlevel = 1
	lives = 3
	time = 180
	score = 0
	musicTime = 0

func updateLives(num):
	lives += num
	var HUD = get_node_or_null("/root/Game/UI/HUD")
	HUD.updateLives()
	if sign(num) < 0:
		Global.loadCurrentLevel()
	
func setLives(num):
	lives = num
	var HUD = get_node_or_null("/root/Game/UI/HUD")
	HUD.updateLives()

func updateScore(num):
	score +=num
	var HUD = get_node_or_null("/root/Game/UI/HUD")
	HUD.updateScore()
	
func updateTime(tim):
	Global.time += tim
	if Global.time <= 0:
		setLives(0)
	
func loadCurrentLevel():
	if lives > 0 and currentlevel <= finallevel:
		score = prevScore
		SceneTransition.change_scene_to_file("res://level"+str(currentlevel)+".tscn")
	elif lives > 0 and currentlevel == finallevel+1:
		SceneTransition.change_scene_to_file("res://end_screen.tscn")
	else:
		over = true
		get_tree().paused = true
		var menu = get_node_or_null("/root/Game/UI/OVER")
		menu.show()
		
func finishLevel():
	currentlevel += 1
	prevScore = score
	musicTime = 0
	loadCurrentLevel()


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
