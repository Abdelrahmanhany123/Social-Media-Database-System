IF OBJECT_ID('COMMENT_LIKE', 'U') IS NOT NULL DROP TABLE COMMENT_LIKE;
IF OBJECT_ID('POST_TAG', 'U') IS NOT NULL DROP TABLE POST_TAG;
IF OBJECT_ID('POST_LIKE', 'U') IS NOT NULL DROP TABLE POST_LIKE;
IF OBJECT_ID('FOLLOWERS', 'U') IS NOT NULL DROP TABLE FOLLOWERS;
IF OBJECT_ID('HASHTAG', 'U') IS NOT NULL DROP TABLE HASHTAG;
IF OBJECT_ID('COMMENTS', 'U') IS NOT NULL DROP TABLE COMMENTS;
IF OBJECT_ID('VIDEOS', 'U') IS NOT NULL DROP TABLE VIDEOS;
IF OBJECT_ID('PHOTOS', 'U') IS NOT NULL DROP TABLE PHOTOS;
IF OBJECT_ID('LOGIN', 'U') IS NOT NULL DROP TABLE LOGIN;
IF OBJECT_ID('POSTS', 'U') IS NOT NULL DROP TABLE POSTS;
IF OBJECT_ID('USERS', 'U') IS NOT NULL DROP TABLE USERS;
GO
--Create tables
CREATE TABLE USERS (
    user_id INT PRIMARY KEY IDENTITY(1,1),
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(50) UNIQUE NOT NULL,
    bio VARCHAR(100),
    photo_url NVARCHAR(MAX),
    created_at DATETIME DEFAULT GETDATE()
);

CREATE TABLE  LOGIN (
    login_id INT PRIMARY KEY IDENTITY(1,1),
    login_ip VARCHAR(50) NOT NULL,
    login_time DATETIME DEFAULT GETDATE(),
    user_id INT NOT NULL,
    CONSTRAINT FK_login_user FOREIGN KEY (user_id) REFERENCES USERS(user_id)
);

CREATE TABLE POSTS (
    post_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT NOT NULL,
    CONSTRAINT FK_post_user FOREIGN KEY (user_id) REFERENCES USERS(user_id),
    location VARCHAR(100) NOT NULL,
    caption VARCHAR(300),
    created_at DATETIME DEFAULT GETDATE()
);

CREATE TABLE PHOTOS (
    photo_id INT PRIMARY KEY IDENTITY(1,1),
    photo_url NVARCHAR(MAX) NOT NULL,
    post_id INT NOT NULL,
    CONSTRAINT FK_photo_post FOREIGN KEY (post_id) REFERENCES POSTS(post_id) ON DELETE CASCADE,
    [size] VARCHAR(50) NOT NULL,
    created_at DATETIME DEFAULT GETDATE()
);

CREATE TABLE VIDEOS (
    video_id INT PRIMARY KEY IDENTITY(1,1),
    video_url NVARCHAR(MAX) NOT NULL,
    post_id INT NOT NULL,
    CONSTRAINT FK_vedio_post FOREIGN KEY (post_id) REFERENCES POSTS(post_id) ON DELETE CASCADE,
    [size] VARCHAR(50) NOT NULL,
    created_at DATETIME DEFAULT GETDATE()
);

CREATE TABLE COMMENTS (
    comment_id INT PRIMARY KEY IDENTITY(1,1),
    comment_text VARCHAR(200) NOT NULL,
    post_id INT NOT NULL,
    user_id INT NOT NULL,
    CONSTRAINT FK_comment_post FOREIGN KEY (post_id) REFERENCES POSTS(post_id) ON DELETE CASCADE,
    CONSTRAINT FK_comment_user FOREIGN KEY (user_id) REFERENCES USERS(user_id) ON DELETE CASCADE,
    created_at DATETIME DEFAULT GETDATE()
);


CREATE TABLE HASHTAG (
    hashtag_id   INT PRIMARY KEY IDENTITY(1,1),
    hashtag_name VARCHAR(100) UNIQUE NOT NULL,
    created_at   DATETIME DEFAULT GETDATE()
);


