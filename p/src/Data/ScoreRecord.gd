extends Node


signal score_updated

var score := 0 setget set_score, get_score

func set_score(value: int):
	score = value
	emit_signal("score_updated")

func get_score() -> int:
	return score

func reset():
	score = 0
