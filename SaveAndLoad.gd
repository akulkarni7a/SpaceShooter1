extends Node


const SAVE_DATA_PATH = "res://save_data.json"
var default_save_data = {
	highScore = 0
}

func save_data_to_file(save_data):
	var json_string = JSON.stringify(save_data) # Replaced to_json
	var save_file = FileAccess.open(SAVE_DATA_PATH, FileAccess.WRITE) # Replaced File.new() and open()
	if save_file: # Check if file opened successfully (required by FileAccess.open)
		save_file.store_line(json_string)
		save_file.close() # Close remains the same

func load_data_from_file():
	# Replaced save_file.file_exists() with FileAccess.file_exists()
	if not FileAccess.file_exists(SAVE_DATA_PATH): 
		return default_save_data
	#does exist
	
	var save_file = FileAccess.open(SAVE_DATA_PATH, FileAccess.READ) # Replaced File.new() and open()
	if save_file: # Check if file opened successfully
		# Replaced parse_json() with JSON.parse_string()
		var save_data = JSON.parse_string(save_file.get_as_text()) 
		save_file.close() # Close remains the same
		return save_data
	# If file exists but couldn't be opened (e.g., permissions), return default
	return default_save_data 
