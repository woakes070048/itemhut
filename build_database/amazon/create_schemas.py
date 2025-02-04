#!/usr/bin/python3

import re
import os.path
import sys
import glob
import pandas as pd
import json

# from build_amazon.type_dict import type_dict
# from build_amazon.number_dict import number_dict
# from build_amazon.sql_helpers import create_helper_functions
# from build_amazon.sql_helpers import drop_build_schema

from type_dict import type_dict
from number_dict import number_dict
from sql_helpers import create_helper_functions
from sql_helpers import drop_build_schema

from pydb.dbconn import cur, dcur

def camel_to_underscore(name):
    name = re.sub('-', '_', name)
    name = re.sub('(.)([A-Z][a-z]+)', r'\1_\2', name)
    name = re.sub('([a-z0-9])([A-Z])', r'\1_\2', name)
    name = re.sub('__', '_', name)
    name = name.lower()
    return name

##
def read_excel_files():
    us = "us/"
    for xfile in glob.glob(os.path.join(us, "*.*")):
        xfile = re.sub('us/', '', xfile)
        yield xfile

def populate_excel_file_list():
    excel_files_set = set()
    for f in read_excel_files():
        excel_files_set.add(f)
    excel_files_list = list(excel_files_set)
    return excel_files_list

def generate_schema_name(xfile):
        junk, sep, name = xfile.partition("Flat.File.")
        final_name, dot, xl = name.partition(".")
        underscore_name = camel_to_underscore(final_name)
        trimmed_name = underscore_name.strip()
        schema_name = "amazon_{0}".format(underscore_name)
        if schema_name not in ["amazon_inventory_loader",
                               "amazon_price_inventory"]:
            return schema_name

def populate_schema_name_list(excel_file_list):
    schema_names = set()
    excel_schema_map = {}
    for f in excel_file_list:
        sn = generate_schema_name(f)
        if sn:
            schema_names.add(sn)
            excel_schema_map[f] = sn
    schema_names_list = list(schema_names)
    return schema_names_list, excel_schema_map
            
## create schemas
def create_schemas(sn):
    if sn:
        dbconn.cur.execute(
            """
            select create_schemas(array{0});
            """.format(sn))

def create_table_name(s):
    return camel_to_underscore(s)

def create_valid_tables(schema_name, tbl_list):
    dbconn.cur.execute(
        """
        select create_valid_tables('{0}', array{1});
        """.format(schema_name, tbl_list))

def create_template_tables(sn):
    if sn:
        dbconn.cur.execute(
            """
            select create_template_tables(array{0});
            """.format(sn))

def add_column_to_template_table(schema_name, column_name, data_type, optional):
    column_list = number_dict.get(column_name, [column_name])
    dbconn.cur.execute(
        """
        select build.add_columns_to_tamplate_tables
        ('{0}', array {1}, '{2}', '{3}');
        """.format(schema_name, column_list, data_type, optional))
            
def insert_valid_values(schema_name, table_name, value_list):
    for v in value_list:
        if str(v) != 'nan':
            try:
                dbconn.cur.execute(
                    """
                    begin;
                    insert into {0}.valid_{1} ({1})
                    select $${2}$$
                    where not exists
                        (select *
                         from {0}.valid_{1}
                         where {1} = $${2}$$);
                    commit;
                    """.format(schema_name, table_name, v))
            except:
                pass

def pg_to_tables(schema_name, pg_df):
    tbl_list = []
    pg_cols = list(pg_df.columns)
    for tbl in pg_cols:
        tbl = re.sub('-', '_', tbl)
        if " " not in tbl:
            tbl_list.append(tbl)
            create_valid_tables(schema_name, tbl_list)

def insert_pg_vals(schema_name, pg_df):
    pg_vals = pg_df.to_dict('list')
    for col, val in pg_vals.items():
        col = create_table_name(col)
        insert_valid_values(schema_name, col, val)

def create_tables(excel_schema_map):
    for xfile, schema_name in excel_schema_map.items():
        xpath_file = pd.ExcelFile(os.path.join("us/", xfile))

        try:
            #pg meaning "excel_page"
            #df meaning "DataFrame"
            pg = pd.read_excel(xpath_file,
                               sheetname = "Valid Values")
            pg_df = pd.DataFrame(pg)
        except:
            pass

        if schema_name in ["amazon_food_service_and_jan_san",
                           "amazon_food_service_and_jan_san_lite"]:

            pg_to_tables(schema_name, pg_df)
            insert_pg_vals(schema_name, pg_df)

        elif schema_name:
            pg_df.columns = pg_df.iloc[0]
            pg_df = pg_df.reindex(pg_df.index.drop(0))

            pg_to_tables(schema_name, pg_df)
            insert_pg_vals(schema_name, pg_df)

def populate_data_defs(excel_schema_map):
    for xfile, schema_name in excel_schema_map.items():
        xpath_file = pd.ExcelFile(os.path.join("us/", xfile))
        data_defs = pd.read_excel(xpath_file,
                                  sheetname = "Data Definitions")

        pg_df = pd.DataFrame(data_defs)
        pg_df.columns = pg_df.iloc[0]
        pg_df = pg_df.reindex(pg_df.index.drop(0))
        pg_json = (pg_df.to_json(orient = 'records'))
        js = json.loads(pg_json)
        if schema_name:
            for i in js:
                if i["Field Name"]:
                    fn = i["Field Name"]
                    ff = i["Accepted Values"]
                    if ff:
                        data_type = type_dict[ff]
                        r = i["Required?"]
                        add_column_to_template_table(schema_name, fn, data_type, r)

## ugh, do I really want to do this?
# def sort_template_table_colums(excel_schema_map):
#     for xfile, schema_name in excel_schema_map.items():
#         xpath_file = pd.ExcelFile(os.path.join("us/", xfile))
#         data_defs = pd.read_excel(xpath_file,
#                                   sheetname = "Template")
#         pg_df = pd.DataFrame(data_defs)
#         pg_df = pg_df.loc[[1]]
#     L = []
#     for index, row in pg_df.iterrows():
#         for i in row:
#             L.append(i)
#     print(L)

def start():
    excel_file_list = populate_excel_file_list()
    schema_names, excel_schema_map = populate_schema_name_list(excel_file_list)
    print('creating SQL helper functions')
    create_helper_functions()
    print('creating schemas')
    create_schemas(schema_names)
    print('creating template tables')
    create_template_tables(schema_names)
    print('creating constraint tables')
    create_tables(excel_schema_map)
    print('adding columns to template tables')
    populate_data_defs(excel_schema_map)
    drop_build_schema()
    dbconn.conn.commit()
    dbconn.cur.close()
    print("done")


if __name__ == '__main__':
    start()
