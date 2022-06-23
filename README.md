# ikea-tweets

Build a data pipeline to extract tweets mentioning IKEA and store them in tables that can be queried. 
Data is ingested from Twitter API, then moved to S3 bucket, and then transformed into tables in AWS Postgres.

### Architecture
![Data architecture](./img/pipeline.png)

1. Extract tweets with keywords "IKEA" and its variation ("Ikea", "ikea", etc.) from Twitter API
2. Move data to S3 bucket, stored in JSON files
3. Move the data to Postgres where data is stored in tables

### Steps
1. Prerequisites: [Twitter Developer](https://developer.twitter.com/) account and [AWS](https://aws.amazon.com/) account
2. Add your AWS and Twitter keys in `Dockerfile`
3. Specify your AWS S3 bucket
4. Build and run Docker image

### Future work
- Set up Airflow ochestration
- Create more data models: e.g., table `users` that is linked with table `ikea_tweets` by  foreign key `user_id`
- Create layers for data transformation: staging and mart layer
