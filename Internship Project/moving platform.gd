extends Node2D

var idle_duration = 5.0

export var move_to = Vector2.RIGHT * 0
export var speed = 3.0

var follow = Vector2.ZERO

onready var platform = $platform
onready var tween = $Tween

func _ready():
	_init_tween()


func _init_tween():
	var duration = move_to.length() / speed
	tween.interpolate_property(platform, "position", Vector2.ZERO, move_to, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, idle_duration)
	tween.interpolate_property(platform, "position", move_to, Vector2.ZERO, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, duration + idle_duration * 2)
	tween.start()

func _physics_process(_delta):
	platform.position = platform.position.linear_interpolate(follow, 0.075)
