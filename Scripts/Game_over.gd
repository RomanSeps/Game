extends Control


func _on_button_pressed():
	Autoscript.score = 0
	get_tree().change_scene_to_file("res://Scenes/node_2d.tscn")# Replace with function body.



func _on_button_2_pressed() -> void:
	get_tree().quit() # Replace with function body.
