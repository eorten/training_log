class_name SettingsDatasource extends RefCounted

const settings_path:String = "user://settings.cfg"
var _config:ConfigFile
var _settings:Settings

func save_settings():
	_config.save(settings_path)

## Loads settings from disk and saves Settings-object 
func load_settings() -> int:
	if !_config:
		return FAILED
	
	var err:int = _config.load(settings_path)
	if err != OK:
		return err
	
	for settings_profile:String in _config.get_sections():
		var activities = _config.get_value(settings_profile, "activities")
		_settings = Settings.new(activities)
		break
	
	return OK


## Creates config-file, applies default settings
func create_default_settings():
	_config = ConfigFile.new()
	_config.set_value("profile1", "activities", ["push", "pull", "legs", "rest"])
