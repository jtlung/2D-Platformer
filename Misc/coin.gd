extends StaticBody2D
var collected = false





func _on_area_2d_body_entered(body):
	if body.name == "Player" and not collected:
		collected = true
		Global.updateScore(50)
		$AudioStreamPlayer2D.play()
		$Sprite2D.hide()
		await get_tree().create_timer(3).timeout
		queue_free()
