extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -800.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		$Sprite.play("jump")
	elif is_on_floor() and $Sprite.animation == "jump" and velocity.y > -500:
		$Sprite.animation = "land"
	move_and_slide()


func _on_timer_timeout():
	$Sprite.play("prejump")


func _on_sprite_animation_finished():
	if $Sprite.animation == "prejump":
		$Sprite.play("jump")
		velocity.y = JUMP_VELOCITY
	if $Sprite.animation == "land":
		$Sprite.play("Idle")


func hit():
	queue_free()
