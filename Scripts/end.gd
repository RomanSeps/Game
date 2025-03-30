extends Control

@onready var fs = $Label3


func _on_button_pressed():
	Autoscript.finished = false
	Autoscript.score = 0
	get_tree().change_scene_to_file("res://Scenes/node_2d.tscn")


func _on_button_2_pressed():
	get_tree().quit()

func _process(delta: float) -> void:
	fs.text = str(Autoscript.score)
