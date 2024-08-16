import json

file = open('./text-data.txt', 'r')
lines = file.readlines()

def remove_newline_from_line(line):
    return line.replace('\n', '')

def convert_to_json():
    # variables
    current_object_counter = 0
    current_json_object = {}
    final_array = []

    for line in lines:
        if not line.strip():
            if current_json_object != {}:
                final_array.append(current_json_object)
            current_object_counter = 0
            current_json_object = {}
            continue
        
        if current_object_counter == 0:
            current_json_object['name'] = remove_newline_from_line(line)
            current_object_counter += 1
        elif current_object_counter == 1:
            current_json_object['description'] = remove_newline_from_line(line)
            current_object_counter += 1
        elif current_object_counter == 2:
            current_json_object['tag'] = remove_newline_from_line(line)
            current_object_counter += 1
        elif current_object_counter > 2:
            if current_json_object != {}:
                final_array.append(current_json_object)
            current_object_counter = 0
            current_json_object = {}
    
    with open('data.json', 'w', encoding='utf-8') as f:
        json.dump(final_array, f, ensure_ascii=False, indent=4)

convert_to_json()