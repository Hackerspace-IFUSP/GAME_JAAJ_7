extends Node


var interact = false
onready var gui_week = $GUI/Control/HBoxContainer/Week
onready var inspiration = $GUI/Control/HBoxContainer/Exp

func _ready():
	$music.play()
	gui_week.text = "Dia :"+str(GAME.week)
	inspiration.text = "Exp :"+str(GAME.xp)
	$GUI/Control/HBoxContainer/Mes.text = "Mês :"+str(int(GAME.week/30))
	randomize()
	$anim.play("event")
	yield($anim,"animation_finished")
	
func _on_TextureButton_pressed():
	$PC/PCSCreen/PopupPanel.hide()
	$OverPlayer._move()


func _on_PC_body_entered(body):
	if body == $OverPlayer:
		$OverPlayer._interact()
		$PC/PCSCreen/PopupPanel.popup_centered()


func _on_Area2D_body_entered(body):
	if body == $OverPlayer:
		interaction()

func _on_Area2D_body_exited(body):
		$GUI/Control/Dialog.hide()
		
		
func interaction():
	$GUI/Control/Dialog.show()

func _on_Sim_pressed():
	GAME.xp+= (int(rand_range(1,10)))*10
	GAME.week+=1
	get_tree().change_scene("res://Scenes/room/Room.tscn")


func _on_No_pressed():
	$GUI/Control/Dialog.hide()


func _on_Button_pressed():
	$GUI/Control/PopupPanel.popup_centered()


func _on_Sair_pressed():
	get_tree().quit()


func _on_Voltar_pressed():
	$GUI/Control/PopupPanel.hide()
