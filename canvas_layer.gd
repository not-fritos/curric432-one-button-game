extends CanvasLayer

@export var slow_scale: float = 0.05
@export var drain_per_sec: float = 0.15
@export var refill_per_sec: float = 0.68
@export var rotate_speed: float = .3

@onready var bar: ProgressBar   = $"Control/MarginContainer/ProgressBar"
@onready var score_label: Label = $"Control/TopBar/ScoreLabel"
@onready var bg_music: AudioStreamPlayer = $"../bg_music"

@export var roomba: CharacterBody2D 

var charge := 1.0
var score := 0
var _keys_down := 0 

func _ready() -> void:
	Globals.TIME_MOD = 1.0
	_update_bar()
	_update_score()
	bg_music.play()

func _process(delta: float) -> void:
	var holding := (_keys_down > 0) and (charge > 0.0)

	if holding:
		Globals.TIME_MOD = slow_scale
		charge = max(0.0, charge - drain_per_sec * delta)
		bg_music.pitch_scale = lerp(0.75, 1.0, clamp(charge, 0.9, 1.0))
		_update_bar()

		if charge <= 0.0:
			Globals.TIME_MOD = 1.0
		else:
			roomba.SPEED = lerp(255, 0, charge)
			roomba.rotate(rotate_speed * delta)
	else:
		Globals.TIME_MOD = 1.0
		roomba.SPEED = lerp(0, 255, charge)
		if charge < 1.0:
			charge = min(1.0, charge + refill_per_sec * delta)
			_update_bar()
		bg_music.pitch_scale = 1.0

func _unhandled_key_input(event: InputEvent) -> void:
	if event is InputEventKey and not event.echo:
		if event.pressed:
			_keys_down += 1
		else:
			_keys_down = max(0, _keys_down - 1)

func add_points(p: int) -> void:
	score += p
	_update_score()

func _update_bar() -> void:
	
	if bar:
		bar.value = lerp(bar.min_value, bar.max_value, clamp(charge, 0.0, 1.0))

func _update_score() -> void:
	if score_label:
		score_label.text = "Score: %d" % score

func _on_roomba_score_increment() -> void:
	score = score + 1
	_update_score()

func _on_double_click_detector_double_click() -> void:
	roomba.rotate(PI)
