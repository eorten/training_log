class_name DateViewModel extends RefCounted

signal next_day_requested
signal prev_day_requested
signal new_note_requested(note:String)
signal on_state_changed(new_state:DateState)

var current_state:DateState
func change_state(new_state:DateState):
	current_state = new_state
	on_state_changed.emit(new_state)

func request_next_day():
	next_day_requested.emit()

func request_prev_day():
	prev_day_requested.emit()

func request_new_note(new_note):
	new_note_requested.emit(new_note)
