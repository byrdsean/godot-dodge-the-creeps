class_name Hud extends CanvasLayer

signal start_game

func _ready() -> void:
	pass

func _on_start_button_button_down() -> void:
	emit_signal("start_game")
