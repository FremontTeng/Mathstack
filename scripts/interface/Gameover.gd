extends Button

#Returns back to play menu
func _on_QuitButton_pressed():
	get_tree().change_scene("res://menus/gameModes/Gameover.tscn")

