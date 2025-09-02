extends Node

@onready var ui: Control = %UI

@export var settings_button:BaseButton
@export var add_note_button:BaseButton

var _ui_viewmodel :UIViewmodel
var _date_viewmodel :DateViewModel
var _activity_viewmodel :ActivityViewModel

var _log_repository:LogRepository
var _settings_repository:SettingsRepository
func _ready() -> void:
	# ---Repositories---
	
	#Settings
	var settings_datasource := SettingsDatasource.new() as SettingsDatasource
	_settings_repository = SettingsRepository.new(settings_datasource) as SettingsRepository
	
	if _settings_repository.load_settings() != OK:
		print("Application: No saved settings found - creating new one")
		_settings_repository.create_default_settings()
		_settings_repository.load_settings()
	
	#Log
	var log_datasource := LogDatasource.new() as LogDatasource
	_log_repository = LogRepository.new(log_datasource) as LogRepository
	
	if _log_repository.load_log() != OK:
		print("Application: No saved log found - creating new one")
		_log_repository.create_default_log()
		_log_repository.load_log()
	
	# ---ViewModels---
	_ui_viewmodel = UIViewmodel.new() as UIViewmodel
	_date_viewmodel = DateViewModel.new() as DateViewModel
	_activity_viewmodel = ActivityViewModel.new() as ActivityViewModel
	
	_date_viewmodel.next_day_requested.connect(func(): _new_day_requested(1))
	_date_viewmodel.prev_day_requested.connect(func(): _new_day_requested(-1))
	
	_ui_viewmodel.add_note_requested.connect(_add_note)
	# ---Initial state---
	ui.initialize(_date_viewmodel, _ui_viewmodel)
	
	_date_viewmodel.change_state(DateState.new(1, 0, _log_repository.get_notes_at(1, 0)))
	_ui_viewmodel.change_state(UIState.new(UIState.SCREEN.LOG, false))

func _add_note(note:String):
	_log_repository.add_note(_date_viewmodel.current_state.day, _date_viewmodel.current_state.week, note)
	
	var day = _date_viewmodel.current_state.day
	var week = _date_viewmodel.current_state.week
	
	_ui_viewmodel.change_state(UIState.new(_ui_viewmodel.current_state.screen, false))
	_date_viewmodel.change_state(DateState.new(day, week, _log_repository.get_notes_at(day, week)))

func _new_day_requested(day:int):
	var current_state = _date_viewmodel.current_state
	var new_day = current_state.day + day
	var new_week = current_state.week
	
	if new_day > 7:
		new_day = 1
		new_week += 1
		
	elif new_day == 0:
		new_day = 1
		new_week -= 1
	_date_viewmodel.change_state(DateState.new(new_day, new_week, _log_repository.get_notes_at(new_day, new_week)))
