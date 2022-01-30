extends Control

enum {on_dialog,out_dialog}
var status = out_dialog
var wait_time = 2

onready var dialog = [
	"Mano!",
	"Olha que legal esse evento que vai rolar agora!",
	"A gente sempre quis fazer um jogo, acho que é uma excelente oportunidade pra começar!",
	"~trabalho, trabalho, trabalho, trabalho, trabalho~",
	".........................",
	"Legal! Finalmente terminamos",
	"Mas que porra é essa?",
]

var dialog_index = 0
var finished = false
var counter = 0 

	
func _process(delta):
	
	if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("atack") and status == out_dialog:
		dialog_events()
		load_dialog()
		
		


	
func load_dialog():
	if dialog_index < dialog.size():
		status = on_dialog
		$"../dialogue_timer".start()
		finished = false
		$RichTextLabel.bbcode_text = dialog[dialog_index]
		$RichTextLabel.percent_visible = 0
		$RichTextLabel.push_align(RichTextLabel.ALIGN_CENTER)
		$Tween.interpolate_property(
			$RichTextLabel, "percent_visible", 0, 1, wait_time,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
		yield($RichTextLabel,"draw")
		
	dialog_index += 1
	counter += 1 

func _on_Tween_tween_completed(object, key):
	finished = true
	
func dialog_events():
	#if counter < 6 and counter != 3:
	$"../AnimationPlayer".play("Event1")	
	
	#elif counter == 3:
	#	$"../AnimationPlayer".play("Event2")
		
	if counter == 6:
		$"../../Torre".show()

	elif counter == 7:
		get_tree().change_scene("res://Scenes/intro_boss.tscn")


	#elif counter > 10 && counter < dialog.size():
	#	$"../AnimationPlayer".play("Event5")

#	elif counter == (dialog.size() - 1):
#		$"../AnimationPlayer".play("Event2")
#		#yield($"../AnimationPlayer","animation_finished")
	
	
	#wait_time  = $"../AnimationPlayer".current_animation_length
	$"../dialogue_timer".wait_time = wait_time

func _on_dialogue_timer_timeout():
	status = out_dialog
