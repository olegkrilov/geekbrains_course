-- Lesson 6
USE vk;

-- 1) ����� ����� ��������� ������������. �� ���� ������������� ���. ���� ������� ��������, 
-- ������� ������ ���� ������� � ��������� ������������� (������� ��� ���������).

set @user_id = 1;

SELECT 
	from_user_id, COUNT(*) as total_messages 
	INTO @from_user_id, @total_messages
	FROM messages 
	WHERE to_user_id = @user_id
	GROUP BY from_user_id
	ORDER BY total_messages DESC 
	LIMIT 1;
	
SELECT 
	@from_user_id AS id,
	(SELECT CONCAT(lastname, ', ', firstname) FROM users WHERE id = @from_user_id) AS username,
	@total_messages AS total_count;



-- 2) ���������� ����� ���������� ������, ������� �������� ������������ ������ 10 ���.

set @max_age = 10;


SELECT 
	COUNT(*) AS total_likes 
	FROM (
		SELECT
			user_id AS uid,
			(SELECT TIMESTAMPDIFF(YEAR, birthday, NOW()) FROM profiles WHERE uid = user_id) AS age
			FROM likes
	) AS aggregated_list
	WHERE age <= @max_age;


-- 3) ���������� ��� ������ �������� ������ (�����): ������� ��� �������.

SELECT
	UPPER(
		CASE (gender)
	    	WHEN 'm' THEN 'male'
	    	WHEN 'f' THEN 'female'
		END
	) AS most_active,
	total_likes
	FROM (
		SELECT
			user_id AS uid,
			(SELECT gender FROM profiles WHERE uid = user_id) AS gender,
			COUNT(*) AS total_likes
			
			FROM likes
			GROUP BY gender
	) AS aggregated_list
	ORDER BY total_likes DESC
	LIMIT 1;
	


