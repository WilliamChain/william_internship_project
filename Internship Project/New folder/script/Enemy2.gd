extends KinematicBody2D

const GRAVITY = 30
const UP = Vector2(0,-1)
var motion = Vector2()
var horiz := 0.0

var skin1 = true
var skin2 = false
var skin3 = false
var skin4 = false 
var side = -1

var movement = true
var en_flip = false
var en_attack = true

var speed = 100

func _physics_process(_delta):
	
	if en_attack:
		$Timer.start()
		en_attack = false
	
	if movement:
		move()

func move():
	
	img(1)
	motion = move_and_slide(motion, UP)
	motion.y += GRAVITY
	
	$AnimationPlayer2.play("move")
	
	if not $ray.is_colliding() or $ray2.is_colliding():
		flip()
	
	if movement:
		motion.x = speed * side
	else:
		motion.x = 0
	
	

func img(skin):
	if skin == 1:
		$Sprite.visible = true
	else:
		$Sprite.visible = false
	if skin == 2:
		$Sprite2.visible = true
	else:
		$Sprite2.visible = false
	if skin == 3:
		$Sprite3.visible = true
	else:
		$Sprite3.visible = false
	if skin == 4:
		$Sprite4.visible = true
	else:
		$Sprite4.visible = false
	
func attack():
	$enemy_damage/CollisionShape2D.disabled = true
	img(2)
	$AnimationPlayer2.play("attack")
	yield(get_tree().create_timer(2), "timeout")
	$enemy_damage/CollisionShape2D.disabled = false
	movement = true
	$Timer.start()

func flip():
	side *= -1
	self.scale.x *= -1

func _on_enemy_damage_area_entered(area):
	if en_flip && area.name == "attack_col":
		print("dead")
	if area.name == "attack_col":
		movement = false
		img(3)
		$AnimationPlayer2.play("flip")
		yield(get_tree().create_timer(0.5), "timeout")
		en_flip = true
		img(4)
		$Timer2.start()
		$AnimationPlayer2.play("flip_moving")
	
func _on_Timer2_timeout():
	en_flip = false
	img(3)
	$AnimationPlayer2.play("unflip")
	yield(get_tree().create_timer(0.5), "timeout")
	attack()


func _on_Timer_timeout():
	movement = false
	attack()
