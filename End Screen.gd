extends Control

func _ready():
	$Score.text = "SCORE: "+str(Global.score)

func _on_play_pressed():
	Global.reset()
	Global.loadCurrentLevel()


func _on_quit_pressed():
	get_tree().quit()
