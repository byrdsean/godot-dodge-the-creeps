class_name Main extends Node2D

@onready var boundary : PathFollow2D = $GameBoundary/BoundaryPath
@onready var enemy_scene: PackedScene = preload("res://enemy/enemy.tscn")
@onready var add_enemy_timer : Timer =  $AddEnemyTimer
@onready var player: Player = $Player
@onready var hud: Hud = $Hud
@onready var bg_music: AudioStreamPlayer = $BackgroundMusic
@onready var game_over_music: AudioStreamPlayer = $GameOverMusic

func _ready() -> void:
	player.visible = false
	

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
	player.visible = false
	get_tree().call_group("enemies", "queue_free")
	hud.reset()
	bg_music.stop()
	#game_over_music.play()


func _on_hud_start_game() -> void:
	add_enemy_timer.start()
	player.reset()
	player.visible = true
	bg_music.play()
	#game_over_music.stop()


func _on_background_music_finished() -> void:
	bg_music.play()
