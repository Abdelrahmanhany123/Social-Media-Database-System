# Social-Media-Database-System

A robust relational database schema designed to handle social media interactions, including user management, media storage (photos/videos), post categorization via hashtags, and social engagement metrics (likes, follows, and comments).
# Project Overview

This project was developed as part of the Database Systems course at the Faculty of Engineering, Ain Shams University. It focuses on implementing complex relational mappings into a functional SQL Server database.
Key Features

    User Management: Secure storage of profiles and login history.

    Media Handling: Support for multi-format posts (Photos and Videos) with metadata.

    Engagement Engine: Implementation of ON DELETE CASCADE and ON DELETE NO ACTION to manage comments, likes, and follows.

    Discovery: A dedicated Hashtag and Tagging system for post discoverability.

# Database Schema

The database consists of 11 interconnected tables. The relationships are designed to ensure data integrity and minimize redundancy.
Tables Included:

    USERS: Central profile information.

    LOGIN: Audit trail of user logins.

    POSTS: Core content table.

    PHOTOS & VIDEOS: Specialized media storage.

    COMMENTS: User-generated feedback on posts.

    HASHTAG & POST_TAG: Content categorization.

    FOLLOWERS: Many-to-many relationship for user networking.

    POST_LIKE & COMMENT_LIKE: Engagement tracking.

# How to Run

    Open SQL Server Management Studio (SSMS).

    Connect to your local or remote SQL Server instance.

    Create a new database (e.g., DB-proj).

    Copy the contents of SocialMediaSchema.sql into a new query window.

    Execute (F5) to build the schema and populate the test data.


# Verification Queries

To verify the data was inserted correctly, you can run the following test query:

    SELECT 
    U.username AS Author, 
    P.caption AS Post, 
    C.comment_text AS Comment, 
    CU.username AS Commenter
    FROM USERS U
    JOIN POSTS P ON U.user_id = P.user_id
    JOIN COMMENTS C ON P.post_id = C.post_id