CREATE TABLE FOLLOWERS (
    follower_id INT NOT NULL,
    followee_id INT NOT NULL,
    PRIMARY KEY (follower_id, followee_id),
    FOREIGN KEY(follower_id) REFERENCES USERS(user_id),
    FOREIGN KEY(followee_id) REFERENCES USERS(user_id)
);

CREATE TABLE POST_LIKE (
    user_id    INT NOT NULL,
    post_id    INT NOT NULL,
    like_count INT DEFAULT 1,
    PRIMARY KEY (user_id, post_id),
    FOREIGN KEY (user_id) REFERENCES USERS(user_id) ON DELETE NO ACTION,
    FOREIGN KEY (post_id) REFERENCES POSTS(post_id) ON DELETE CASCADE
);

CREATE TABLE POST_TAG (
    hashtag_id INT NOT NULL,
    post_id    INT NOT NULL,
    PRIMARY KEY (hashtag_id, post_id),
    FOREIGN KEY (hashtag_id) REFERENCES HASHTAG(hashtag_id) ON DELETE CASCADE,
    FOREIGN KEY (post_id)    REFERENCES POSTS(post_id)      ON DELETE CASCADE
);

CREATE TABLE COMMENT_LIKE (
    user_id    INT NOT NULL,
    comment_id INT NOT NULL,
    like_count INT DEFAULT 1,
    PRIMARY KEY (user_id, comment_id),
    FOREIGN KEY (user_id)    REFERENCES USERS(user_id)       ON DELETE NO ACTION,
    FOREIGN KEY (comment_id) REFERENCES COMMENTS(comment_id) ON DELETE CASCADE
);






-- INSERT TEST DATA (Starting from ID 1)
INSERT INTO USERS (username, email, bio, photo_url) VALUES 
('Abdelrahman', 'abdel@asu.edu', 'Engineering Student', 'url1'),
('Yassin', 'yassin@asu.edu', 'ML Engineer', 'url2'),
('Sama', 'sama@asu.edu', 'Data-Science Major', 'url3'),
('Malak', 'malak@asu.edu', 'Tech enthusiast', 'url4'),
('Ahmed', 'ahmed@asu.edu', 'Developer', 'url5');

INSERT INTO HASHTAG (hashtag_name) VALUES ('#ASU'), ('#Database'), ('#Engineering'), ('#Code'), ('#Phase2');


INSERT INTO LOGIN (login_ip, user_id) VALUES ('192.168.1.1', 1), ('10.0.0.1', 2), ('172.16.0.1', 3), ('192.168.1.2', 4), ('10.0.0.2', 5);

INSERT INTO POSTS (user_id, location, caption) VALUES (1, 'Cairo', 'Starting Phase 2'), (2, 'Giza', 'SQL is fun'), (3, 'Alex', 'Study break'), (4, 'Cairo', 'Lab day'), (5, 'Ain Shams', 'Campus life');


INSERT INTO PHOTOS (photo_url, post_id, [size]) VALUES ('p1', 1, '2MB'), ('p2', 2, '1MB'), ('p3', 3, '300MB'), ('p4', 4, '1.5MB'), ('p5', 5, '2MB');
INSERT INTO VIDEOS (video_url, post_id, [size]) VALUES ('v1', 1, '10MB'), ('v2', 2, '5MB'), ('v3', 3, '20MB'), ('v4', 4, '15MB'), ('v5', 5, '12MB');

INSERT INTO COMMENTS (comment_text, post_id, user_id) VALUES ('Great work!', 1, 2), ('Keep it up', 2, 1), ('Nice view', 3, 4), ('Interesting', 4, 5), ('ASU pride', 5, 3);


INSERT INTO FOLLOWERS (follower_id, followee_id) VALUES (1, 2), (2, 1), (3, 4), (4, 1), (5, 2);
INSERT INTO POST_LIKE (user_id, post_id) VALUES (1, 2), (2, 1), (3, 1), (4, 5), (5, 3);
INSERT INTO POST_TAG (hashtag_id, post_id) VALUES (1, 1), (2, 1), (3, 4), (4, 2), (5, 5);
INSERT INTO COMMENT_LIKE (user_id, comment_id) VALUES (1, 1), (2, 2), (3, 3), (4, 4), (5, 5);







