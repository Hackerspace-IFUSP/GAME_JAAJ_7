extends KinematicBody2D

var velocity = Vector2.ZERO

enum {move,interact}
var status = move

	

func _physics_process(delta):
	if status == move:
		move(delta)
		
func move(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
		
	if input_vector != Vector2.ZERO:
		velocity += input_vector 
		velocity = velocity * delta * 30
		$AnimatedSprite.play("move")
		
		
	else:
		velocity = Vector2.ZERO  
		$AnimatedSprite.play("idle")
		
	move_and_slide(velocity*100)

func _interact():
	status = interact
	
func _move():
	status = move
