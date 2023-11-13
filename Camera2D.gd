extends Camera2D
var player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	player = get_node_or_null("/root/Game/Player_Container/Player")
	if player:
		global_position = player.global_position
