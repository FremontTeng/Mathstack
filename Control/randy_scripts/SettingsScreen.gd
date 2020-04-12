extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func goToMainMenu():
	#Condition
	if (global.accountType == "Teacher"): #If account type is teacher or admin
		get_tree().change_scene("res://View/Screens_Randy/MainMenuTeachers.tscn")
	else:#If account type is student
		get_tree().change_scene("res://View/Screens_Randy/MainMenu.tscn")

func _on_Button_pressed():
	goToMainMenu()


func _on_HSlider_value_changed(value):
	AudioServer.set_bus_volume_db(0, value)
	$TextureRect/MarginContainer/MarginContainer/VBoxContainer/VBoxContainer/HBoxContainer/Label.text = str(round((value + 72) / 0.78))
	
