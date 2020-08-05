package objectstructures;

import java.util.Vector;

public class TwitterAccount {
	private String _username;
	private int TweetCount;
	private int _retweetCount;
	
	private Vector<Tweet> _tweets;
	private Vector<TwitterAccount> _following;
	
	/**
	 * konstruktør for TwitterAccount
	 * @param Username Brukernavn av Twitteraccount
	 */
	public TwitterAccount(String username){
		_username=username;
		_tweets = new Vector<Tweet>();
		_following = new Vector<TwitterAccount>();
	}
	
	public String getUserName() {
		return _username;
	}
	
	public void follow(TwitterAccount account) {
		if (!isFollowing(account)) {
			_following.addElement(account);
		}
		else {
			throw new RuntimeException("Already Following");
		}
	}
	
	public void unfollow(TwitterAccount account) {
		if (isFollowing(account)) {
			_following.removeElement(account);
		}
	}
	
	public boolean isFollowing(TwitterAccount account) {
		return _following.contains(account);
	}
	
	public boolean isFollowedBy(TwitterAccount account) {
		return account.isFollowing(this);
	}
	
	public void tweet(String tweetText) {
		Tweet tweet = new Tweet(this, tweetText);
		_tweets.addElement(tweet);
		TweetCount++;
	}
	
	public void retweet(Tweet tweet) {
		Tweet newTweet = new Tweet(this, tweet);
		_tweets.addElement(newTweet);
		tweet.incRetweetCount(tweet);
		tweet.getOwner()._retweetCount++;
		TweetCount++;
	}
	
	public Tweet getTweet(int i) {
		if (_tweets.size()<i||i<1) {
			throw new IllegalArgumentException("Ikke godkjent inpunt på GetTweet()");
		}
		else {
			return _tweets.elementAt(i-1);
		}
	}
	
	public int getTweetCount() {
		return TweetCount;
	}
	
	public int getRetweetCount() {
		return _retweetCount;
	}

}
