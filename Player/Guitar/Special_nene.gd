extends Area2D

var vel = 400
var dir = Vector2()
var damage = 3 * GAME.player_damage

onready var initpos = self.global_position

func _ready():
	$AnimatedSprite.play()

func _physics_process(delta):
	translate(dir * vel *delta)
	if global_position.distance_to(initpos) > 1000:
		queue_free()
		

func _on_Area2D_area_entered(area):
	if area.is_in_group("enemy_hurtbox"):
		queue_free()
