-- III.  Написать скрипт, отмечающий несовершеннолетних пользователей как неактивных (поле is_active = false). 
-- Предварительно добавить такое поле в таблицу profiles со значением по умолчанию = true (или 1)

USE vk;

-- Add column with default value
ALTER TABLE profiles ADD is_active BOOLEAN DEFAULT true;

-- Update it with condition
UPDATE profiles 
SET is_active = IF((YEAR(CURDATE()) - YEAR(birthday)) >= 18, True, False);


-- Check results
SELECT user_id, birthday, is_active FROM profiles WHERE (YEAR(CURDATE()) - YEAR(birthday)) < 18;
SELECT user_id, birthday, is_active FROM profiles WHERE (YEAR(CURDATE()) - YEAR(birthday)) >= 18;
