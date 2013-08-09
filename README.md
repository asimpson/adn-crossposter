# ADN-Crossposter

This is a simple Ruby app that scrapes a App.net user's RSS feed and posts to Twitter. An ADN developer account is not required. By default it runs every minute.

I created this to run as a single worker process in it's own [Heroku](https://www.heroku.com/) app instance.

## Config.rb Setup

1. Create a Twitter app with Read/Write Access. Generate your OAuth keys from Twitter's dashboard and put all 4 keys in the `config.rb` file.

2. Fill in your App.net username in the `config.rb` file.

3. You can also choose to send @replies to Twitter or not.

## Heroku Setup

1. Create your Heroku app via Heroku's dashboard.

2. Create a git repository on your local machine and commit your config.rb changes (if you haven't already).

3. Set up a git remote pointing to Heroku. 
e.g. `git remote add heroku git@heroku.com:APP-NAME.git`

4. Push your git repo to Heroku.

5. Either through the Heroku dashboard or through your terminal, set your worker process to 1. 
e.g. `heroku ps:scale clock=1`
