extends Node


const SAVE_DATA_PATH = "res://save_data.json"
var default_save_data = {
	"highScore": 0
}

func save_data_to_file(save_data):
	var json_string = JSON.stringify(save_data)
	var save_file = FileAccess.open(SAVE_DATA_PATH, FileAccess.WRITE)
	if save_file:
		save_file.store_line(json_string)
		save_file.close()

func load_data_from_file():
	if not FileAccess.file_exists(SAVE_DATA_PATH):
		return default_save_data
	#does exist
	
	var save_file = FileAccess.open(SAVE_DATA_PATH, FileAccess.READ)
	if save_file:
		var save_data = JSON.parse_string(save_file.get_as_text())
		save_file.close()
		return save_data
	return default_save_data
