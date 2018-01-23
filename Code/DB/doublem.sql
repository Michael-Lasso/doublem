/*
1 
drop table profile
*/
CREATE TABLE profile (
user_id BIGINT NOT NULL AUTO_INCREMENT,
first_name VARCHAR(100) NOT NULL,
last_name VARCHAR(100) NOT NULL,
age INTEGER,
score DOUBLE,
categories VARCHAR(1000),
author VARCHAR(1000),
achievements VARCHAR(1000),
friend_list VARCHAR(1000),
email VARCHAR(1000),
    PRIMARY KEY (`user_id`)
)  ENGINE=INNODB AUTO_INCREMENT=1000 DEFAULT CHARSET=LATIN1; 
/*
2
drop table user
*/
CREATE TABLE user (
    `username` VARCHAR(100) NOT NULL,
    `password` VARCHAR(100) NOT NULL,
    `user_id` BIGINT NOT NULL,
    `role` VARCHAR(100) NOT NULL,
    `salt` VARCHAR(15) NOT NULL,
    PRIMARY KEY (`username`),
    CONSTRAINT profile_fk_user FOREIGN KEY (user_id)
        REFERENCES profile (user_id)
)  ENGINE=INNODB DEFAULT CHARSET=LATIN1;
/*
3
drop table category
*/
CREATE TABLE category (
    category_id BIGINT NOT NULL AUTO_INCREMENT,
    category_name VARCHAR(30) NOT NULL,
	category_date DATE,
    PRIMARY KEY (`category_id`)
)  ENGINE=INNODB AUTO_INCREMENT=1000 DEFAULT CHARSET=LATIN1;
/*
4
drop table story
*/
CREATE TABLE story (
    story_id BIGINT NOT NULL AUTO_INCREMENT,
    category_id BIGINT NOT NULL,
    description VARCHAR(100) NOT NULL,
    rated VARCHAR(16) NOT NULL,
    PRIMARY KEY (`story_id`),
    CONSTRAINT story_fk_category FOREIGN KEY (category_id)
        REFERENCES category (category_id)
)  ENGINE=INNODB AUTO_INCREMENT=1000 DEFAULT CHARSET=LATIN1; 
/*
5
drop table episode
*/
CREATE TABLE episode (
    episode_id BIGINT NOT NULL AUTO_INCREMENT,
    story_id BIGINT NOT NULL,
    content BLOB NOT NULL,
    publish VARCHAR(100) NOT NULL,
    published_date DATE,
    PRIMARY KEY (`episode_id`),
    CONSTRAINT episode_fk_story FOREIGN KEY (story_id)
        REFERENCES story (story_id)
)  ENGINE=INNODB AUTO_INCREMENT=1000 DEFAULT CHARSET=LATIN1;
/*
6
drop table review
*/
CREATE TABLE review (
    review_id BIGINT NOT NULL AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    episode_id BIGINT NOT NULL,
    rating INTEGER,
    liked BOOLEAN,
    comment VARCHAR(1000),
    PRIMARY KEY (`review_id`),
    CONSTRAINT review_fk_user FOREIGN KEY (user_id)
        REFERENCES profile (user_id),
    CONSTRAINT review_fk_episode FOREIGN KEY (episode_id)
        REFERENCES episode (episode_id)
)  ENGINE=INNODB AUTO_INCREMENT=1000 DEFAULT CHARSET=LATIN1; 
/*
7
drop table achievement
*/
CREATE TABLE achievement (
    achievement_id BIGINT NOT NULL AUTO_INCREMENT,
    achievement_name VARCHAR(100) NOT NULL,
    PRIMARY KEY (`achievement_id`)
)  ENGINE=INNODB AUTO_INCREMENT=1000 DEFAULT CHARSET=LATIN1;
/*
8
drop table suggestion
*/
CREATE TABLE suggestion (
    suggestion_id BIGINT NOT NULL AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    episode_id BIGINT NOT NULL,
    suggestion VARCHAR(1000),
    suggestion_date DATE,
    PRIMARY KEY (`suggestion_id`),
    CONSTRAINT suggestion_fk_user FOREIGN KEY (user_id)
        REFERENCES profile (user_id),
    CONSTRAINT suggestion_fk_episode FOREIGN KEY (episode_id)
        REFERENCES episode (episode_id)
)  ENGINE=INNODB AUTO_INCREMENT=1000 DEFAULT CHARSET=LATIN1;
/*
9
drop table note
*/
CREATE TABLE note (
    note_id BIGINT NOT NULL AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    episode_id BIGINT NOT NULL,
    coordinates VARCHAR(100),
    content VARCHAR(1000),
    note_date DATE,
    PRIMARY KEY (`note_id`),
    CONSTRAINT note_fk_user FOREIGN KEY (user_id)
        REFERENCES profile (user_id),
    CONSTRAINT note_fk_episode FOREIGN KEY (episode_id)
        REFERENCES episode (episode_id)
)  ENGINE=INNODB AUTO_INCREMENT=1000 DEFAULT CHARSET=LATIN1;
/*
10
drop table warning
*/
CREATE TABLE warning (
    warning_id BIGINT NOT NULL AUTO_INCREMENT,
    story_id BIGINT,
    review_id BIGINT,
    user_id BIGINT,
    description VARCHAR(1000),
    reported_by BIGINT NOT NULL,
    warning_date DATE,
    PRIMARY KEY (`warning_id`),
    CONSTRAINT warning_fk_story FOREIGN KEY (story_id)
        REFERENCES story (story_id),
    CONSTRAINT warning_fk_review FOREIGN KEY (review_id)
        REFERENCES review (review_id),
    CONSTRAINT warning_fk_user FOREIGN KEY (user_id)
        REFERENCES profile (user_id)
)  ENGINE=INNODB AUTO_INCREMENT=1000 DEFAULT CHARSET=LATIN1;
/*
11
drop table banned
*/
CREATE TABLE banned (
    ban_id BIGINT NOT NULL AUTO_INCREMENT,
    reported_id BIGINT NOT NULL,
    reporter_id BIGINT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    description VARCHAR(1000) NOT NULL,
    reported_by BIGINT NOT NULL,
    PRIMARY KEY (`ban_id`),
    CONSTRAINT ban_fk_reported FOREIGN KEY (reported_id)
        REFERENCES profile (user_id),
    CONSTRAINT ban_fk_reporter FOREIGN KEY (reporter_id)
        REFERENCES profile (user_id)
)  ENGINE=INNODB AUTO_INCREMENT=1000 DEFAULT CHARSET=LATIN1;  
/*
12
drop table user_category
*/
CREATE TABLE user_category (
    user_id BIGINT NOT NULL,
    category_id BIGINT NOT NULL,
    CONSTRAINT user_fk_category FOREIGN KEY (user_id)
        REFERENCES profile (user_id),
    CONSTRAINT category_fk_user FOREIGN KEY (category_id)
        REFERENCES category (category_id)
) ENGINE=INNODB DEFAULT CHARSET=LATIN1;
/*
13
drop table user_story
*/
CREATE TABLE user_story(
    user_id BIGINT NOT NULL,
    story_id BIGINT NOT NULL,
    CONSTRAINT user_fk_story FOREIGN KEY (user_id)
        REFERENCES profile (user_id),
    CONSTRAINT story_fk_user FOREIGN KEY (story_id)
        REFERENCES story (story_id)
) ENGINE=INNODB DEFAULT CHARSET=LATIN1;
/*
14
drop table user_achievement
*/
CREATE TABLE user_achievement(
    user_id BIGINT NOT NULL,
    achievement_id BIGINT NOT NULL,
    earned_date DATE NOT NULL,
    CONSTRAINT user_fk_achievement FOREIGN KEY (user_id)
        REFERENCES profile (user_id),
    CONSTRAINT achievement_fk_user FOREIGN KEY (achievement_id)
        REFERENCES achievement (achievement_id)
) ENGINE=INNODB DEFAULT CHARSET=LATIN1;
/*
15
drop table user_author
*/
CREATE TABLE user_author(
    user_id BIGINT NOT NULL,
    author_id BIGINT NOT NULL,
    earned_date DATE NOT NULL,
    CONSTRAINT user_fk_author FOREIGN KEY (user_id)
        REFERENCES profile (user_id),
    CONSTRAINT author_fk_user FOREIGN KEY (author_id)
        REFERENCES profile (user_id)
) ENGINE=INNODB DEFAULT CHARSET=LATIN1;
/*
16
drop table user_friend
*/
CREATE TABLE user_friend(
    user_id BIGINT NOT NULL,
    friend_id BIGINT NOT NULL,
    earned_date DATE NOT NULL,
    CONSTRAINT user_fk_friend FOREIGN KEY (user_id)
        REFERENCES profile (user_id),
    CONSTRAINT friend_fk_user FOREIGN KEY (friend_id)
        REFERENCES profile (user_id)
) ENGINE=INNODB DEFAULT CHARSET=LATIN1;
