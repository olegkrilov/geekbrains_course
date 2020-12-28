-- IV. Ќаписать скрипт, удал€ющий сообщени€ Ђиз будущегої (дата больше сегодн€шней)

USE vk;

-- First: create some "bad" messages
INSERT INTO messages 
(from_user_id, to_user_id, body, created_at)
VALUES 
('10','19','Am bad to the bone','2077-11-11 02:53:08'),
('22','13','I need your clothes, boots and motorbike','2122-11-22 04:11:07'),
('11','22','Beeeeeeeep!!!','2198-05-14 22:04:19');

-- Check them
SELECT created_at, body FROM messages WHERE created_at > NOW();

-- Now remove those rows
DELETE FROM messages WHERE created_at > NOW();

-- Check results
SELECT created_at, body FROM messages WHERE created_at > NOW();


