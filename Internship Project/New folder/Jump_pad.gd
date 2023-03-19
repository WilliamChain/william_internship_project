extends Area2D

export var jump_h = 300
export var jump_pad_time = 3

func _on_Jump_pad_body_entered(body):
	if body.name == "player":
		body.jump_pad_time = jump_pad_time
		body.jump_pad_h = jump_h
