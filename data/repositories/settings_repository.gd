class_name SettingsRepository extends RefCounted

signal on_settings_modified

var _settings_data_source:SettingsDatasource #Immutable
func _init(settings_data_source:SettingsDatasource) -> void:
	_settings_data_source = settings_data_source

func create_default_settings():
	_settings_data_source.create_default_settings()
	
## Saves settings
func save_settings():
	_settings_data_source.save_settings()

## Loads settings - returns status from @GlobalScope.error
func load_settings() -> int:
	return _settings_data_source.load_settings()

## Returns the Activities set in Settings
func get_activities() -> Array[String]:
	return _settings_data_source.get_settings().activities
