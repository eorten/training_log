class_name UI extends Control
@onready var bottom_panel: BottomPanel = %BottomPanel
@onready var line_edit: LineEdit = %LineEdit

#Screens
@onready var log_screen: VBoxContainer = %LogScreen
@onready var settings_screen: Control = %SettingsScreen

#Buttons
signal add_note_button_pressed

#var ui_state:UIState
var _ui_view_model:UIViewmodel
func initialize(date_view_model:DateViewModel, ui_view_model:UIViewmodel) -> void:
	_ui_view_model = ui_view_model
	_ui_view_model.on_state_changed.connect(_update_ui)
	line_edit.text_submitted.connect(send_note_request)
	add_note_button_pressed.connect(func(): _ui_view_model.request_text_edit())
	bottom_panel.initialize(date_view_model, add_note_button_pressed)

func send_note_request(note:String):
	line_edit.clear()
	_ui_view_model.add_note_requested.emit(note)
	
func _update_ui(new_state:UIState):
	
	line_edit.visible = new_state.show_text_input
	if new_state.show_text_input:
		line_edit.grab_focus()
	log_screen.visible = false
	settings_screen.visible = false
	
	match new_state.screen:
		UIState.SCREEN.LOG:
			log_screen.visible = true
		UIState.SCREEN.SETTINGS:
			settings_screen.visible = true
	
func _process(delta: float) -> void:
	if !_ui_view_model.current_state or _ui_view_model.current_state.screen != UIState.SCREEN.LOG or !_ui_view_model.current_state.show_text_input:return;
	var kb_height := DisplayServer.virtual_keyboard_get_height() as int
	line_edit.position.y = -(kb_height / get_viewport_transform().get_scale().y)
	if(Input.is_action_just_pressed("click")):
		_ui_view_model.remove_text_edit()
