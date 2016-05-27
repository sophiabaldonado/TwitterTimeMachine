# Spring Break Project

**Idea 1**

Use the soundcloud API to find tracks and comments with different timestamps, then use words in the comments as search terms to query a different API that provides images. Ideally I’d like to use the DeviantArt API to provide visuals, I know they have tags and search and comments accessible. So basically a song is paired with a visual representation of the comments on that song in the form of images. It  would be cool to be able to make a gif or video slideshow from these but I think that’s a future feature. Concerns: I have to look into how well you can query deviant art and get quality results and I’m not sure if soundcloud comments are rich or diverse enough to be interesting. Maybe use oauth to sign in through soundcloud if that’s even a thing.

**Idea 2**

A time machine. You choose how many hours in the future or past you want to travel and with the click of a button it provides you a fresh tweet (or multiple tweets) from people in another timezone, preferable a popular tweet or one that mentions keywords around what time it is for them. Maybe also provides other info about their location like the weather there if they provided that. Maybe use oauth to sign in through twitter and like or retweet, creepily.

**Learning Goals & Other Stuff**

Explore using new APIs in interesting ways. Learn more about RESTful APIs and how to interact with them and if I create and API it should be RESTful. I would like to involve art if possible (see idea 1). I would like to test _thoroughly_ as I build the app because I think that’s a weak spot for me historically. I will use Rails for development and in either case I would like to, if possible, make an API that provides the data and then a simple consumer for the API that should be accessible through a browser, deployed on Heroku, and have a great user experience, should also be like pretty or whatever. Target audience is basically anyone who's bored on the internet.
