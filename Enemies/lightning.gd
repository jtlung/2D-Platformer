extends Area2D
var velocity = Vector2.ZERO
var speed = 5
var active = true

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = Vector2(0,-speed).rotated(rotation)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	position = position+velocity
	if active:
		var hurtBoxes = get_overlapping_areas()
		for hurtBox in hurtBoxes:
			if hurtBox.get_owner().has_method("hit") and hurtBox.get_owner().name == "Player":
				hurtBox.get_owner().hit()
				queue_free()




func _on_timer_timeout():
	queue_free()
