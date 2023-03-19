extends KinematicBody2D

signal health_updated(health)

var velocity := Vector2.ZERO
var horiz := 0.0
var falling = false
var once = true
var jump_pad = false
var jump_pad_h : float = 0
var jump_pad_time : float = 0
var take_damage = 0

var skin1 = true
var skin2 = false
var skin3 = false
var skin4 = false
var side = 1

var tr = true
var fl = false

export var speed : float
export var jump : float
export var jump_time_to_peak : float
export var jump_time_to_decend : float

export var max_health = 20

onready var health = max_health setget _set_health
onready var jump_velocity : float = (-2.0 * jump) / jump_time_to_peak
onready var jump_gravity : float = (2.0 * jump) / ( jump_time_to_peak * jump_time_to_peak )
onready var fall_gravity : float = (2.0 * jump) / ( jump_time_to_decend * jump_time_to_decend )

func get_gravity() -> float:
	return jump_gravity if velocity.y < 0 else fall_gravity

func _physics_process(_delta):
	
	img()
	
	if Input.is_action_pressed("right"):
		velocity.x = speed
		side = 1
		
	elif Input.is_action_pressed("left"):
		velocity.x = -speed
		side = -1
	
	else:
		velocity.x = 0
		
	if $ground.is_colliding():
		once = true
		on_floor()
	elif falling and once:
		fall()
	
	if $ground.is_colliding() and Input.is_action_just_pressed("jump"):
		velocity.y = jump_velocity
		$animate2.play("jump")
		$Timer.start()
		skin1 = fl
		skin2 = fl
		skin4 = fl
		skin3 = tr
	
	if jump_pad and jump_pad_h != 0:
		var jump_pad_velocity : float = (-2.0 * jump_pad_h) / jump_time_to_peak
		$animate2.play("jump")
		skin1 = fl
		skin2 = fl
		skin4 = fl
		skin3 = tr
		velocity.y = jump_pad_velocity
		jump_pad = false
		jump_pad_h = 0
		jump_pad_time = 0
		
	
	velocity = move_and_slide(velocity, Vector2.UP)
	velocity.y += get_gravity() * _delta
	
	if falling:
		$attack_col/CollisionShape2D.disabled = false
	else:
		$attack_col/CollisionShape2D.disabled = true
	
func on_floor():
	falling = false
	if Input.is_action_pressed("right") or Input.is_action_pressed("left"):
		skin1 = fl
		skin3 = fl
		skin4 = fl
		skin2 = tr
		$animate.play("run")
	
	else:
		skin2 = fl
		skin3 = fl
		skin4 = fl
		skin1 = tr
		$animate.play("idle")

func img():
	$Sprite.visible = skin1
	$Sprite2.visible = skin2
	$Sprite3.visible = skin3
	$Sprite4.visible = skin4
	
	$Sprite.scale.x = side
	$Sprite2.scale.x = side
	$Sprite3.scale.x = side
	$Sprite4.scale.x = side

func fall():
	once = false
	skin1 = fl
	skin2 = fl
	skin3 = fl
	skin4 = tr
	$animate2.play("fall")

func _set_health(value):
	var prev_health = health
	health = clamp(value, 0, max_health)
	if health != prev_health:
		emit_signal("health_updated", health)
		if health == 0:
			print("fail")

func _on_Timer_timeout():
	fall()
	falling = true

func _on_attack_col_area_entered(area):
	if area.name == "enemy_damage":
		velocity.y = jump_velocity
	if area.name == "Jump_pad":
		jump_pad = true

func _on_damage_body_entered(_body):
	_set_health((health - take_damage))
