import json
import os

# Folder containing the JSON files
folder = 'test'

# Loop through all the files in the folder
for file in os.listdir(folder):
    # Check if the file is a JSON file
    if file.endswith('.json'):
        # Open the JSON file
        file_path = os.path.join(folder, file)
        with open(file_path, 'r') as f:
            try:
                # Parse the JSON file
                data = json.load(f)
                print("The JSON file", file, "is readable.")
            except json.JSONDecodeError:
                print("The JSON file", file, "is not readable.")
