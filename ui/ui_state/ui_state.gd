class_name UIState extends RefCounted
enum SCREEN{LOG, SETTINGS}
var screen:SCREEN
var show_text_input:bool
func _init(new_screen:SCREEN, new_show_text_input:bool) -> void:
	screen = new_screen
	show_text_input = new_show_text_input
