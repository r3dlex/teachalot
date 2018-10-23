from rauth import OAuth1Service
from os import environ

twitter = OAuth1Service(
    name = 'twitter',
    consumer_key = environ['TWITTER_CONSUMER_KEY'],
    consumer_secret = environ['TWITTER_CONSUMER_SECRET'],
    request_token_url = 'https://api.twitter.com/oauth/request_token',
    access_token_url = 'https://api.twitter.com/oauth/access_token',
    base_url = 'https://api.twitter.com/1.1'
    #authorize_url = ''
)