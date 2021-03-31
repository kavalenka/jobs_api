# Job search API - Test task

### How to setup
Run next commands in terminal
* ``bundle install``
* ``bundle exec rake db:create``
* ``bundle exec rake db:migrate``
* ``bundle exec rails s -p 3033`` will start the app

### How it works
Open ``Postman`` and import ``Jobs_api.postman_collection.json`` - can be found in root folder.
After that you can send requests and play with the app.

For ``Apply for a job`` request do not forget to add ``Bearer Token`` for authorisation from ``Login User`` request.

### Have fun!

### API Reference (Examples)

```
Create User request

curl --location --request POST 'http://localhost:3033/users' \
--form 'email="test@maisldmail.coms"' \
--form 'password="1"'
```
  
```
Login User request

curl --location --request POST 'http://localhost:3033/users/login' \
--form 'email="test@maisldmail.coms"' \
--form 'password="1"'
``` 

```
Create Job request

curl --location --request POST 'http://localhost:3033/jobs' \
--form 'title="Welder"' \
--form 'rate_per_hour="200"' \
--form 'languages="Dutch, English, German"'
```

```
Create Shift request

curl --location --request POST 'http://localhost:3033/shifts' \
--form 'start_date="2021-04-01"' \
--form 'working_hours="5"' \
--form 'job_id="21"'
```

```
Jobs Search request

curl --location --request GET 'http://localhost:3033/jobs/search?field=title&value=go'
```

```
Apply for a job request

curl --location --request POST 'http://localhost:3033/users/apply' \
--header 'Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo2fQ.sIseWJWCu-977zd0qfqyMMXv1M_xyiN5sszWniWF8Yo' \
--form 'job_id="19"'
```
