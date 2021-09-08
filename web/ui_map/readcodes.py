m = 'ui_map/countries.txt'
a_dictionary = {}

def coderead(m):
    infile = open(m, 'r')
    text = infile.readlines()
    for j in text:
        key, value = j[0:2], 0
        a_dictionary[key] = value
    print(a_dictionary)

coderead(m)