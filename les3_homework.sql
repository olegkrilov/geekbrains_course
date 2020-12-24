USE vk;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS chats;
DROP TABLE IF EXISTS chat_users;
DROP TABLE IF EXISTS chat_activities;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE chats(
	id SERIAL,
	status ENUM('initialized', 'active', 'finished'),
	started_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	finished_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	video_enabled BOOL
); -- chat rooms stored here, one user can participatre in many chats

CREATE TABLE chat_users(
	user_id BIGINT UNSIGNED NOT NULL,
	chat_id BIGINT UNSIGNED NOT NULL UNIQUE,
	
	status ENUM('invited', 'active', 'suspended', 'unavailable'),
	joined_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	
	PRIMARY KEY (user_id, chat_id),
	FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (chat_id) REFERENCES chats(id)
); -- chat users marked with statuses

CREATE TABLE chat_activities(
	user_id BIGINT UNSIGNED NOT NULL,
	chat_id BIGINT UNSIGNED NOT NULL UNIQUE,
	
	activity_type ENUM('text', 'emoticon', 'file', 'request'),
	activity_content TEXT,
	activity_metadata JSON,
	
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    
	PRIMARY KEY (user_id, chat_id),
	FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (chat_id) REFERENCES chats(id)
); -- content for every chat room with different type of activities




