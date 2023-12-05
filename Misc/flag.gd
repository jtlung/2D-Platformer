extends StaticBody2D
var used = false



func _on_flag_body_entered(body):
	if body.name == "Player" and not used:
		used = true
		$Red.hide()
		$Green.show()
		Global.finishLevel()
