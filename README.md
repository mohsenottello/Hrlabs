# Introduction

Your task is to develop a REST API based on "Ruby on Rails".

# General requirements for the API

- Use JSON as data format.
- Use Postgres or SQLite as database.
- Use the latest stable Rails version.

# Model

The API is based on two models:
- User
    - email [String]
    - json_web_token [String]


- Message
    - title [String]
    - body [String]

Relation between "User" and "Message":
- "User" has many "Message".
- "Message" belongs to a "User".

# Controller

## User-Controller

Two methods must be implemented for which no authentication is required.

### Methods

1) Create "User"

The method accepts an e-mail address and checks whether it already exists in the system.
- If the e-mail address is not assigned, a json_web_token is generated and the "User" is created and displayed.
- If the e-mail address is already assigned, a response should be sent with a corresponding status code.

2) Display many "User"

- The method returns all users (email, json_web_token) that exist in the system.
- Add a suitable method to limit the number of objects returned.

### Message controller

Four methods must be implemented for which authentication is required.

### Methods

1) Create

- An authenticated "User" should be able create a "Message" that is assigned to him.

2) Change

- An authenticated "User" should be able to change a "Message" assigned to him. He may not change the assignment!

3) Display a "Message"

- Display one Message by its Message#id.

4) Display and filter many "Message"

- All "Message" objects should be returned.
- Add a suitable method to limit the number of objects returned.
- It should be possible to search for "Message" objects that are assigned to a specific "User".

# Job

Every night at 23:59 a job should run that exports all new "User" and all new "Message" objects of the current day to separate CSV files.

# Authentication

User#json_web_token never expires and does not require a refresh token.

# Testing

Test your code. We use rspec, but another test suite would also be acceptable for this task if you have more experience with another one.

# Rubocop

Format the code with the ".rubocop.yml" provided by us. See rubocop.yml

Use the following gems:
- rubocop-factory_bot
- rubocop-performance
- rubocop-rails
- rubocop-rspec
- rubocop-thread_safety

# Docker

The application should be able to be launched via Docker.

- Create Dockerfile(s) if needed.
- Create a "docker-compose.yml" file.

# readme-api.md

Should contain just a short description how to start and use the API.

- Create a readme-api.md in your project.
- Describe which configuration steps are necessary to start the API.
- Describe how the API can be accessed via "curl".
- Describe how the application can be started via docker.
