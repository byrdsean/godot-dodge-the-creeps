class_name Player extends Area2D

@export var speed: int = 10
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var direction = Vector2.ZERO
var screen_size: Vector2 = Vector2.ZERO

func _ready() -> void:
	screen_size = get_viewport_rect().size
	animated_sprite.play()
	

func _process(_delta: float) -> void:
	direction = update_direction()
	play_new_animation()	
	position += Vector2(get_x_position_to_change(), get_y_position_to_change())
	position = position.clamp(Vector2.ZERO, screen_size)
	
	
func get_y_position_to_change() -> int:
	if direction == Vector2.UP:
		return -speed
	elif direction == Vector2.DOWN:
		return speed
	else:
		return 0
	

func get_x_position_to_change() -> int:
	if direction == Vector2.LEFT:
		return -speed
	elif direction == Vector2.RIGHT:
		return speed
	else:
		return 0
	
	
func play_new_animation() -> void:
	if direction == Vector2.DOWN || direction == Vector2.UP:
		animated_sprite.animation = "up"
	else:
		animated_sprite.animation = "walk"

	var scale_y = -1 if direction == Vector2.DOWN else 1
	var scale_x = -1 if direction == Vector2.LEFT else 1
	animated_sprite.scale = Vector2(scale_x, scale_y)


func update_direction() -> Vector2:
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
