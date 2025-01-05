extends CharacterBody2D

const speed = 550
const jump_power = -2000

var facing_left = 0


const acc = 50
const friction = 70

const gravity = 120

const max_jump = 2
var current_jumps = 0

@onready var jump_sound = $Jump
@onready var swing = $Sword_slash
@onready var Score = $Score

func _physics_process(delta):
	var input_dir: Vector2 = input()
	print(input_dir)
	
	if input_dir != Vector2.ZERO:
		accelerate(input_dir)
		#animation()
	else:
		add_friction()
		
	Score.text = "Score: " + str(Autoscript.score)
	
	attack()
	textures()
	player_movement()
	jump()

func input() -> Vector2:
	var input_dir = Vector2.ZERO
	
	input_dir.x = Input.get_axis("Left", "Right")
	input_dir = input_dir.normalized()
	return input_dir
		
func accelerate(direction):
	velocity = velocity.move_toward(speed * direction, acc)
	
func add_friction():
		velocity = velocity.move_toward(Vector2.ZERO, friction)

func player_movement():
	move_and_slide()

func jump():
	if Input.is_action_just_pressed("Up"):
		if current_jumps < max_jump:
			jump_sound.play() #VoiceBosch
			velocity.y = jump_power
			current_jumps = current_jumps +1
			
	else:
		velocity.y += gravity
			
		if is_on_floor():
			current_jumps = 0
			
func textures():
	if Input.is_action_just_pressed("Left"):
		$Sprite2D.texture = load("res://Assets/Projekt2-1.png")
		facing_left = 1
	if Input.is_action_just_pressed("Right"):
		$Sprite2D.texture = load("res://Assets/Projekt2.png")
		facing_left = 0
		

func attack():
	if Input.is_action_just_released("Click") && facing_left == 0:
		$Sprite2D.texture = load("res://Assets/Projekt3.png")
		swing.play()
			
			
	if Input.is_action_just_released("Click") && facing_left == 1:
		$Sprite2D.texture = load("res://Assets/Projekt3-1.png")
		swing.play()
