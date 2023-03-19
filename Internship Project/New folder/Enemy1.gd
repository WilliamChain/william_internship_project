extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVITY = 30
var movement = false
var motion = Vector2()
var right = 1
onready var damage = 1
var dead = false

var speed = 100

func _physics_process(_delta):
	
	motion = move_and_slide(motion, UP)
	motion.y += GRAVITY
	
	if not dead:
		move()
	
func move():
	turn()
	$AnimationPlayer.play("move")
	
	if movement:
		motion.x = speed * right
	else:
		motion.x = 0

func turn():
	if not $ray1.is_colliding() or $ray2.is_colliding():
		right *= -1
		self.scale.x *= -1

func killed():
	dead = true
	motion.y -= 200
	$AnimationPlayer.play("dead")


func _on_Timer_timeout():
	movement = true

func _on_Timer2_timeout():
	movement = false
	$Timer.start()
	

func _on_Area2D_area_entered(area):
	if area.name == "attack_col":
		killed()


func _on_Area2D2_body_entered(body):
	body.take_damage = damage

func _on_VisibilityNotifier2D_screen_exited():
	if dead:
		queue_free()
