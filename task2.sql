-- II. �������� ������, ������������ ������ ���� (������ firstname) ������������� ��� ���������� � ���������� �������

USE vk;

-- Filtered & sorted list
SELECT DISTINCT firstname FROM users ORDER BY firstname ASC;

-- Full list to compare
SELECT firstname FROM users;