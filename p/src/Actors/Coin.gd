extends Area2D

export var speed: int
export var lifetime: float

var velocity := Vector2.ZERO

func start(_position, _direction):
	position = _position
	rotation = _direction.angle()
	$Lifetime.wait_time = lifetime
	velocity = _direction * speed
	
func _process(delta):
	position += velocity * delta

func _on_Coin_body_entered(_body):
	if _body:
		_body.queue_free()
		ScoreRecord.score += 1

	queue_free()

func _on_Lifetime_timeout():
	queue_free()
