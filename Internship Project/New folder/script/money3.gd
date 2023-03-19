extends Area2D

func _physics_process(_delta):
	$AnimationPlayer.play("idle")

func _on_Area2D_body_entered(_body):
	var tween = create_tween()
	
	tween.tween_property(self, "position", position + Vector2(0, -130), 0.5)
	
	tween.tween_property(self, "modulate:a", 0.0, 0.5)
	
	print("collect")
