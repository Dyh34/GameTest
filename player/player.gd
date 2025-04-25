extends CharacterBody2D


const SPEED = 250
const JUMP_VELOCITY = -450.0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var coyotytimer: Timer = $"../coyotytimer"

func _physics_process(delta: float) -> void:
	if velocity.x>0:
		animated_sprite_2d.flip_h=false
	if velocity.x<0:
		animated_sprite_2d.flip_h=true
	const ACCELERATION = SPEED/0.2
	

	if is_on_floor() and velocity == Vector2(0,0):
		animated_sprite_2d.play("idle")
	if is_on_floor() and velocity != Vector2(0,0):
		animated_sprite_2d.play("run")
		
			# Handle jump.
	var should_jump= is_on_floor() and Input.is_action_just_pressed("jump")
	var can_jump=coyotytimer.time_left>0 and Input.is_action_just_pressed("jump")
	if should_jump or can_jump:
		animated_sprite_2d.play("jump")
		velocity.y = JUMP_VELOCITY
		coyotytimer.stop()
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta



	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = move_toward(velocity.x,direction * SPEED,ACCELERATION*delta)
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	var was_on_floor =is_on_floor()
	

	move_and_slide()
	if is_on_floor()!=was_on_floor:
		if was_on_floor and not should_jump:
			coyotytimer.start()
		else:
			coyotytimer.stop()
