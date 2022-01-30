extends Node2D

var xp_count = 0

func _ready():
	GAME.week+=1
	$music.play()
	$anim.play("event")
	yield($anim,"animation_finished")
	if has_method("boss_action"):
		$boss_action.play("event")
		yield($anim,"animation_finished")

func _process(delta):
	if get_tree().get_nodes_in_group("monsters").size() == 0:
		if xp_count == 0:
			GAME.xp += 10
			xp_count += 1
		$anim.play("event1")
		yield($anim,"animation_finished")
		get_tree().change_scene("res://Scenes/room/Room.tscn")
