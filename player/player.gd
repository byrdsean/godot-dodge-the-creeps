class_name Player extends Area2D

@export var speed: int = 10
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

const TOTAL_HEALTH: int = 10
var current_health: int = TOTAL_HEALTH

var movement_direction: Vector2 = Vector2.ZERO
var screen_size: Vector2 = Vector2.ZERO

func _ready() -> void:
	screen_size = get_viewport_rect().size
	
	
func _process(_delta) -> void:
	movement_direction = get_direction_by_key_pressed()
	if movement_direction == Vector2.ZERO:
		set_player_idle()
		return
		
	var movement_vector = Vector2.ZERO
	var scale_vector = Vector2(scale.x, scale.y)
	
	if movement_direction == Vector2.UP:
		animated_sprite.animation = PlayerConstants.UP
		movement_vector.y -= speed
		scale_vector.y = 1
	elif movement_direction == Vector2.DOWN:
		animated_sprite.animation = PlayerConstants.UP
		movement_vector.y += speed
		scale_vector.y = -1
	elif movement_direction == Vector2.LEFT:
		animated_sprite.animation = PlayerConstants.WALK
		movement_vector.x -= speed
		scale_vector.x = -1
	elif movement_direction == Vector2.RIGHT:
		animated_sprite.animation = PlayerConstants.WALK
		movement_vector.x += speed
		scale_vector.x = 1
	
	position += movement_vector
	position = position.clamp(Vector2.ZERO, screen_size)
	scale = scale_vector
	
	if !animated_sprite.is_playing():
		animated_sprite.play()


func set_player_idle() -> void:
	animated_sprite.animation = PlayerConstants.WALK
	scale = Vector2(scale.x, 1)
	if animated_sprite.is_playing():
		animated_sprite.stop()

func get_direction_by_key_pressed() -> Vector2:
	if Input.is_action_pressed("up"):
		return Vector2.UP
	elif Input.is_action_pressed("down"):
		return Vector2.DOWN
	elif Input.is_action_pressed("left"):
		return Vector2.LEFT
	elif Input.is_action_pressed("right"):
		return Vector2.RIGHT
	else:
		return Vector2.ZERO


func _on_body_shape_entered(_body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	if body is not Enemy:
		return
	
	var enemy: Enemy = body as Enemy
	current_health -= enemy.DAMAGE_POINTS
	enemy.queue_free()
