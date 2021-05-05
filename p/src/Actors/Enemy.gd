extends "res://src/Actors/Actor.gd"


onready var _timer := Timer.new()


func _ready():
	_velocity.x = -speed.x
	
	self.add_child(_timer)
	_timer.connect("timeout", self, "queue_free")
	_timer.set_wait_time(10)
	if _timer.time_left <= 0:
		_timer.start()

func _on_BulletDetector_body_entered(_body):
	get_node("CollisionShape2D").disabled = true
	queue_free()
	ScoreRecord.score += 1

func _physics_process(_delta):
	_velocity = move_and_slide(_velocity, Vector2.UP)
