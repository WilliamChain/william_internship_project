extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVITY = 30
var motion = Vector2()
var side = 1
var movement = true
var flip = false

onready var damage = 1

export var speed : float

func _physics_process(_delta):
	
	if $ray.is_colliding():
		flip = true
		movement = false
	
	if movement:
		move()
	else:
		idle()
	
func img(skin):
	if skin == 1:
		$Sprite.visible = true
	else:
		$Sprite.visible = false
	if skin == 2:
		$Sprite2.visible = true
	else:
		$Sprite2.visible = false

func move():
	img(1)
	$AnimationPlayer.play("attack")
	motion = move_and_slide(motion, UP)
	
	motion.x = speed * side

func idle():
	if flip:
		side *= -1
		self.scale.x *= -1
		img(2)
		flip = false
	$AnimationPlayer.play("idle")
	yield(get_tree().create_timer(2), "timeout")
	movement = true
