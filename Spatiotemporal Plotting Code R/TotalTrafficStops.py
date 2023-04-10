import csv

with open('Traffic, Investigations _ Other/traffic_stops_philadelphia.csv') as csv_file:
    csv_reader = csv.reader(csv_file, delimiter=',')
    
    with open('TotalTrafficStops.csv', mode='w') as data:
        data = csv.writer(data, delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
        for row in csv_reader:
            if row[4] != '':
                data.writerow([row[1], row[2], row[4], row[5]])
