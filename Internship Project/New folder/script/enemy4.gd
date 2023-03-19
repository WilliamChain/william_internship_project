extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVITY = 30
var motion = Vector2()
var side = 1

onready var damage = 1

export var speed : float

func _physics_process(_delta):

	$AnimationPlayer.play("move")
	motion = move_and_slide(motion, UP)
	
	motion.x = speed * side
	
	if not $ray2.is_colliding() or $ray.is_colliding():
		side *= -1
