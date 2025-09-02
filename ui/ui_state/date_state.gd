class_name DateState extends RefCounted

var day:int
var week:int
var notes:Array
func _init(new_day:int, new_week:int, new_notes:Array) -> void:
	day = new_day
	week = new_week
	notes = new_notes
