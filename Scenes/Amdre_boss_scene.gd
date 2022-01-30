extends Node2D

var action = 0 

func _ready():
	$anim2.play("event")
	$music.play()

func _process(delta):
	action()
func action():
	if action == 0:
		$anim.play("idle")
		yield($anim,"animation_finished")
		action = randi()%3+1
		
	elif action == 1:
		$anim.play("event1")
		yield($anim,"animation_finished")
		action = 0
		
	elif action == 2:
		$anim.play("event2")
		yield($anim,"animation_finished")
		action = 0
		
	elif action == 3:
		$anim.play("event3")
		yield($anim,"animation_finished")
		action = 0 
