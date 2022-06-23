/*********************************************************************************
Create storage (database) to store the tweets
Create compute (warehouse) to run analytical queries on the tweets
*********************************************************************************/

use role sysadmin;

create or replace warehouse twitter_wh
  with warehouse_size = 'x-small'
  auto_suspend = 300
  auto_resume = true
  initially_suspended = true;

CREATE OR REPLACE DATABASE twitter_db;
USE SCHEMA twitter_db.public;

/*********************************************************************************
Create external S3 stage pointing to the S3 buckets storing the tweets
*********************************************************************************/

CREATE or replace STAGE twitter_db.public.tweets
    URL = 's3://my-twitter-bucket/'
    CREDENTIALS = (AWS_KEY_ID = 'xxxxxxxxxxxxxxxxxxxx'
    AWS_SECRET_KEY = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx')
    file_format=(type='JSON')
    COMMENT = 'Tweets stored in S3';

/*********************************************************************************
Create new table for storing JSON data in native format into a VARIANT column
*********************************************************************************/

create or replace table tweets(tweet variant);