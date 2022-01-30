extends Node2D


func _ready():
	$AnimationPlayer.play("event_1")
	yield($AnimationPlayer,"animation_finished")
	$AnimationPlayer.play("event_2")
	yield($AnimationPlayer,"animation_finished")
	$AnimationPlayer.play("event_3")
	yield($AnimationPlayer,"animation_finished")
