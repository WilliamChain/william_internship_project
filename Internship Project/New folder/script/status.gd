extends Control

onready var health_bar = $health_bar



func _on_player_health_updated(health):
	health_bar.value = health
