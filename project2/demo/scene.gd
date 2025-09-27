extends Node2D

@onready var custom_sprite = $CustomSprite
@onready var label = $PulseLabel
@onready var button = $StopButton

func _ready():
	custom_sprite.connect("pulsed", _on_pulsed)
	button.connect("pressed", custom_sprite.stop_pulsing)

func _on_pulsed():
	label.text = "Sprite pulsed!"
