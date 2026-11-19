import sqlite3
import random
from faker import Faker

fake = Faker()

with sqlite3.connect('my_database.db') as conn:
    c = conn.cursor()

    c.execute('PRAGMA foreign_keys = ON')

    c.execute('DELETE FROM task')
    c.execute('DELETE FROM users')
    c.execute('DELETE FROM status')

    c.executemany('''
        INSERT INTO status (name) VALUES (?)
    ''',
     [('New',), ('In Progress',), ('Completed',)])

    c.execute('SELECT id FROM status')
    status_ids = [row[0] for row in c.fetchall()]

    for _ in range(20):
        fullname = fake.name()
        email = fake.unique.email()
        c.execute('INSERT INTO users (name, email) VALUES (?, ?)', (fullname, email))

    c.execute('SELECT id FROM users')
    users = [row[0] for row in c.fetchall()]

    for i in range(100):
       title = fake.sentence(nb_words=4)

       if i % 5 == 0:
           description = None
       else:
           description = fake.text()

       user_id = random.choice(users)
       status_id = random.choice(status_ids)

       c.execute('''
           INSERT INTO task (title, description, user_id, status_id) VALUES (?, ?, ?, ?)
       ''', (title, description, user_id, status_id))