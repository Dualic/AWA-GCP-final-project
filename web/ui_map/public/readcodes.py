from query import querydata

def makedict(file):
    a_dictionary = {}
    infile = open(file, 'r', encoding='utf-8')
    text = infile.readlines()
    cases = querydata()
    for line in text:
        country = line[3:].strip()
        key, value = line[0:2], cases[country]
        a_dictionary[key] = value
        print(country)
    return a_dictionary