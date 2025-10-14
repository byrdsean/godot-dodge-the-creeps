class_name Enemy extends RigidBody2D

@onready var animated_sprite = $AnimatedSprite2D

const MIN_SPEED: int = 250
const MAX_SPEED: int = 350

const DAMAGE_POINTS: int = 1

func _ready() -> void:
	set_velocity()
	play_random_animation()


func set_velocity() -> void:
	var horizontal_velocity: int = randi_range(MIN_SPEED, MAX_SPEED)
	var velocity_vector: Vector2 = Vector2(horizontal_velocity, 0)
	linear_velocity = velocity_vector.rotated(rotation)


func play_random_animation() -> void:
	var animation_name: String = get_random_animation_name()
	animated_sprite.animation = animation_name
	animated_sprite.play()


func get_random_animation_name() -> String:
	var animation_names: PackedStringArray = animated_sprite.sprite_frames.get_animation_names()
	var random_index: int = randi_range(0, animation_names.size() - 1)
	return animation_names[random_index]


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
