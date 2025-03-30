extends CharacterBody2D

var player_in_range = 0
var is_dead = false

@onready var death = $Death_sound
@onready var shot = $Shot

@export var ammo :PackedScene 
@export var fire_rate: float = 3

var can_shoot: bool = false
var shooting_timer: float = 0

func _physics_process(delta: float) -> void:
	if is_visible_in_tree():
		if not can_shoot:
			print("Enemy entered screen!")  # Debug message
			can_shoot = true
		shooting_timer -= delta
		if shooting_timer <= 0:
			shoot_projectile()
			shooting_timer = fire_rate
	else:
		if can_shoot:
			print("Enemy exited screen!") 
		can_shoot = false
	gravitational_pull(delta)
	move_and_slide()
	die()

func shoot_projectile():
	if ammo and !is_dead:
		print("Projectile fired!")  
		shot.play()
		var projectile = ammo.instantiate()
		
		# Adjust Y position (lower it)
		var spawn_offset_y = -280  # Adjust this value to move the projectile down
		projectile.global_position = global_position + Vector2(0, spawn_offset_y)
		
		get_parent().add_child(projectile)
		
func gravitational_pull(delta):
	if !is_on_floor():
		velocity += get_gravity() * delta

func die():
	if Input.is_action_just_pressed("Click") && player_in_range == 1:
		is_dead = true
		velocity.x = 1
		$Sprite2D.texture = load("res://Assets/Sniper1.png")
		Autoscript.score += 200
		death.play()
		await get_tree().create_timer(1).timeout
		queue_free()
		
	if Input.is_action_just_pressed("RClick") && player_in_range == 1:
		is_dead = true
		velocity.x = 1
		$Sprite2D.texture = load("res://Assets/Sniper1.png")
		Autoscript.score += 200
		death.play()
		await get_tree().create_timer(1).timeout
		queue_free()
		
func _on_area_2d_area_entered(area: Area2D):
	if area.is_in_group("Player"):
		player_in_range = 1 
		print(player_in_range)

func _on_area_2d_area_exited(area: Area2D):
	if area.is_in_group("Player"):
		player_in_range = 0 
