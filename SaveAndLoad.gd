extends Node


const SAVE_DATA_PATH = "res://save_data.json"
var default_save_data = {
	"highScore": 0
}

func save_data_to_file(save_data_dict): # Renamed 'save_data' to 'save_data_dict' to avoid conflict with variable name
	var json_string = Json.stringify(save_data_dict)
	var save_file = FileAccess.open(SAVE_DATA_PATH, FileAccess.WRITE)
	if save_file:
		save_file.store_line(json_string)
		save_file.close()
	else:
		printerr("Error: Could not open file for writing: ", SAVE_DATA_PATH)

func load_data_from_file():
	if not FileAccess.file_exists(SAVE_DATA_PATH):
		return default_save_data
	
	var save_file = FileAccess.open(SAVE_DATA_PATH, FileAccess.READ)
	if save_file:
		var json_string = save_file.get_as_text(true) # Godot 4: get_as_text(true) for read mode
		save_file.close()
		
		if json_string.is_empty():
			printerr("Error: Save file is empty: ", SAVE_DATA_PATH)
			return default_save_data
			
		var parse_result = Json.parse_string(json_string)
		if parse_result == null: # Check if parsing failed
			printerr("Error: Could not parse JSON from file: ", SAVE_DATA_PATH)
			return default_save_data
		return parse_result
	else:
		printerr("Error: Could not open file for reading: ", SAVE_DATA_PATH)
		return default_save_data
