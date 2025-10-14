class_name Main extends Node2D

@onready var boundary : PathFollow2D = $GameBoundary/BoundaryPath
@onready var enemy_scene: PackedScene = preload("res://enemy/enemy.tscn")
@onready var add_enemy_timer : Timer =  $AddEnemyTimer
@onready var player: Player = $Player

func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	check_for_game_over()


func set_random_rotation() -> float:
	var ninety_degrees = PI / 2
	var forty_five_degrees = PI / 4
	
	var random_deviation = randf_range(-forty_five_degrees, forty_five_degrees)
	return ninety_degrees + random_deviation
	
	
func _on_add_enemy_timer_timeout() -> void:
	boundary.progress_ratio = randf()
	var enemy_rotation = boundary.rotation + set_random_rotation() 
	
	var enemy: Enemy = enemy_scene.instantiate()
	enemy.position = boundary.position
	enemy.rotation = enemy_rotation
	
	add_child(enemy)


func check_for_game_over() -> void:
	if !player || player.current_health > 0:
		return
		
	add_enemy_timer.stop()	
	player.queue_free()
	get_tree().call_group("enemies", "queue_free")
