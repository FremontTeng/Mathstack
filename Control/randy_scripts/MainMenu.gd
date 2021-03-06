extends Control

var scene_path_to_load

func _ready():
	# To determine which scene to load according to which button was pressed
	for button in $TextureRect/MarginContainer/MarginContainer/VBoxContainer/MenuOptions.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])

func _on_Button_pressed(scene_to_load):
	scene_path_to_load = scene_to_load
	$FadeIn.show()
	$FadeIn.fade_in()


func _on_FadeIn_fade_finished():
	get_tree().change_scene(scene_path_to_load)


func _on_ManageQns_pressed():
	get_tree().change_scene("res://View/admin/ManageDatabase.tscn")
