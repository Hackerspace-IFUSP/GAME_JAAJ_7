extends Area2D

var pitta_damage = 3*GAME.player_damage
var pika_damage = 2*GAME.player_damage
var damage

func _ready():
	if GAME.player == 0:
		damage = pitta_damage
	elif GAME.player == 1:
		damage = pika_damage
