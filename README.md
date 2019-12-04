# Microverse Project Title - Final Project [Collaborative Project]
Ruby on Rails

### Introduction.
This project requests you to build a Facebook-like social network application.

Full task description: https://www.theodinproject.com/courses/ruby-on-rails/lessons/final-project

### Microverse Adjustments

* Skip points 16 about setting up a mailer - you will be able to do it if you complete extra task in next steps (which is optional).

* According to requirements first you should: “Think through the data architecture required to make this work. There are a lot of models and a lot of associations, so take the time to plan out your approach.” Keep that in your mind.

### Project specific

###  Ruby version

rbenv 2.6.5

###  System dependencies

Rails 6.0.1

Yarn 1.19.1

Ubuntu 18.04 & below

###  Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

### Milestone 1: Prepare data architecture documentation

Create Entity Relationship Diagram (ERD) for the following tables and its content.

1. Friendship
ID: Integer
Status: boolean
user_id: Integer
friend_id: Integer


2. User
ID: Integer
name: text
email: text
password: text
created_at: datetime
updated_at: datetime

3. Micro-Post
ID: Integer
user_id: Integer
CONTENT: text

4. Like
ID: Integer
user_ID: Integer
micropost_ID: Integer

5. Comment
ID: Integer
micropost_id: Integer
user_id: Integer
CONTENT: test
created_at: datetime
updated_at: datetime