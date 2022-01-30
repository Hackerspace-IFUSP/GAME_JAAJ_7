extends KinematicBody2D

var SPEED = 300
const GRAVITY = 30
var JUMP_SPEED = 750
var UP = Vector2(0,-1)

enum {pitta,pika,nene}
var player = GAME.player

var player_hp = GAME.player_hp
var hp_max = player_hp
var player_mp = GAME.player_mp
var mp_max = player_mp
var mp_bar = 0


var motion = Vector2(0,0)
var side = 0 
var atk = 0 

enum {on_floor,on_air,atacking,dead}
var status = on_floor
var hurt = false
var atk_timer = 0 

var bullet_status = 0

var bullet = preload("res://Player/Guitar/Bullet.tscn")
var acord = preload("res://Player/Guitar/Special_nene.tscn")
var paint_bubble = preload("res://Player/Big_bubble_explosion/Special_pitta.tscn")

func _ready():
	#GAME.player_hp = 30
#	GAME.connect("die",self,"_on_die")
	pass

func _process(delta):
	$"../player_hp/hp_bar".rect_size.y = float(float(player_hp)/float(hp_max))*320
	if mp_bar >= 50:
		$"../player_hp/mp_bar".color = Color(0,1,0)
	else: 
		$"../player_hp/mp_bar".color = Color(0,0,1)
	$"../player_hp/mp_bar".rect_size.y = float(float(mp_bar)/float(mp_max))*320
	
func _physics_process(delta):
	apply_gravity()
	walk()
	jump()
	attack()
	move_and_slide(motion,UP)



	if is_on_floor() and status != atacking and status != dead:
		status = on_floor
		
	elif abs(motion.y) > 7 and status != dead:
		if player == nene:
			$anim_nene.play("Jump")
		elif player == pitta:
			$anim_pitta.play("Jump")
		elif player == pika:
			$anim_pika.play("Jump")
		status = on_air

			
		
func apply_gravity():
	if  is_on_floor() and motion.y > 0:
		motion.y = 0
	elif is_on_ceiling():
		motion.y = 1
	else:
		motion.y += GRAVITY
	
	
func walk():
	if Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right") :
		$sprite.flip_h = true
		if status == on_floor:
			if player == nene:
				$anim_nene.play("Walking")
			elif player == pitta:
				$anim_pitta.play("Walking")
			elif player == pika:
				$anim_pika.play("Walking")
				
			
		elif status == on_air:
			if player == nene:
				$anim_nene.play("Jump")
			elif player == pitta:
				$anim_pitta.play("Jump")
			elif player == pika:
				$anim_pika.play("Jump")
		$hitbox.position.x = -46
		$muzle.position.x = -46
		if status == on_air:
			motion.x = -.7*SPEED
		else:
			motion.x = -SPEED
		side = -1
	elif Input.is_action_pressed('ui_right') and not Input.is_action_pressed("ui_left") :
		$sprite.flip_h = false
		if status == on_floor:
			if player == nene:
				$anim_nene.play("Walking")
			elif player == pitta:
				$anim_pitta.play("Walking")
			elif player == pika:
				$anim_pika.play("Walking")
		elif status == on_air:
			if player == nene:
				$anim_nene.play("Jump")
			elif player == pitta:
				$anim_pitta.play("Jump")
			elif player == pika:
				$anim_pika.play("Jump")
		$hitbox.position.x = 14
		$muzle.position.x = 14
		if status == on_air:
			motion.x = .7*SPEED
		else:
			motion.x = SPEED
		side = 1
	else:
		if status == on_floor:
			if player == nene:
				$anim_nene.play("idle")
			elif player == pitta:
				$anim_pitta.play("idle")
			elif player == pika:
				$anim_pika.play("idle")
			motion.x = 0


func jump():
	if Input.is_action_pressed("jump") and is_on_floor():
		#status = on_air
		motion.y -= JUMP_SPEED


func attack():
	if player == nene:
		if Input.is_action_just_pressed("atack"):
			shoot1()
			$attacking_nene.play("attack")
			yield($attacking_nene,"animation_finished")
	
		if Input.is_action_just_pressed("special"):
			if mp_bar >= 50:
				mp_bar -= 50
				special_nene()
				$attacking_nene.play("epecial")
				yield($attacking_nene,"animation_finished")

	
	elif player == pitta:

		if Input.is_action_just_pressed("atack") and status == on_floor: 
			if atk_timer != 1:
				atk_timer = 1
				$timer_attack.start()
			motion = Vector2(0,0)
			status = atacking
			if atk ==0:
				$attacking_pitta.play("attack")
			elif atk == 1:
				$attacking_pitta.play("attack1")
				
			yield($attacking_pitta,"animation_finished")
			

			atk = atk + 1 
			
			if atk > 1:
				atk = 0

			status = on_floor
			
		if Input.is_action_just_pressed("special"):
			if mp_bar >= 50:
				mp_bar -= 50
				special_pitta()
				$attacking_pitta.play("attack")
				yield($attacking_pitta,"animation_finished")
			
	elif player == pika:

		if Input.is_action_just_pressed("atack") and status == on_floor: 
			if atk_timer != 1:
				atk_timer = 1
				$timer_attack.start()
			motion = Vector2(0,0)
			status = atacking
			if atk ==0:
				$attacking_pika.play("attack")
			elif atk == 1:
				$attacking_pika.play("attack1")
			elif atk == 2:
				$attacking_pika.play("attack2")
			elif atk == 3:
				$attacking_pika.play("attack3")
				
			yield($attacking_pika,"animation_finished")
			

			atk = atk + 1 
			
			if atk > 3:
				atk = 0

			status = on_floor

		if Input.is_action_just_pressed("special"):
			if mp_bar >= 50:
				mp_bar -= 50
				$pika_special.play("event")
				yield($pika_special,"animation_finished")

func _on_hurtbox_area_entered(area):
	if area.is_in_group("enemy_hitbox") and hurt == false:
		hurt = true
		#$sprite.visible = false
		player_hp -= 10
		#GAME.player_hp -= 10
		$hurt.play()
		$hurt_timer.start()
		$sprite.modulate = Color(0,0,0,1)
		$".".collision_layer = 4
		if player_hp <= 0:
			_on_die()
			

func _on_die():
	status = dead
	$die_anim.play("die")
	yield($die_anim,"animation_finished")
	get_tree().change_scene("res://Scenes/room/Room.tscn")

func shoot1():
	if bullet_status == 0:
		var bull = bullet.instance()
		bull.global_position = $muzle.global_position
		bull.dir = Vector2(side,0).normalized()
		get_parent().add_child(bull)
		bullet_status = 1
		$shoot_time.start()

func special_nene():
	var bull = acord.instance()
	bull.global_position = $muzle.global_position
	bull.dir = Vector2(side,0).normalized()
	get_parent().add_child(bull)
	$shoot_time.start()
	
func special_pitta():
	var bull = paint_bubble.instance()
	bull.global_position = $muzle.global_position
	bull.dir = Vector2(side,0).normalized()
	get_parent().add_child(bull)
	$shoot_time.start()

func _on_hurt_timer_timeout():
	hurt = false
	$sprite.visible = true
	$sprite.modulate = Color(1,1,1,1)
	$".".collision_layer = 1


func _on_timer_status_timeout():
	status = on_floor


func _on_shoot_time_timeout():
	bullet_status = 0


func _on_Timer_timeout():
	if mp_bar <= player_mp:
		mp_bar += 1
	$reload_mp.start()
