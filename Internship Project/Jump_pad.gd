extends Area2D

export var jump_force = 500

func _on_Jump_pad_body_entered(body):
	if body.name == "player":
		body.velocity.y = jump_force
		body.move_and_slide(body.velocity)

