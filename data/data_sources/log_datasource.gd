class_name LogDatasource extends RefCounted

const log_path:String = "user://log.cfg"
var _log:Dictionary[String, Dictionary] #[Date, [activity:String, notes:Array[String]]

func get_log() -> Dictionary:
	return _log

func create_default_log():
	_log = {
		"10":{"activity":"push", "notes":["bench - 90kg", "ohp - 40kg"]}
	}

func save_log():
	var save_file = FileAccess.open(log_path, FileAccess.WRITE)
	if save_file:
		var json_string = JSON.stringify(_log)
		save_file.store_line(json_string)
		print("LogDatasource: Saved")
	else:
		print("LogDatasource: Failed to open '", log_path, "'")

## Loads Log from disk, returns status from @GlobalScope.error
func load_log() -> int:
	if !_log:
		return FAILED

	#Return if no file at location
	if !FileAccess.file_exists(log_path):
		return FAILED
	
	#Return if cant open file
	var save_file = FileAccess.open(log_path, FileAccess.READ)
	if !save_file:
		print("LogDatasource: Failed open file at ", log_path)
		return FAILED
	
	var json_string := save_file.get_line() as String #JSON to sting
	var res = JSON.parse_string(json_string) as Dictionary #JSON to dict
	save_file.close()
	
	#Return if cant parse
	if !res:
		print("LogDatasource: Failed to parse to JSON")
		return FAILED
	
	_log = res
	return OK
