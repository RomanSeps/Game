class_name Player extends CharacterBody2D

const speed = 550
const jump_power = -2000

var can_move = true

const acc = 50
const friction = 70

const gravity = 120

const max_jump = 2
var current_jumps = 0

var player_died = false

@onready var jump_sound = $Jump
@onready var swing = $Sword_slash
@onready var death = $Die_sound
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
	game_over()
	attack()
	textures()
	player_movement()
	jump()
	
	

func input() -> Vector2:
	var input_dir = Vector2.ZERO
	
	if player_died == false and can_move:
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
	if Input.is_action_just_pressed("Up") and can_move:
		if current_jumps < max_jump:
			jump_sound.play() #VoiceBosch
			velocity.y = jump_power
			current_jumps = current_jumps +1
			
	else:
		velocity.y += gravity
			
		if is_on_floor():
			current_jumps = 0
			
func textures():
	if Input.is_action_just_pressed("Left") and player_died == false:
		$AnimatedSprite2D.flip_h = 1
		$AnimatedSprite2D.play("walk")
		await $AnimatedSprite2D.animation_finished
		$AnimatedSprite2D.play("idle")
		Autoscript.facingL = true
	if Input.is_action_just_pressed("Right") and player_died == false:
		$AnimatedSprite2D.flip_h = 0
		$AnimatedSprite2D.play("walk")
		await $AnimatedSprite2D.animation_finished
		$AnimatedSprite2D.play("idle")
		Autoscript.facingL = false

func attack():
	if Input.is_action_just_released("Click") and player_died == false:
		$AnimatedSprite2D.play("Sword1")
		swing.play()
		await get_tree().create_timer(0.5).timeout
		$AnimatedSprite2D.play("idle")
	
	if Input.is_action_just_released("RClick") and player_died == false:
		$AnimatedSprite2D.play("Sword2")
		swing.play()
		await get_tree().create_timer(0.5).timeout
		$AnimatedSprite2D.play("idle")

func game_over():
	if Autoscript.player_hit == true:
		if player_died == false:
			player_died = true
			$AnimatedSprite2D.play("Die")
			death.play()  # Play sound first
			await get_tree().create_timer(2.0).timeout
			Autoscript.player_hit = false
			queue_free()
			get_tree().change_scene_to_file("res://Scenes/Game_over.tscn")
	if Autoscript.finished == true:
		queue_free()
		get_tree().change_scene_to_file("res://Scenes/victory.tscn")
	
