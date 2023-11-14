extends RigidBody2D
var Spark = load("res://Enemies/lightning.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func hit():
	queue_free()

func attack():
	var folder = get_node_or_null("/root/Game/Effects")
	var player = get_node_or_null("/root/Game/Player_Container/Player")
	if folder and player:
		if global_position.distance_to(player.global_position) < 500:
			print(global_position.distance_to(player.global_position))
			var spark = Spark.instantiate()
			spark.global_position = global_position
			var look = global_position.direction_to(player.position)
			spark.rotation = PI/2+look.angle()
			folder.add_child(spark)
		else:
			$Timer.start()
	else:
		$Timer.start()


func _on_timer_timeout():
	var folder = get_node_or_null("/root/Game/Effects")
	var player = get_node_or_null("/root/Game/Player_Container/Player")
	if folder and player:
		if global_position.distance_to(player.global_position) < 800:
			$Sprite.play("attack")
		else:
			$Timer.start()
	else:
		$Timer.start()
	


func _on_sprite_animation_finished():
	if $Sprite.animation == "attack":
		$Sprite.play("idle")
		$Timer.start()


func _on_sprite_frame_changed():
	if $Sprite.animation == "attack" and $Sprite.frame == 5:
		attack()
