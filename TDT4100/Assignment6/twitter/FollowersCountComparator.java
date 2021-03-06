package interfaces.twitter;

import java.util.Comparator;

import interfaces.twitter.TwitterAccount;

public class FollowersCountComparator implements Comparator<TwitterAccount>{

	@Override
	public int compare(TwitterAccount o1, TwitterAccount o2) {
		return o1.getFollowerCount()-o2.getFollowerCount();
	}
	
}
