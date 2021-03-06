# Mumbo Trumpo
## Trevor von Arx
UO ARTD 410 F 2017 Final Project

I wrote a Processing [program](#processing-sketch) which gathers the latest tweets from a given
Twitter profile, in this case, Donald Trump's Twitter (@realDonaldTrump) discarding any retweets. The first word of each of the 20 most recent tweets are then collected and displayed as a single Tweet (20 being the average tweet length word count). This project provokes the idea that even when only a single word of Donald Trump Tweets is taken out of context, and jumbled up, we can still find relationships and and trends in the language that he uses. The information is directly connected to him, because the "tweet" that is generated uses information that he contributes to the internet initially. 

A demo of my project can be viewed here: 

<a href="http://www.youtube.com/watch?feature=player_embedded&v=GSdFgdBSzPM" target="_blank"><img src="http://img.youtube.com/vi/GSdFgdBSzPM/0.jpg" 
alt="IMAGE ALT TEXT HERE" width="240" height="180" border="10" /></a>

Below is the processing sketch I have created, feel free to download and try for yourself! (note that you would need to create a twitter dev account/program and obtain and insert your unique ConsumerKey, ConsumerSecret, AccessToken, and AccessTokenSecret. I have omitted mine and replaced with "---" below. You must also dowload processing and the twitter4j library).

---

#### Processing sketch

```
import twitter4j.*;
import twitter4j.api.*;
import twitter4j.auth.*;
import twitter4j.conf.*;
import twitter4j.json.*;
import twitter4j.management.*;
import twitter4j.util.*;
import twitter4j.util.function.*;

PImage twitPic;
String username = "realDonaldTrump"; // twitter handle to search
Integer tweetCount = 20; // number of tweets to grab
String[] tweetArray = {"","","","","","","","","","","","","","","","","","","",""};
String[] firstWord = {"","","","","","","","","","","","","","","","","","","",""};
String[] arrayAppend = {};
String[] joined = {};
int [] count = new int [20];

Twitter twitter;
Class twitterAuth;
Class getTweets;
ResponseList<Status> tweets;

void setup() {
  size(1200, 630);
  twitPic = loadImage("twitPic.png");
  image(twitPic, 0, 0);
  
  twitterAuth();
  getTweets();
  
}

void draw() {
  String combine = join(firstWord, " ");
  fill(0);
  textSize(13);
  text(combine, 402, 462, 450, 300);

}

void twitterAuth() {
  println("\nAuthorizing Twitter...");

  ConfigurationBuilder cb = new ConfigurationBuilder();
  cb.setOAuthConsumerKey("---");
  cb.setOAuthConsumerSecret("---");
  cb.setOAuthAccessToken("---");
  cb.setOAuthAccessTokenSecret("---");

  TwitterFactory tf = new TwitterFactory(cb.build());
  twitter = tf.getInstance();
}

void getTweets() {
  println("\nGetting tweets...");
  try {
    Paging paging = new Paging(1, tweetCount);
    tweets = twitter.getUserTimeline(username, paging);
  }
  catch (Exception e) {
    println("Failed to search tweets: " + e.getMessage());
    System.exit(-1);
  }
  
  for (int i=0; i < tweets.size(); i++) {
    if (tweets.get(i).getText().startsWith("RT")) { // remove retweets
      tweets.remove(i);
    } else {
        String t = tweets.get(i).getText();
        count [i] = t.length();
        println(t + " (" + t.length() + ")\n");
        arrayAppend = append(tweetArray, t);
        tweetArray[i] = t;
        String[] temp = splitTokens(tweetArray[i], " ");
        firstWord[i] = temp[0];
      }
   }
}
```

  
