extends CharacterBody2D

var maxSpeed = 750.0
const walkSpeed = 200
const jumpForce = -500.0
var currentSpeed = 0.0
var acceleration = 35
var deceleration = 15
var running = false
var lastJump = Time.get_ticks_msec()
var canHoldJump = false
var attacking = false
var canAttack = true
var recovery = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func attack():
	attacking = true
	canAttack = false
	$HitBox.hit = false
	var lookPoint = get_global_mouse_position()
	var lookVec = position.direction_to(lookPoint).normalized()
	velocity = lookVec*abs(900)
	currentSpeed = velocity.x
	$Sprite.self_modulate = Color(10,10,10)
	$HitBox.active = true
	await get_tree().create_timer(0.25).timeout
	$HitBox.active = false
	$Sprite.self_modulate = Color(1,1,1)
	attacking = false
	if not $HitBox.hit:
		recovery = true
		await get_tree().create_timer(.6).timeout
		$HitBox.hit = false
		recovery = false
		await get_tree().create_timer(1.4).timeout
		canAttack = true
	canAttack = true

func shadowed():
	var container = get_node_or_null("/root/Game/Effects")
	if container:
		var shadow = $Sprite.duplicate()
		var time = .1
		var opacity = .5
		if attacking:
			opacity = 1
		shadow.global_position = global_position
		shadow.z_index = 1
		shadow.modulate.a = opacity
		container.add_child(shadow)
		shadow.pause()
		shadow.animation = $Sprite.animation
		shadow.frame = $Sprite.frame
		var tween = get_tree().create_tween()
		tween.tween_property(shadow, "modulate:a", 0, time)
		tween.tween_callback(shadow.queue_free)

func _physics_process(delta):
	# Gravity an
	if Input.is_action_just_released("Jump"):
		canHoldJump = false
	if (not (Input.is_action_pressed("Jump") and canHoldJump) or Time.get_ticks_msec()-lastJump >= 500):
		canHoldJump = false
		velocity.y += gravity * delta
	if not is_on_floor():
		if Input.is_action_pressed("Dash"):
			velocity.y = clamp(velocity.y,-999999,50)
		if $Sprite.animation != "Fall" and not ($Sprite.animation == "Jump" and $Sprite.is_playing()) and (not Input.is_action_pressed("Jump") or Time.get_ticks_msec()-lastJump >= 500):
			$Sprite.play("Fall")
	elif abs(velocity.x) > 50:
		if running:
			$Sprite.play("Run")
		else:
			$Sprite.play("Walk")
	else:
		$Sprite.play("Idle")
	# Handle Jump.
	if not attacking and not recovery and Input.is_action_just_pressed("Jump") and is_on_floor():
		canHoldJump = true
		lastJump = Time.get_ticks_msec()
		$Sprite.play("Jump")
		velocity.y = jumpForce

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("Left", "Right")
	if attacking or recovery:
		direction = null
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
	ray.target_position.x = 18*sign(currentSpeed)
	if ray.is_colliding() and not attacking:
		currentSpeed = -currentSpeed/2
	if abs(currentSpeed) == maxSpeed or attacking:
		shadowed()
	if not attacking:
		velocity.x = currentSpeed
	rotation = 0
	if is_on_floor():
		var angle = -get_floor_normal().angle_to(Vector2.UP)
		rotation = angle
	if Input.is_action_just_pressed("Attack") and not attacking and canAttack:
		attack()
	move_and_slide()
	



func _on_void_detect_area_entered(area):
	if area.name == "Void":
		queue_free()
		
		
func hit():
	if not attacking:
		queue_free()
