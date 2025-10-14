class_name Hud extends CanvasLayer

signal start_game
@onready var health_label: Label = $Health
@onready var title_label: Label = $Title
@onready var start_button: Button = $"Start Button"


func _ready() -> void:
	reset()

func _on_start_button_button_down() -> void:
	health_label.visible = true	
	title_label.visible = false
	start_button.visible = false

	emit_signal("start_game")


func reset() -> void:
	health_label.visible = false
	title_label.visible = true
	start_button.visible = true


func _on_player_hit(health: int) -> void:
	health_label.text = str(health)
