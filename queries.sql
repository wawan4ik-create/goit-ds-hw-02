--1
SELECT * FROM tasks
WHERE user_id = 4;

--2
SELECT * FROM tasks
WHERE status_id = (
    SELECT id FROM status WHERE name = 'new'
);

--3
UPDATE tasks
SET status_id = 2
WHERE id = 2;

--4
SELECT fullname FROM users
WHERE id NOT IN (
    SELECT user_id FROM tasks
);

--5
INSERT INTO tasks (title, description, user_id, status_id)
VALUES ('New Task', 'This is a new task', 1, 1);

--6
SELECT * FROM tasks
WHERE status_id IN (
    SELECT id FROM status WHERE name != 'completed'
);

--7
DELETE FROM tasks
WHERE id = 3;

--8
SELECT * FROM users
WHERE email LIKE '%@example.com';

--9
UPDATE users
SET fullname = 'Donald Dumb'
WHERE id = 5;

--10
SELECT name as status_name, COUNT(*) as qnty
FROM tasks
LEFT JOIN status
ON status.id = tasks.status_id
GROUP BY status_name
ORDER BY qnty DESC;

--11
SELECT u.fullname, t.title
FROM tasks t 
INNER JOIN users u 
ON t.user_id = u.id 
WHERE u.email LIKE '%@example.com';

--12
SELECT * 
FROM tasks
WHERE description IS NULL;

--13
SELECT u.fullname, t.title 
FROM tasks t 
INNER JOIN users u 
ON t.user_id = u.id 
INNER JOIN status s ON t.status_id = s.id WHERE s.name = 'in progress';

--14
SELECT u.fullname, COUNT(t.id ) as qnty
FROM users u 
LEFT JOIN tasks t
ON u.id = t.user_id
GROUP BY u.id 
ORDER BY qnty DESC;