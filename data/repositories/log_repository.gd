class_name LogRepository extends RefCounted

var _log_data_source:LogDatasource
func _init(log_data_source:LogDatasource) -> void:
	_log_data_source = log_data_source

func add_note(day, week, note):
	var key = str(day)+str(week)
	var log_dict = _log_data_source.get_log() as Dictionary[String, Dictionary] #[Date, [activity:String, notes:Array[String]]
	if !log_dict.has(key):
		log_dict[key] = {"activity":"nothing", "notes":[note]}
	else:
		log_dict[key]["notes"].append(note)

func get_notes_at(day, week) -> Array:
	var key = str(day)+str(week)
	var log_dict = _log_data_source.get_log() as Dictionary[String, Dictionary] #[Date, [activity:String, notes:Array[String]]
	if !log_dict.has(key):
		log_dict[key] = {"activity":"nothing", "notes":[]}
	return log_dict[key]["notes"]
	
func save_log():
	_log_data_source.save_log()

func load_log() -> int:
	return _log_data_source.load_log()

func get_log() -> Dictionary:
	return _log_data_source.get_log()

func create_default_log():
	_log_data_source.create_default_log()
