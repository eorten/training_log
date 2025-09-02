class_name UIViewmodel extends RefCounted

signal add_note_requested

var current_state:UIState
signal on_state_changed
func change_state(new_state:UIState):
	current_state = new_state
	on_state_changed.emit(new_state)

func request_text_edit():
	change_state(UIState.new(current_state.screen, true))

func remove_text_edit():
	change_state(UIState.new(current_state.screen, false))
