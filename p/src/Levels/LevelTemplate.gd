extends Node2D


func _on_Player_shoot(bullet, _position, _direction):
	var result = bullet.instance()
	add_child(result)
	result.start(_position, _direction)
