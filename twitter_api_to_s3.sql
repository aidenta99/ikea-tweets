/*********************************************************************************
Create database to store the tweets
*********************************************************************************/

use role sysadmin;

create or replace warehouse twitter_wh
  with warehouse_size = 'x-small'
  auto_suspend = 300
  auto_resume = true
  initially_suspended = true;

create or replace database twitter_db;
USE SCHEMA twitter_db.public;

/*********************************************************************************
Create external S3 stage pointing to the S3 buckets storing the tweets
*********************************************************************************/

create or replace STAGE twitter_db.public.tweets
    url = 's3://my-twitter-bucket/'
    credentials = (AWS_KEY_ID = 'xxxxxxxxxxxxxxxxxxxx'
    aws_secret_key = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx')
    file_format=(type='JSON')
    comment = 'Tweets stored in S3';

/*********************************************************************************
Create new table for storing JSON data in native format into a VARIANT column
*********************************************************************************/

create or replace table tweets(tweet variant);