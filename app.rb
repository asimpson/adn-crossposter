require './config.rb'
require 'time'
require 'clockwork'
require 'feedzirra'
require 'sanitize'
require 'twitter'
include Clockwork

Twitter.configure do |config|
  config.consumer_key = CONSUMER_KEY
  config.consumer_secret = CONSUMER_SECRET
  config.oauth_token = OAUTH_TOKEN
  config.oauth_token_secret = OAUTH_TOKEN_SECRET
end

def trim_post(post, link)
  post_end = "..." + "\n" + link
  end_number = 139 - post_end.length
  trimmed_post = post[0..end_number] + post_end
  Twitter.update(trimmed_post)
end

def poster(post)
  clean_post = Sanitize.clean(post.summary)
  if EXCLUDE_REPLIES
    return if clean_post.index('@') == 0
  end

  if clean_post.length < 140
    Twitter.update(clean_post)
  else
    trim_post(clean_post, post.url)
  end
end

def get_feed
  time = Time.now()
  feed = Feedzirra::Feed.fetch_and_parse("https://alpha-api.app.net/feed/rss/users/#{USER}/posts")
  feed.entries.each do |post|
    poster(post) if post.published > (time - 60) 
  end
end

handler do |job|
  get_feed
end

every(1.minutes, 'get_posts')
