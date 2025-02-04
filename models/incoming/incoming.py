# This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

from pydb.dbconn import cur, dcur

def insert_invoice_data(d):
    a = dcur.execute(
        """
        begin;
        insert into incoming.orders (invoice, vendor_id, order_date,
              eta, completed, invoice_file)
        values (%(invoice)s, %(vendor_id)s, %(order_date)s::date, 
        %(eta)s::date, false, %(f-path)s);
        commit;
        """, d)

def select_incoming_order_data(oid):
    a = dcur.execute(
        """
        select incoming_order_id, invoice, vendor_id, order_date,
        eta, completed, invoice_file
        from incoming.orders
        where incoming_order_id = %s;
        """, [oid])
    a = dcur.fetchall()
    return a

def select_incoming_orders():
    a = dcur.execute(
        """
        select incoming_order_id, invoice, vendor_id, order_date,
        eta, completed
        from incoming.orders
        where completed is false
        """)
    a = dcur.fetchall()
    return a

def select_all_incoming_orders():
    a = dcur.execute(
        """
        select incoming_order_id, invoice, vendor_id, order_date,
        eta, completed
        from incoming.orders
        """)
    a = dcur.fetchall()
    return a

def set_order_complete(oid):
    a = dcur.execute(
        """
        begin;
        update incoming.orders
        set completed = True
        where incoming_order_id = %s::int;
        commit;
        """, [oid])

def select_incoming_product(oid):
    a = dcur.execute(
        """
        select sku, upc, qty
        from incoming.orders
        join incoming.order_products
        using (incoming_order_id)
        join product.sku_upc
        using (upc)
        where incoming_order_id = %s::int;
        """, [oid])
    a = dcur.fetchall()
    return a
        
def insert_incoming_order_product(d):
    a = dcur.execute(
        """
        begin;
        insert into incoming.order_products 
             (incoming_order_id, upc, qty)
        values(%(oid)s::int, %(upc)s::bigint, %(qty)s::int);
        commit;
        """, d)
        
def get_order_upc_candidates(oid):
    a = dcur.execute(
        """
        select sku, upc
        from product.sku_upc psu
        where not exists
        (select upc
        from incoming.order_products
        where upc = psu.upc
        and incoming_order_id = %s::int)
        and upc is not null;
        """, [oid])
    a = dcur.fetchall()
    return a
