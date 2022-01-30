extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$audio.play()
	$transition.play("event")
	$AnimationPlayer.play("Event2")
	yield($AnimationPlayer,"animation_finished")
	$AnimationPlayer.play("Event")
	yield($AnimationPlayer,"animation_finished")
	


func _on_Button_pressed():
	$transition.play("event2")
	yield($transition,"animation_finished")
	get_tree().change_scene("res://Scenes/room/Room.tscn")
