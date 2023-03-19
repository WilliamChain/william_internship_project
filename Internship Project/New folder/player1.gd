extends KinematicBody2D

var velocity := Vector2.ZERO

export var speed : float
export var jump : float
export var jump_time_to_peak : float
export var jump_time_to_decend : float

onready var jump_velocity : float = (-2.0 * jump) / jump_time_to_peak
onready var jump_gravity : float = (2.0 * jump) / ( jump_time_to_peak * jump_time_to_peak )
onready var fall_gravity : float = (2.0 * jump) / ( jump_time_to_decend * jump_time_to_decend )


func get_gravity() -> float:
	return jump_gravity if velocity.y < 0 else fall_gravity

func _physics_process(_delta):
	
	velocity.x = get_velocity() * speed
	velocity = move_and_slide(velocity, Vector2.UP)
	velocity.y += get_gravity() * _delta
	
	
	if $RayCast2D.is_colliding() and Input.is_action_just_pressed("jump"):
		velocity.y = jump_velocity
		$animate2.play("jump")


func get_velocity():
	var horiz := 0.0
	if Input.is_action_pressed("right"):
		horiz = 1
		
	elif Input.is_action_pressed("left"):
		horiz = -1

	return horiz
