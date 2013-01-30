# Probably Worth Watching
This is a ruby tool for analyzing tweets and extracting probably-relevant videos
by being fed with a list of twitter handles that are relevant about a given
topic.

The data analysis/extraction chain goes like this.

1) Tweets are extracted from a list of people influential about a particular
topic (say, ruby)
2) Each tweet is turned into a Tweet value object and placed onto the queue.
3) The FindsLinksFilter filters out any tweets that don't have links in them.
4) The FindsVideosFilter follows the links, and filters out any tweets that
don't have embedded videos in them (vimeo, youtube, etc.)  It replaces the Tweet
on the chain with a TweetWithVideos (which is just a decorator for the Tweet
value object, but with an @videos instance variable, which is an array of Video
value objects).
5) The GathersVideoMetadataAnalyzer analyzes the videos and replaces the Video
value objects with clones, with extra metadata (title, duration, etc).
6) The RejectsVideosShorterThanFilter only passes on videos that are longer than
a given duration.
7) The PostsVideosToTheSite object posts any videos it's given to the site
(which for now just means a text file)

I'm envisioning the filter chain being built like this:

    chain = FilterChain.new
    chain << FindsLinksFilter.new
    chain << FindsVideosFilter.new
    chain << GathersVideoMetadataAnalyzer.new
    chain << RejectsVideosShorterThanFilter.new(duration=Seconds.new(300))
    chain << PostsVideosToTheSite.new

Then the chain can be executed on a given tweet by calling chain.execute(tweet)
