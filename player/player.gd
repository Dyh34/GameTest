extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	if velocity.x>0:
		animated_sprite_2d.flip_h=false
	if velocity.x<0:
		animated_sprite_2d.flip_h=true
	
	
	if is_on_floor() and velocity == Vector2(0,0):
		animated_sprite_2d.play("idle")
	if is_on_floor() and velocity != Vector2(0,0):
		animated_sprite_2d.play("run")
		
			# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		animated_sprite_2d.play("jump")
		velocity.y = JUMP_VELOCITY
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta



	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
