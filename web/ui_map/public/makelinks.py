import re

def identifier(file):
    reading_file = open(file, "r")

    new_file_content = ""
    for line in reading_file:
        stripped_line = line.strip()
        line_object = re.search('g class="[a-zA-Z]{2} ', stripped_line)
        if line_object:
            line_to_replace = line_object.group()
            code = f"'{line_to_replace[-3:-1]}'"
        try:
            new_line = re.sub(r'g class="[a-zA-Z]{2} ', f'g id="{code[1:3]}" class="{code[1:3]} ', line)
        except:
            new_line = line
        new_file_content += new_line
    reading_file.close()

    writing_file = open("covidmaplinks.svg", "w")
    writing_file.write(new_file_content)
    writing_file.close()