extends Control


func _on_resume_pressed():
	get_tree().paused = false
	hide()
	


func _on_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Main Menu.tscn")
