tool
extends HBoxContainer

signal value_changed(value)

export(String) var text = "Slider" setget set_text
export(float) var min_value = 0 setget set_min_value
export(float) var max_value = 1 setget set_max_value
export(float) var value = 0 setget set_value

func _ready():
	set_text(text)
	set_min_value(min_value)
	set_max_value(max_value)
	set_value(value)

func set_text(string):
	text = string
	if has_node("Name"):
		$Name.text = text + ": "

func set_value(val):
	value = val
	if has_node("HSlider"):
		$HSlider.value = value

func set_min_value(val):
	min_value = min(val, max_value)
	if has_node("HSlider"):
		$HSlider.min_value = min_value

func set_max_value(val):
	max_value = max(val, min_value)
	if has_node("HSlider"):
		$HSlider.max_value = max_value

func _on_HSlider_value_changed(value):
	emit_signal("value_changed", value)
	$Value.text = str(stepify(value, 0.01))
