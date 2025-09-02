class_name Note extends PanelContainer
@onready var label: Label = %Label

var _text:String
func initialize(text):
	_text = text

func _ready() -> void:
	label.text = _text
