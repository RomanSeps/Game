extends Sprite2D
@onready var collect = $Pickup


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		collect.play()
		await collect.finished
		Autoscript.score += 50
		queue_free()
