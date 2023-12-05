extends AudioStreamPlayer2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.musicTime > 0:
		print("hey?")
		seek(Global.musicTime)
