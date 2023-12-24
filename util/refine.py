from ._model import *
from .sanitize import *
import random as r


class DataExtractor:
    def __init__(self, rows: RowList) -> None:
        self.rows = rows

    def process(self, count: int):
        MAX_ORDER_ID = int(self.rows[-1]['order_id'])
        ROWS_LENGTH = len(self.rows)
        count = min(count, MAX_ORDER_ID)

        order_indices = set()
        while len(order_indices) < count:
            order_indices.add(r.randrange(MAX_ORDER_ID))
        order_indices = {oi: i for i, oi in enumerate(sorted(order_indices))}

        # we are assuming that the set is sorted
        i = 0
        CLEANED: RowList = []
        for oid, ind in order_indices.items():
            row = self.rows[i]
            row_id = int(row['order_id'])

            while row_id != oid:
                i += 1
                row = self.rows[i]
                row_id = int(row['order_id'])

            while row_id == oid:
                CLEANED.append({
                    **sanitize(row),
                    'order_id': ind + 1,
                    'pizza_ingredients': row['pizza_ingredients']
                    # Somehow original dataset contains this sequence
                    .replace(b'\xd0\xb6\xe2\x80\xa6\xe2\x80\xba'.decode(), 'N')
                })
                i += 1
                if i == ROWS_LENGTH:
                    break
                row = self.rows[i]
                row_id = int(row['order_id'])

        return CLEANED
