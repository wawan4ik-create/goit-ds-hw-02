import sqlite3
import os

sqlite_file = 'my_database.db'
sql_queries_create_tables = os.path.join(os.path.dirname(__file__), 'create_tables.sql')

conn = sqlite3.connect(sqlite_file)

c = conn.cursor()
c.execute('PRAGMA foreign_keys = ON')

with open(sql_queries_create_tables, 'r', encoding='utf-8') as f:
    sql_script = f.read()

c.executescript(sql_script)

conn.commit()
conn.close()