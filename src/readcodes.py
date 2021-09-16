from query import querydata

def makedict(file):
    a_dictionary = {}
    b_dictionary = {}
    c_dictionary = {}
    d_dictionary = {}
    e_dictionary = {}
    infile = open(file, 'r', encoding='utf-8')
    text = infile.readlines()
    cases = querydata()
    for line in text:
        country = line[3:].strip()
        try:
            if cases[country]:
                if cases[country] < 100:
                    key, value = line[0:2], cases[country]
                    a_dictionary[key] = value
                elif cases[country] < 200:
                    key, value = line[0:2], cases[country]
                    b_dictionary[key] = value
                elif cases[country] < 400:
                    key, value = line[0:2], cases[country]
                    c_dictionary[key] = value
                else:
                    key, value = line[0:2], cases[country]
                    d_dictionary[key] = value
            else:
                key, value = line[0:2], cases[country]
                e_dictionary[key] = value
        except:
            pass
        print(country)

    return a_dictionary, b_dictionary, c_dictionary, d_dictionary, e_dictionary