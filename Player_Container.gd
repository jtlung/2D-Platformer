extends Node
var Player = load("res://Player/player.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var player = get_node_or_null("/root/Game/Player_Container/Player")
	if not player:
		player = Player.instantiate()
		add_child(player)
