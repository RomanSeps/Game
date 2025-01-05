extends CharacterBody2D

const gravity = 120
var player_in_range = 0

@onready var death = $Death_sound
@onready var ray_cast = $RayCast2D
@onready var timer = $Timer

@export var ammo :PackedScene



func _physics_process(delta: float) -> void:
	gravitational_pull()
	die()

		
func gravitational_pull():
	if !is_on_floor():
		velocity.y += gravity

func die():
	if Input.is_action_just_pressed("Click") && player_in_range == 1:
		$Sprite2D.texture = load("res://Assets/Enemy2.png")
		Autoscript.score += 100
		death.play()
		await get_tree().create_timer(1).timeout
		queue_free()
	

func _on_area_2d_area_entered(area: Area2D):
	player_in_range = 1 # Replace with function body.
	print(player_in_range)

func _on_area_2d_area_exited(area: Area2D):
	player_in_range = 0 # Replace with function body.
