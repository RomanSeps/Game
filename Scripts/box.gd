extends Area2D

func _on_body_entered(body):
	if body.is_in_group("Projectile"):  # Make sure projectiles are in a "projectile" group
		print("Projectile destroyed!")
		body.queue_free()  # Remove the projectile
