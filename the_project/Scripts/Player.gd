extends CharacterBody2D

const SPEED = 800.0
const JUMP_VELOCITY = -20000.0
const gravity = 400

func get_input():
	velocity.x = 0
	velocity.y = gravity
	
	# Left/Right movement
	if Input.is_action_pressed("Right"):
		velocity.x = SPEED
	elif Input.is_action_pressed("Left"):
		velocity.x = -SPEED
	
	# Jump
	if Input.is_action_just_pressed("Up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	

func _physics_process(delta):
	get_input()
	move_and_slide() 
