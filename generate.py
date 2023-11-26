import csv
from pipeline import *

with open('data.csv') as file:
    lines = file.readlines()
    SIZE = len(lines)

rows = [*csv.DictReader(lines)]

CLEANED_DATA = DataExtractor(rows).process(count=5)
DATA = DataProcessor(CLEANED_DATA).process()
POPULATE = PopulateQueryGenerator(DATA).process()
with open('update_total_prices.sql', 'r') as file:
    UPDATE_TOTAL_PRICES_QUERY = file.read()

content = '\n\n'.join(POPULATE + [UPDATE_TOTAL_PRICES_QUERY])

with open('populate.sql', 'w') as file:
    file.write(content + '\n')
