extends TabContainer

onready var environment := $"../WorldEnvironment"
onready var directional_light := $"../DirectionalLight"
onready var omni_light := $"../OmniLight"
onready var rays := directional_light.get_child(0)

func _ready() -> void:
	update_settings()

func update_settings() -> void:
	if rays:
		$"Node Settings/VBox/Exposure".set_value(rays.exposure)
		$"Node Settings/VBox/Attenuation".set_value(rays.attenuation)
		$"Node Settings/VBox/LightSize".set_value(rays.light_size)
		$"Node Settings/VBox/LightColor/Color".color = rays.get_parent().light_color
	
	$"Project Settings/VBox/SampleNumber".set_value( \
			ProjectSettings.get_setting("rendering/quality/godrays/sample_number"))
	$"Project Settings/VBox/Dither".set_value( \
			ProjectSettings.get_setting("rendering/quality/godrays/dither_amount"))
	$"Project Settings/VBox/CheckBox".pressed = \
			ProjectSettings.get_setting("rendering/quality/godrays/use_pcf5")

func _on_LightType_item_selected(ID : int) -> void:
	if ID == 0:
		environment.environment.background_mode = Environment.BG_SKY
		omni_light.visible = false
		directional_light.visible = true
		rays = directional_light.get_child(0)
	elif ID == 1:
		environment.environment.background_mode = Environment.BG_COLOR
		directional_light.visible = false
		omni_light.visible = true
		rays = omni_light.get_child(0)
	
	update_settings()

func _on_Exposure_value_changed(value : float) -> void:
	if rays:
		rays.exposure = value

func _on_Attenuation_value_changed(value : float) -> void:
	if rays:
		rays.attenuation = value

func _on_LightSize_value_changed(value : float) -> void:
	if rays:
		rays.light_size = value

func _on_Color_color_changed(color : Color) -> void:
	if rays:
		rays.get_parent().light_color = color

func _on_SampleNumber_value_changed(value : int) -> void:
	ProjectSettings.set_setting("rendering/quality/godrays/sample_number", value)

func _on_Dither_value_changed(value : float) -> void:
	ProjectSettings.set_setting("rendering/quality/godrays/dither_amount", value)

func _on_CheckBox_toggled(button_pressed : bool) -> void:
	ProjectSettings.set_setting("rendering/quality/godrays/use_pcf5", button_pressed)
