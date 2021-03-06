extends Actor

signal shoot

export var next_scene: PackedScene
export var bullet: PackedScene

func _on_EnemyDetector_area_entered(_body):
	pass

func _on_EnemyDetector_body_entered(_body):
	queue_free()
	get_tree().change_scene_to(next_scene)

func _physics_process(_delta):
	var is_jump_interrupted := Input.is_action_just_released("jump") and _velocity.y < 0.0
	var direction := get_direction()
	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
	_velocity = move_and_slide(_velocity, Vector2.UP)
	
	if Input.is_action_just_pressed("shoot"):
		shoot()

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.get_action_strength("jump") and is_on_floor() else 1.0
	)

func calculate_move_velocity(
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2,
		is_jump_interrupted: bool) -> Vector2:
	var result := linear_velocity
	result.x = speed.x * direction.x
	result.y += gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		result.y = speed.y * direction.y

	if is_jump_interrupted:
		result.y = 0.0

	return result

func shoot():
	var direction := Vector2(1, 0)
	emit_signal("shoot", bullet, self.global_position, direction)
