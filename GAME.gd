extends Node


var player_damage = 10
var player_hp = 30 #setget set_player_hp, get_player_hp
var player_mp = 50 #setget set_player_mp, get_player_mp
var xp = 0 setget set_xp, get_xp
var week = 1 setget set_week, get_week
enum {pitta,pika,nene}
var player = nene

var boss_counter = 0 

var amdre_counter = 0
var gmtk_counter = 0
var ludum_counter = 0 

enum {amdre,ludum,gmtk}
var boss = amdre

signal die
signal week

#####set get
func set_week(value):
	week = value
	if week % 3 == 0:
		emit_signal("week")
	
func get_week():
	return week

func set_xp(value):
	xp = value
	

func get_xp():
	return xp



#func set_player_hp(value):
#	player_hp = value
#	print(str(player_hp))
#	if player_hp <= 0:
#		emit_signal("die")

func set_player_hp(value):
	player_hp = value
	if player_hp <=0:
		emit_signal("die")

func get_player_hp():
	return player_hp

func set_player_mp(value):
	player_mp = value

func get_player_mp():
	return player_mp
