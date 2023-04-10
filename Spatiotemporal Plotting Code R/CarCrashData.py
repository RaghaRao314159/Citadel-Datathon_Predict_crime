import csv
import pandas as pd 

with open('Crashes/crash_info_general.csv') as csv_file:
    csv_reader = csv.reader(csv_file, delimiter=',')
    
    with open('CarCrashData.csv', mode='w') as data:
        data = csv.writer(data, delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
        for row in csv_reader:
            data.writerow([row[17], row[16], row[18], row[2], row[19], row[20]])
