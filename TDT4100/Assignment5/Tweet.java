package objectstructures;

public class Tweet {
	private TwitterAccount _user;
	private String _tweetText;
	private int _rtCount;
	private Tweet _originalTweet;
	
	
	public Tweet(TwitterAccount account, String tweet){
		_user=account;
		_tweetText=tweet;
		_originalTweet=this;
	}
	
	public Tweet(TwitterAccount account, Tweet tweet){
		if (tweet.getOwner().equals(_user)) {
			throw new RuntimeException("Cannot retweet own tweet");
		}
		else {
			if (tweet._originalTweet==tweet) {
			_originalTweet=tweet;
			} else {
				_originalTweet=tweet._originalTweet;
			}
			tweet._rtCount ++;
			_tweetText=tweet.getText();
			_user=account;
			}
	}
	
	public String getText() {
		return _tweetText;
	}
	
	public TwitterAccount getOwner() {
		return _user;
	}
	
	
	public Tweet getOriginalTweet() {
		return _originalTweet;
	}
	
	
	public int getRetweetCount() {
		return _rtCount;
	}
	
	public void incRetweetCount(Tweet tweet) {
		tweet._rtCount ++;
	}

}
