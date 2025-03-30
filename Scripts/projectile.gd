extends Area2D

@export var speed: float = 300

func _process(delta):
	position.x -= speed * delta  # Adjust direction based on enemy type



func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):  # Make sure the player is in a "player" group
		print("Player hit! Game over!")  
		queue_free() # Replace with function body.
		Autoscript.player_hit = true
	if area.is_in_group("Box"):
		queue_free()
