extends StaticBody2D
var dead = false

func hit():
	if not dead:
		dead = true
		$wood.play()
		$Sprite.hide()
		$Broken.show()
		$CollisionShape2D.disabled = true
		$HurtBox/Shape.disabled = true
		$HurtBox.set_collision_layer_value(12,false)
		Global.updateScore(25)
		var tween = get_tree().create_tween()
		tween.tween_property($Broken, "modulate:a", 0, 1)
		await get_tree().create_timer(1).timeout
		queue_free()
