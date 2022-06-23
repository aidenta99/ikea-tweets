use role sysadmin;
use warehouse twitter_wh;
use schema twitter_db.public;

/*********************************************************************************
Check files in the bucket
*********************************************************************************/

list @twitter_db.public.tweets;
select $1 from @twitter_db.public.tweets limit 10;

/*********************************************************************************
Create a view in Postgres
*********************************************************************************/
create table ikea_tweets (
    id uuid primary key, 
    created_at timestamp not null, 
    text string not null,
    favorite_count int not null,
    retweet_count int not null,
    reply_count int not null
);

select aws_s3.table_import_from_s3(
    'ikea_tweets', 
    'id, created_at, text, favorite_count, retweet_count, reply_count', 
    '(format json, header true)',
    'tweets', 
    'twitter_wh'
)

/*********************************************************************************
Check content of the tweets view
*********************************************************************************/
select * from ikea_tweets limit 100;
