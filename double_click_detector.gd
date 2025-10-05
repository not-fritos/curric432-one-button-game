extends Node

@onready var click_timer = $ClickTimer
signal double_click;

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and not event.echo:
		if event.pressed && (click_timer.time_left > 0): # Timer is still going
			double_click.emit()
		else:
			click_timer.start()
