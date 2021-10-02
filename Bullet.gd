extends Area2D


var move = Vector2.ZERO
var speed = 3
var look_vec = Vector2.ZERO
var target

func _ready():
	if target != null:
		$Sprite.look_at(target.global_position)
		look_vec = target.global_position - global_position
		
func _physics_process(delta):
	move = Vector2.ZERO
	
	move = move.move_toward(look_vec, delta)
	move = move.normalized() * speed
	global_position += move
