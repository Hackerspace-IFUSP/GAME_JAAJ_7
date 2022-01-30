extends Node2D



func _on_Button_pressed():
	GAME.boss = 0
	get_tree().change_scene("res://Scenes/selection_player.tscn")
func _on_Button2_pressed():
	GAME.boss = 1 
	get_tree().change_scene("res://Scenes/selection_player.tscn")
func _on_Button3_pressed():
	GAME.boss = 2
	get_tree().change_scene("res://Scenes/selection_player.tscn")
