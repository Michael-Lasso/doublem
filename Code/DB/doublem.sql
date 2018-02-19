/*
1 
drop table profile
*/
CREATE TABLE profile (
    `id` BINARY(16) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    age INTEGER,
    score DOUBLE,
    categories VARCHAR(1000),
    author VARCHAR(1000),
    achievements VARCHAR(1000),
    friend_list VARCHAR(1000),
    email VARCHAR(1000),
    PRIMARY KEY (`id`)
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;
/*
2
drop table user
*/
CREATE TABLE user (
    `username` VARCHAR(100) NOT NULL,
    `password` VARCHAR(100) NOT NULL,
    `id` BINARY(16) NOT NULL,
    `role` VARCHAR(100) NOT NULL,
    `salt` VARCHAR(15) NOT NULL,
    PRIMARY KEY (`username`),
    CONSTRAINT profile_fk_user FOREIGN KEY (`id`)
        REFERENCES profile (`id`)
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;
/*
3
drop table category
*/
CREATE TABLE category (
    `id` BINARY(16) NOT NULL,
    category_name VARCHAR(30) NOT NULL,
    category_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;
/*
4
drop table story
*/
CREATE TABLE story (
    `id` BINARY(16) NOT NULL,
    name VARCHAR(100),
    description VARCHAR(100) NOT NULL,
    rated VARCHAR(16) NOT NULL,
    PRIMARY KEY (`id`)
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;
/*
5
drop table episode
*/
CREATE TABLE episode (
    `id` BINARY(16) NOT NULL,
    story_id BINARY(16) NOT NULL,
    name VARCHAR(100),
    content BLOB NOT NULL,
    publish VARCHAR(100) NOT NULL,
    published_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    CONSTRAINT episode_fk_story FOREIGN KEY (story_id)
        REFERENCES story (`id`)
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;
/*
6
drop table review
*/
CREATE TABLE review (
    `id` BINARY(16) NOT NULL,
    user_id BINARY(16) NOT NULL,
    episode_id BINARY(16) NOT NULL,
    rating INTEGER,
    liked BOOLEAN,
    comment VARCHAR(1000),
    PRIMARY KEY (`id`),
    CONSTRAINT review_fk_user FOREIGN KEY (user_id)
        REFERENCES profile (`id`),
    CONSTRAINT review_fk_episode FOREIGN KEY (episode_id)
        REFERENCES episode (`id`)
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;
/*
7
drop table achievement
*/
CREATE TABLE achievement (
    `id` BINARY(16) NOT NULL,
    achievement_name VARCHAR(100) NOT NULL,
    PRIMARY KEY (`id`)
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;
/*
8
drop table event
*/
CREATE TABLE event (
    `id` BINARY(16) NOT NULL,
    event_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    description VARCHAR(252) NOT NULL,
    rated VARCHAR(16) NOT NULL,
    PRIMARY KEY (`id`)
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;
/*
9
drop table note
*/
CREATE TABLE note (
    `id` BINARY(16) NOT NULL,
    user_id BINARY(16) NOT NULL,
    episode_id BINARY(16) NOT NULL,
    coordinates VARCHAR(100),
    content VARCHAR(1000),
    note_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    CONSTRAINT note_fk_user FOREIGN KEY (user_id)
        REFERENCES profile (`id`),
    CONSTRAINT note_fk_episode FOREIGN KEY (episode_id)
        REFERENCES episode (`id`)
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;
/*
10
drop table warning
*/
CREATE TABLE warning (
    `id` BINARY(16) NOT NULL,
    episode_id BINARY(16),
    review_id BINARY(16),
    user_id BINARY(16),
    description VARCHAR(1000),
    reported_by BINARY(16) NOT NULL,
    warning_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    CONSTRAINT warning_fk_story FOREIGN KEY (episode_id)
        REFERENCES episode (`id`),
    CONSTRAINT warning_fk_review FOREIGN KEY (review_id)
        REFERENCES review (`id`),
    CONSTRAINT warning_fk_user FOREIGN KEY (user_id)
        REFERENCES profile (`id`)
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;
/*
11
drop table banned
*/
CREATE TABLE banned (
    `id` BINARY(16) NOT NULL,
    banned_user BINARY(16) NOT NULL,
    bannned_by BINARY(16) NOT NULL,
    start_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    end_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    description VARCHAR(1000) NOT NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT ban_fk_reported FOREIGN KEY (banned_user)
        REFERENCES profile (`id`),
    CONSTRAINT ban_fk_reporter FOREIGN KEY (bannned_by)
        REFERENCES profile (`id`)
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;
/*
12
drop table message
*/
CREATE TABLE message (
    `id` BINARY(16) NOT NULL,
    creator_id BINARY(16) NOT NULL,
    parent_id BINARY(16),
    content VARCHAR(1000) NOT NULL,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    CONSTRAINT message_fk_creator FOREIGN KEY (creator_id)
        REFERENCES profile (`id`),
    CONSTRAINT message_fk_parent FOREIGN KEY (parent_id)
        REFERENCES message (`id`)
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;
/*
13
drop table message_recipient
*/
CREATE TABLE message_recipient (
    recipient_id BINARY(16) NOT NULL,
    message_id BINARY(16) NOT NULL,
    is_read BOOLEAN,
    CONSTRAINT recipient_fk_recipient FOREIGN KEY (recipient_id)
        REFERENCES profile (`id`),
    CONSTRAINT recipient_fk_message FOREIGN KEY (message_id)
        REFERENCES message (`id`)
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;
/*
14
drop table user_category
*/
CREATE TABLE user_category (
    user_id BINARY(16) NOT NULL,
    category_id BINARY(16) NOT NULL,
    CONSTRAINT user_fk_category FOREIGN KEY (user_id)
        REFERENCES profile (`id`),
    CONSTRAINT category_fk_user FOREIGN KEY (category_id)
        REFERENCES category (`id`)
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;
/*
15
drop table user_story
*/
CREATE TABLE user_story (
    user_id BINARY(16) NOT NULL,
    story_id BINARY(16) NOT NULL,
    CONSTRAINT user_fk_story FOREIGN KEY (user_id)
        REFERENCES profile (`id`),
    CONSTRAINT story_fk_user FOREIGN KEY (story_id)
        REFERENCES story (`id`)
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;
/*
16
drop table user_achievement
*/
CREATE TABLE user_achievement (
    user_id BINARY(16) NOT NULL,
    achievement_id BINARY(16) NOT NULL,
    earned_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT user_fk_achievement FOREIGN KEY (user_id)
        REFERENCES profile (`id`),
    CONSTRAINT achievement_fk_user FOREIGN KEY (achievement_id)
        REFERENCES achievement (`id`)
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;
/*
17
drop table user_author
*/
CREATE TABLE user_author (
    user_id BINARY(16) NOT NULL,
    author_id BINARY(16) NOT NULL,
    earned_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT user_fk_author FOREIGN KEY (user_id)
        REFERENCES profile (`id`),
    CONSTRAINT author_fk_user FOREIGN KEY (author_id)
        REFERENCES profile (`id`)
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;
/*
18
drop table user_friend
*/
CREATE TABLE user_friend (
    user_id BINARY(16) NOT NULL,
    friend_id BINARY(16) NOT NULL,
    earned_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT user_fk_friend FOREIGN KEY (user_id)
        REFERENCES profile (`id`),
    CONSTRAINT friend_fk_user FOREIGN KEY (friend_id)
        REFERENCES profile (`id`)
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;
/*
19
drop table recommendations
*/
CREATE TABLE recommendations (
    user_id BINARY(16) NOT NULL,
    story_id BINARY(16) NOT NULL,
    CONSTRAINT recommendation_fk_user FOREIGN KEY (user_id)
        REFERENCES profile (`id`),
    CONSTRAINT recommendation_fk_story FOREIGN KEY (story_id)
        REFERENCES story (`id`)
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;
/*
20
drop table is_story_read
*/
CREATE TABLE is_story_read (
    user_id BINARY(16) NOT NULL,
    episode_id BINARY(16) NOT NULL,
    read_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT isread_fk_user FOREIGN KEY (user_id)
        REFERENCES profile (`id`),
    CONSTRAINT isread_fk_episode FOREIGN KEY (episode_id)
        REFERENCES episode (`id`)
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;
/*
21
drop table story_category
*/
CREATE TABLE story_category (
    story_id BINARY(16) NOT NULL,
    category_id BINARY(16) NOT NULL,
    CONSTRAINT category_fk_story FOREIGN KEY (story_id)
        REFERENCES story (`id`),
    CONSTRAINT story_fk_category FOREIGN KEY (category_id)
        REFERENCES category (`id`)
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;
/*
22
drop table save_episode
*/
CREATE TABLE save_episode (
    user_id BINARY(16) NOT NULL,
    episode_id BINARY(16) NOT NULL,
    CONSTRAINT save_fk_user FOREIGN KEY (user_id)
        REFERENCES profile (`id`),
    CONSTRAINT save_fk_episode FOREIGN KEY (episode_id)
        REFERENCES episode (`id`)
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;

