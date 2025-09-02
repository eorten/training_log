class_name BottomPanel extends Control
@onready var week_label: Label = %WeekLabel
@onready var day_label: Label = %DayLabel
@onready var note_container: VBoxContainer = %NoteContainer

@export var next_day_button:BaseButton
@export var prev_day_button:BaseButton
@export var add_note_button:BaseButton
@export var note_prefab:PackedScene

var _date_view_model:DateViewModel
func initialize(date_view_model:DateViewModel, add_note_button_pressed:Signal) -> void:
	_date_view_model = date_view_model
	_date_view_model.on_state_changed.connect(update_date_ui)
	next_day_button.pressed.connect(func(): _date_view_model.next_day_requested.emit())
	prev_day_button.pressed.connect(func(): _date_view_model.prev_day_requested.emit())
	add_note_button.pressed.connect(func(): add_note_button_pressed.emit())

func update_date_ui(new_state:DateState):
	week_label.text = "Week: " + str(new_state.week)
	day_label.text = "Day: " + str(new_state.day)
	
	for child in note_container.get_children():
		child.queue_free()
	for note:String in new_state.notes:
		var new_note:Note = note_prefab.instantiate()
		new_note.initialize(note)
		note_container.add_child(new_note)
