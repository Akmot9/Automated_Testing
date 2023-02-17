import os
import json
import csv

dir_path = 'test_ihm'

# Check for JSON files
for file_name in os.listdir(dir_path):
    if file_name.endswith('.json'):
        file_path = os.path.join(dir_path, file_name)
        try:
            with open(file_path) as f:
                data = json.load(f)
                print(f"{file_name}: JSON file is readable")
        except Exception as e:
            print(f"{file_name}: JSON file is not readable. Error: {e}")

# Check for CSV files
for file_name in os.listdir(dir_path):
    if file_name.endswith('.csv'):
        file_path = os.path.join(dir_path, file_name)
        try:
            with open(file_path, newline='') as f:
                reader = csv.reader(f)
                print(f"{file_name}: CSV file is readable")
        except Exception as e:
            print(f"{file_name}: CSV file is not readable. Error: {e}")