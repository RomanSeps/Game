extends Area2D

@export var speed: float = 2000

func _process(delta):
	position.x -= speed * delta  # Adjust direction based on enemy type



func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"): 
		print("Player hit! Game over!")  
		queue_free() 
		Autoscript.player_hit = true
	if area.is_in_group("Box"):
		queue_free() 
