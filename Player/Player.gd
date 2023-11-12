extends CharacterBody2D


const maxSpeed = 750.0
const walkSpeed = 200
const jumpForce = -400.0
var currentSpeed = 0.0
var acceleration = 35
var deceleration = 15
var running = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		if Input.is_action_pressed("Dash"):
			velocity.y = clamp(velocity.y,-999999,50)
		if not ($Sprite.animation == "Jump" and $Sprite.is_playing() and $Sprite.animation != "Fall"):
			$Sprite.play("Fall")
	elif abs(velocity.x) > 50:
		if running:
			$Sprite.play("Run")
		else:
			$Sprite.play("Walk")
	else:
		$Sprite.animation = "Idle"
	# Handle Jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		$Sprite.play("Jump")
		velocity.y = jumpForce

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("Left", "Right")
	var targetSpeed = walkSpeed
	if Input.is_action_pressed("Run"):
		running = true
		targetSpeed = maxSpeed
	else:
		running = false
	if direction:
		if direction < 0:
			$Sprite.flip_h = true
		else:
			$Sprite.flip_h = false
		if currentSpeed*direction < targetSpeed:
			if is_on_floor():
				currentSpeed+= direction*acceleration
			else:
				currentSpeed+= direction*acceleration*.5
	elif abs(currentSpeed) > 0 and is_on_floor():
		currentSpeed-= deceleration*sign(currentSpeed)
	if abs(currentSpeed) > targetSpeed:
		currentSpeed-= deceleration*sign(currentSpeed)
	if abs(currentSpeed) < 10:
		currentSpeed = 0
	currentSpeed = clamp(currentSpeed,-maxSpeed,maxSpeed)
	var ray = $RayCast2D
	ray.target_position.x = 22*sign(currentSpeed)
	if ray.is_colliding():
		currentSpeed = -currentSpeed/2
		if abs(currentSpeed*2) < 100:
			currentSpeed = 0
	velocity.x = currentSpeed
	move_and_slide()
