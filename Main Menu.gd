extends Control


func _on_play_pressed():
	Global.reset()
	Global.loadCurrentLevel()


func _on_quit_pressed():
	get_tree().quit()
