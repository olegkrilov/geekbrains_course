-- III.  �������� ������, ���������� ������������������ ������������� ��� ���������� (���� is_active = false). 
-- �������������� �������� ����� ���� � ������� profiles �� ��������� �� ��������� = true (��� 1)

USE vk;

-- Add column with default value
ALTER TABLE profiles ADD is_active BOOLEAN DEFAULT true;

-- Update it with condition
UPDATE profiles 
SET is_active = IF((YEAR(CURDATE()) - YEAR(birthday)) >= 18, True, False);


-- Check results
SELECT user_id, birthday, is_active FROM profiles WHERE (YEAR(CURDATE()) - YEAR(birthday)) < 18;
SELECT user_id, birthday, is_active FROM profiles WHERE (YEAR(CURDATE()) - YEAR(birthday)) >= 18;
