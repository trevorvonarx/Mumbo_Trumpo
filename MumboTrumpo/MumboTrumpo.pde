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
  
  