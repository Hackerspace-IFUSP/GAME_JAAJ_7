extends KinematicBody2D

var velocity = Vector2()
var motion = Vector2()
var hp = 100
var counter = 0 
export var speed = 20
export var direction_h = 1
export var direction_v = 0
onready var pos = global_position
export var max_distance = 300

enum{bee,flower,cat}
export(int,"bee","flower","cat") var enemy = cat


const GRAVITY =  98
const UP = Vector2(0,-1)


func _ready():
	if enemy == 0:
		$bee.show()
		$cat.hide()
		$flower.hide()
	elif enemy == 1:
		$bee.hide()
		$cat.hide()
		$flower.show()
	
	elif enemy == 2:
		$bee.hide()
		$cat.show()
		$flower.hide()

func _physics_process(delta):
	$hp.rect_size.x = hp/10
	if hp <= 0:
		queue_free()
	
	if direction_v == 0:
		apply_gravity()
		move_and_slide(motion,UP)
	
	if abs(global_position.x - pos.x) > max_distance:
		direction_h = direction_h * -1
		$".".scale.x = -1

	
	if abs(global_position.y - pos.y) > max_distance:
		direction_v = direction_v * -1 
	
	
	if global_position.x >=  pos.x + max_distance:
		global_position.x = max_distance + pos.x
	elif global_position.x <= pos.x-max_distance:
		global_position.x = pos.x - max_distance
		
	if global_position.y >=  pos.y + max_distance:
		global_position.y = max_distance + pos.y
	elif global_position.y <= pos.y-max_distance:
		global_position.y = pos.y - max_distance
	
	velocity.x = speed * direction_h
	velocity.y = speed * direction_v
	velocity = move_and_slide(velocity, Vector2.UP)



func apply_gravity():
	if  is_on_floor():
		motion.y = 0
	elif is_on_ceiling():
		motion.y = 1
	else:
		motion.y += GRAVITY


func _on_hit_hurtbox_area_entered(area):
	if area.is_in_group("player_hitbox"):
		#$hit.play()
		hp -= area.damage
