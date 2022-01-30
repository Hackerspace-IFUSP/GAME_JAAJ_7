extends KinematicBody2D

export var enemy_hp = 500
var hp_max
var xp_count = 0 
export(int, "Amdre","Ludum","GMTK","Torre") var enemy_counter

func _ready():
	print(GAME.amdre_counter + GAME.ludum_counter + GAME.gmtk_counter)
	hp_max = enemy_hp
	GAME.week+=1

func _process(delta):
	$"../enemy_hp_bar/hp_bar".rect_size.y = float(float(enemy_hp)/float(hp_max))*320
	if enemy_hp <= 0:
		if enemy_counter == 0:
			GAME.amdre_counter = 1
		elif enemy_counter == 1:
			GAME.ludum_counter = 1
		elif enemy_counter == 2:
			GAME.gmtk_counter = 1
			
		if xp_count == 0:
			xp_count = 1
			if enemy_counter != 3:
				GAME.xp += 100
		
		if enemy_counter != 3:
		
			$"../anim".stop()
			$"../anim2".play("event1")
			yield($"../anim2","animation_finished")
		
		if (GAME.amdre_counter + GAME.ludum_counter + GAME.gmtk_counter) == 3:
			if GAME.boss_counter == 0:
				GAME.boss_counter = 1
				get_tree().change_scene("res://Scenes/Creditos.tscn")
		else:
			if enemy_counter != 3:
				get_tree().change_scene("res://Scenes/room/Room.tscn")
			else:
				queue_free()

func _on_hurtbox_area_entered(area):
	if area.is_in_group("player_hitbox"):
		enemy_hp -= area.damage
