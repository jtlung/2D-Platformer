extends Area2D
var active = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if active:
		var hurtBoxes = get_overlapping_areas()
		for hurtBox in hurtBoxes:
			if hurtBox.get_owner().has_method("hit") and hurtBox.get_owner().name == "Player":
				hurtBox.get_owner().hit()

