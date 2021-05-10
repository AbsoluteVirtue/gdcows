extends Node2D

export (PackedScene) var mob_scene

func _ready():
	randomize()
	$Music.play()


func _on_Player_shoot(bullet, _position, _direction):
	var result = bullet.instance()
	add_child(result)
	result.start(_position, _direction)
	$ShootSFX.play()


func _on_MobTimer_timeout():
	var location = $MobPath/MobSpawnLocation
	location.unit_offset = rand_range(0.125, 0.71)
	
	var mob = mob_scene.instance()
	add_child(mob)
	mob.position = location.position
	
	var velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = velocity.rotated(location.rotation + PI / 2)
