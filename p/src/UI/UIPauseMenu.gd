extends Control


onready var scene_tree := get_tree()
onready var overlay : ColorRect = get_node("Overlay")
onready var score_label: Label = get_node("Label")

var paused := false setget set_paused

func _ready():
	ScoreRecord.connect("score_updated", self, "update_interface")
	update_interface()

func _unhandled_input(event: InputEvent):
	if event.is_action_pressed("pause"):
		self.paused = not paused
		scene_tree.set_input_as_handled()

func set_paused(value: bool):
	paused = value
	scene_tree.paused = value
	overlay.visible = value

func update_interface():
	score_label.text = "Score: %s" % ScoreRecord.score
