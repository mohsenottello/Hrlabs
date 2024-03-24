# Introduction

    This task has been done by docker and docker compose
    ruby version 3.3.0
    rails version 7.1.3.2
    os linux(afai in other os instead of docker compose we should use docker-compose command)
### For setting up the system you can use this secrets or you can use my master.key

    secret_key_base: 83e5d5a5a619a6f5a0141e7a41bb2063b269924ac9043efc3788ee61441187f682cb62d2c91951cb3322d52b60c62d36ea70027312dd99dab20c48481ca73766

    db:
      username: ottello
      password: ottello

    cache_server:
      app_cache: redis://redis:6379/1/cache
      expiration_minutes: 90


my master key is

    3cd18b13ca7ec8f02dbccf46b7c0f8fb


### preparing the system

```bash
    docker compose build
    docker compose run app rails db:setup
```
### running test

    docker compose run app rspec

### running server

    docker compose up

### shutting down serve

    docker compose down


# APIS

### Users

- Create "User"

  - email(required)

        curl --location --request POST '0.0.0.0:3000/api/users?email=mo.ahmadzade%40gmail.com'

- Display many "User"
    - page(optional)
    - per_page(optional)

            curl --location '0.0.0.0:3000/api/users?page=0&per_page=4'

## Messages
- Create
    - title(required)
    - body(optional)

            curl --location '0.0.0.0:3000/api/messages' \
                --header 'Authorization: eyJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6Im1vLmFobWFkemFkZUBnbWFpbC5jb20ifQ.nSCJdckdGgXy8JucFHQl_6xZ1KhE51M-wnvDUZvPVyE' \
                --form 'title="12"'

- Change
    - title(optional)
    - body(optional)

            curl --location --request PATCH '0.0.0.0:3000/api/messages/1' \
                --header 'Authorization: eyJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6Im1vLmFobWFkemFkZUBnbWFpbC5jb20ifQ.nSCJdckdGgXy8JucFHQl_6xZ1KhE51M-wnvDUZvPVyE' \
                -form 'title="12"'

- Display a "Message"

        curl --location --request GET '0.0.0.0:3000/api/messages/3' \
        --header 'Authorization: eyJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6Im1vLmFobWFkemFkZUBnbWFpbC5jb20ifQ.nSCJdckdGgXy8JucFHQl_6xZ1KhE51M-wnvDUZvPVyE'

- Display and filter many "Message"
    - page(optional)
    - per_page(optional)
    - keyword(optional)

            curl --location --request GET '0.0.0.0:3000/api/messages?keyword=test&page=0&per_page=4' \
                --header 'Authorization: eyJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6Im1vLmFobWFkemFkZUBnbWFpbC5jb20ifQ.nSCJdckdGgXy8JucFHQl_6xZ1KhE51M-wnvDUZvPVyE'

### some improvement

    - instead of using string for body in message table, we should use text
    - For report, if we have a lot of data, we must modify it to generate csv file with batches
    - For API, we can have other pagination like total or next

