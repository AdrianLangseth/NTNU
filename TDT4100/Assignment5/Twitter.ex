<?xml version="1.0" encoding="UTF-8"?>
<xmi:XMI xmi:version="2.0" xmlns:xmi="http://www.omg.org/XMI" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:exercise="platform:/plugin/no.hal.learning.exercise.model/model/exercise.ecore" xmlns:jdt="platform:/plugin/no.hal.learning.exercise.jdt/model/jdt-exercise.ecore" xmlns:junit="platform:/plugin/no.hal.learning.exercise.junit/model/junit-exercise.ecore" xmlns:workbench="platform:/plugin/no.hal.learning.exercise.workbench/model/workbench-exercise.ecore">
  <exercise:Exercise>
    <parts xsi:type="exercise:ExercisePart" title="Twitter">
      <tasks xsi:type="exercise:Task">
        <q xsi:type="exercise:StringQuestion" question="Write source code for the Tweet class."/>
        <a xsi:type="jdt:JdtSourceEditAnswer" className="objectstructures.Tweet"/>
      </tasks>
      <tasks xsi:type="exercise:Task">
        <q xsi:type="exercise:StringQuestion" question="Write source code for the TwitterAccount class."/>
        <a xsi:type="jdt:JdtSourceEditAnswer" className="objectstructures.TwitterAccount"/>
      </tasks>
      <tasks xsi:type="exercise:Task">
        <q xsi:type="exercise:StringQuestion" question="Test the Tweet class, by running its main method."/>
        <a xsi:type="jdt:JdtLaunchAnswer" className="objectstructures.Tweet"/>
      </tasks>
      <tasks xsi:type="exercise:Task">
        <q xsi:type="exercise:StringQuestion" question="Test the TwitterAccount class, by running its main method."/>
        <a xsi:type="jdt:JdtLaunchAnswer" className="objectstructures.TwitterAccount"/>
      </tasks>
      <tasks xsi:type="exercise:Task">
        <q xsi:type="exercise:StringQuestion" question="Run the TweetTest JUnit test."/>
        <a xsi:type="junit:JunitTestAnswer" testRunName="objectstructures.TweetTest"/>
      </tasks>
      <tasks xsi:type="exercise:Task">
        <q xsi:type="exercise:StringQuestion" question="Run the TwitterAccountTest JUnit test."/>
        <a xsi:type="junit:JunitTestAnswer" testRunName="objectstructures.TwitterAccountTest"/>
      </tasks>
    </parts>
    <parts xsi:type="exercise:ExercisePart" title="Tool usage">
      <tasks xsi:type="exercise:Task">
        <q xsi:type="exercise:StringQuestion" question="Use breakpoints to debug the Tweet class."/>
        <a xsi:type="workbench:DebugEventAnswer" elementId="objectstructures.Tweet" action="suspend.breakpoint"/>
      </tasks>
      <tasks xsi:type="exercise:Task">
        <q xsi:type="exercise:StringQuestion" question="Use breakpoints to debug the TwitterAccount class."/>
        <a xsi:type="workbench:DebugEventAnswer" elementId="objectstructures.TwitterAccount" action="suspend.breakpoint"/>
      </tasks>
      <tasks xsi:type="exercise:Task">
        <q xsi:type="exercise:StringQuestion" question="Use the debug command Step Over"/>
        <a xsi:type="workbench:CommandExecutionAnswer" elementId="org.eclipse.debug.ui.commands.StepOver" action="executeSuccess"/>
      </tasks>
      <tasks xsi:type="exercise:Task">
        <q xsi:type="exercise:StringQuestion" question="Use the debug command Step Into"/>
        <a xsi:type="workbench:CommandExecutionAnswer" elementId="org.eclipse.debug.ui.commands.StepInto" action="executeSuccess"/>
      </tasks>
      <tasks xsi:type="exercise:Task">
        <q xsi:type="exercise:StringQuestion" question="Use the Variables view"/>
        <a xsi:type="workbench:PartTaskAnswer" elementId="org.eclipse.debug.ui.VariableView" action="activated"/>
      </tasks>
    </parts>
  </exercise:Exercise>
  <exercise:ExerciseProposals exercise="/0">
    <proposals exercisePart="/0/@parts.0">
      <proposals xsi:type="jdt:JdtSourceEditProposal" question="/0/@parts.0/@tasks.0/@q" answer="/0/@parts.0/@tasks.0/@a">
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1519733966653" resourcePath="/ovinger/src/objectstructures/Tweet.java" sizeMeasure="5" className="objectstructures.Tweet">
          <edit xsi:type="exercise:StringEdit" storedString="package objectstructures;&#xA;&#xA;public class Tweet {&#xA;&#xA;}&#xA;"/>
        </attempts>
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1519735723631" resourcePath="/ovinger/src/objectstructures/Tweet.java" sizeMeasure="60" className="objectstructures.Tweet">
          <edit xsi:type="exercise:ReplaceSubstringEdit" storedString="&#x9;private TwitterAccount _username;&#xA;&#x9;&#xA;&#x9;/**&#xA;&#x9; * Konstruktør for tweets&#xA;&#x9; * @param username brukernavn av skaper&#xA;&#x9; * @param tweet Input som skal postes som tweet.&#xA;&#x9; */&#xA;&#x9;public Tweet(TwitterAccount username, String tweet){&#xA;&#x9;&#x9;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;/**&#xA;&#x9; * Konstruktør for retweets&#xA;&#x9; * @param username brukernavn av skaper&#xA;&#x9; * @param tweet tweeten som skal retweetes&#xA;&#x9; */&#xA;&#x9;public Tweet(TwitterAccount username, Tweet tweet){&#xA;&#x9;&#x9;if (tweet.getOwner().equals(username)) {&#xA;&#x9;&#x9;&#x9;throw new RuntimeException(&quot;Cannot retweet own tweet&quot;);&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;/**&#xA;&#x9; * returnerer teksten til en tweet&#xA;&#x9; * @return the text of the tweet.&#xA;&#x9; */&#xA;&#x9;public String getText() {&#xA;&#x9;&#x9;return &#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;/**&#xA;&#x9; * Skal returnere kontoen tweeten stammer fra.&#xA;&#x9; * @return senders konto&#xA;&#x9; */&#xA;&#x9;public TwitterAccount getOwner() {&#xA;&#x9;&#x9;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;/**&#xA;&#x9; * Getter originaltweeten til en retweet, gir null om den ikke er en retweet.&#xA;&#x9; * @return originaltweeten&#xA;&#x9; */&#xA;&#x9;public Tweet getOriginalTweet() {&#xA;&#x9;&#x9;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;/**&#xA;&#x9; * returnerer antall ganger denne tweeten har blitt retweetet&#xA;&#x9; * @return antall retweets&#xA;&#x9; */&#xA;&#x9;public int getRetweetCount() {&#xA;&#x9;&#x9;&#xA;&#x9;}&#xA;&#x9;" edit="/1/@proposals.0/@proposals.0/@attempts.0/@edit" start="48" end="-5"/>
        </attempts>
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1519738224124" resourcePath="/ovinger/src/objectstructures/Tweet.java" sizeMeasure="69" className="objectstructures.Tweet">
          <edit xsi:type="exercise:ReplaceSubstringEdit" storedString="private String _tweetText;&#xA;&#x9;private int _rtCount;&#xA;&#x9;private Tweet _originalTweet;&#xA;&#x9;&#xA;&#x9;&#xA;&#x9;/**&#xA;&#x9; * Konstruktør for tweets&#xA;&#x9; * @param username brukernavn av skaper&#xA;&#x9; * @param tweet Input som skal postes som tweet.&#xA;&#x9; */&#xA;&#x9;public Tweet(TwitterAccount username, String tweet){&#xA;&#x9;&#x9;_username=username;&#xA;&#x9;&#x9;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;/**&#xA;&#x9; * Konstruktør for retweets&#xA;&#x9; * @param username brukernavn av skaper&#xA;&#x9; * @param tweet tweeten som skal retweetes&#xA;&#x9; */&#xA;&#x9;public Tweet(TwitterAccount username, Tweet tweet){&#xA;&#x9;&#x9;if (tweet.getOwner().equals(username)) {&#xA;&#x9;&#x9;&#x9;throw new RuntimeException(&quot;Cannot retweet own tweet&quot;);&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;else {&#xA;&#x9;&#x9;&#x9;_originalTweet=tweet;&#xA;&#x9;&#x9;&#x9;tweet._rtCount ++;&#xA;&#x9;&#x9;&#x9;&#xA;&#x9;&#x9;}&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;/**&#xA;&#x9; * returnerer teksten til en tweet&#xA;&#x9; * @return the text of the tweet.&#xA;&#x9; */&#xA;&#x9;public String getText() {&#xA;&#x9;&#x9;return _tweetText;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;/**&#xA;&#x9; * Skal returnere kontoen tweeten stammer fra.&#xA;&#x9; * @return senders konto&#xA;&#x9; */&#xA;&#x9;public TwitterAccount getOwner() {&#xA;&#x9;&#x9;return _username;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;/**&#xA;&#x9; * Getter originaltweeten til en retweet, gir null om den ikke er en retweet.&#xA;&#x9; * @return originaltweeten&#xA;&#x9; */&#xA;&#x9;public Tweet getOriginalTweet() {&#xA;&#x9;&#x9;return _originalTweet;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;/**&#xA;&#x9; * returnerer antall ganger denne tweeten har blitt retweetet&#xA;&#x9; * @return antall retweets&#xA;&#x9; */&#xA;&#x9;public int getRetweetCount() {&#xA;&#x9;&#x9;return _rtCount;" edit="/1/@proposals.0/@proposals.0/@attempts.1/@edit" start="84" end="-10"/>
        </attempts>
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1519739066493" resourcePath="/ovinger/src/objectstructures/Tweet.java" sizeMeasure="70" className="objectstructures.Tweet">
          <edit xsi:type="exercise:ReplaceSubstringEdit" storedString="_tweetText=tweet;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;/**&#xA;&#x9; * Konstruktør for retweets&#xA;&#x9; * @param username brukernavn av skaper&#xA;&#x9; * @param tweet tweeten som skal retweetes&#xA;&#x9; */&#xA;&#x9;public Tweet(TwitterAccount username, Tweet tweet){&#xA;&#x9;&#x9;if (tweet.getOwner().equals(username)) {&#xA;&#x9;&#x9;&#x9;throw new RuntimeException(&quot;Cannot retweet own tweet&quot;);&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;else {&#xA;&#x9;&#x9;&#x9;_originalTweet=tweet;&#xA;&#x9;&#x9;&#x9;tweet._rtCount ++;&#xA;&#x9;&#x9;&#x9;_tweetText=tweet.getText();&#xA;&#x9;&#x9;&#x9;_username=username;" edit="/1/@proposals.0/@proposals.0/@attempts.2/@edit" start="375" end="-632"/>
        </attempts>
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1519739850058" resourcePath="/ovinger/src/objectstructures/Tweet.java" sizeMeasure="70" className="objectstructures.Tweet">
          <edit xsi:type="exercise:ReplaceSubstringEdit" storedString=";&#xA;&#x9;private String _tweetText;&#xA;&#x9;private int _rtCount;&#xA;&#x9;private Tweet _originalTweet;&#xA;&#x9;&#xA;&#x9;&#xA;&#x9;/**&#xA;&#x9; * Konstruktør for tweets&#xA;&#x9; * @param username brukernavn av skaper&#xA;&#x9; * @param tweet Input som skal postes som tweet.&#xA;&#x9; */&#xA;&#x9;public Tweet(TwitterAccount account, String tweet){&#xA;&#x9;&#x9;_user=account;&#xA;&#x9;&#x9;_tweetText=tweet;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;/**&#xA;&#x9; * Konstruktør for retweets&#xA;&#x9; * @param username brukernavn av skaper&#xA;&#x9; * @param tweet tweeten som skal retweetes&#xA;&#x9; */&#xA;&#x9;public Tweet(TwitterAccount account, Tweet tweet){&#xA;&#x9;&#x9;if (tweet.getOwner().equals(_user)) {&#xA;&#x9;&#x9;&#x9;throw new RuntimeException(&quot;Cannot retweet own tweet&quot;);&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;else {&#xA;&#x9;&#x9;&#x9;_originalTweet=tweet;&#xA;&#x9;&#x9;&#x9;tweet._rtCount ++;&#xA;&#x9;&#x9;&#x9;_tweetText=tweet.getText();&#xA;&#x9;&#x9;&#x9;_user=account;&#xA;&#x9;&#x9;}&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;/**&#xA;&#x9; * returnerer teksten til en tweet&#xA;&#x9; * @return the text of the tweet.&#xA;&#x9; */&#xA;&#x9;public String getText() {&#xA;&#x9;&#x9;return _tweetText;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;/**&#xA;&#x9; * Skal returnere kontoen tweeten stammer fra.&#xA;&#x9; * @return senders konto&#xA;&#x9; */&#xA;&#x9;public TwitterAccount getOwner() {&#xA;&#x9;&#x9;return _user" edit="/1/@proposals.0/@proposals.0/@attempts.3/@edit" start="77" end="-350"/>
        </attempts>
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1519739913230" resourcePath="/ovinger/src/objectstructures/Tweet.java" sizeMeasure="46" className="objectstructures.Tweet">
          <edit xsi:type="exercise:ReplaceSubstringEdit" storedString="public Tweet(TwitterAccount account, String tweet){&#xA;&#x9;&#x9;_user=account;&#xA;&#x9;&#x9;_tweetText=tweet;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public Tweet(TwitterAccount account, Tweet tweet){&#xA;&#x9;&#x9;if (tweet.getOwner().equals(_user)) {&#xA;&#x9;&#x9;&#x9;throw new RuntimeException(&quot;Cannot retweet own tweet&quot;);&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;else {&#xA;&#x9;&#x9;&#x9;_originalTweet=tweet;&#xA;&#x9;&#x9;&#x9;tweet._rtCount ++;&#xA;&#x9;&#x9;&#x9;_tweetText=tweet.getText();&#xA;&#x9;&#x9;&#x9;_user=account;&#xA;&#x9;&#x9;}&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public String getText() {&#xA;&#x9;&#x9;return _tweetText;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public TwitterAccount getOwner() {&#xA;&#x9;&#x9;return _user;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;&#xA;&#x9;public Tweet getOriginalTweet() {&#xA;&#x9;&#x9;return _originalTweet;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;" edit="/1/@proposals.0/@proposals.0/@attempts.4/@edit" start="166" end="-61"/>
        </attempts>
      </proposals>
      <proposals xsi:type="jdt:JdtSourceEditProposal" question="/0/@parts.0/@tasks.1/@q" answer="/0/@parts.0/@tasks.1/@a">
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1519734415265" resourcePath="/ovinger/src/objectstructures/TwitterAccount.java" sizeMeasure="5" className="objectstructures.TwitterAccount">
          <edit xsi:type="exercise:StringEdit" storedString="package objectstructures;&#xA;&#xA;public class TwitterAccount {&#xA;&#xA;}&#xA;"/>
        </attempts>
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1519735725659" resourcePath="/ovinger/src/objectstructures/TwitterAccount.java" sizeMeasure="27" className="objectstructures.TwitterAccount">
          <edit xsi:type="exercise:ReplaceSubstringEdit" storedString="&#x9;private String _username;&#xA;&#x9;&#xA;&#x9;&#xA;&#x9;/**&#xA;&#x9; * konstruktør for TwitterAccount&#xA;&#x9; * @param Username Brukernavn av Twitteraccount&#xA;&#x9; */&#xA;&#x9;public TwitterAccount(String username){&#xA;&#x9;&#x9;_username=username;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;/**&#xA;&#x9; * Get for brukernavn&#xA;&#x9; * @return Username&#xA;&#x9; */&#xA;&#x9;public String getUserName() {&#xA;&#x9;&#x9;return _username;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;void follow(TwitterAccount account) {&#xA;&#x9;&#x9;this._username&#xA;&#x9;}" edit="/1/@proposals.0/@proposals.1/@attempts.0/@edit" start="57" end="-5"/>
        </attempts>
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1519742383137" resourcePath="/ovinger/src/objectstructures/TwitterAccount.java" sizeMeasure="66" errorCount="2" className="objectstructures.TwitterAccount">
          <edit xsi:type="exercise:ReplaceSubstringEdit" storedString="import java.util.Vector;&#xA;&#xA;public class TwitterAccount {&#xA;&#x9;private String _username;&#xA;&#x9;private int TweetCount;&#xA;&#x9;private int _retweetCount;&#xA;&#x9;&#xA;&#x9;private Vector&lt;Tweet> _tweets;&#xA;&#x9;private Vector&lt;TwitterAccount> _followers;&#xA;&#x9;&#xA;&#x9;/**&#xA;&#x9; * konstruktør for TwitterAccount&#xA;&#x9; * @param Username Brukernavn av Twitteraccount&#xA;&#x9; */&#xA;&#x9;public TwitterAccount(String username){&#xA;&#x9;&#x9;_username=username;&#xA;&#x9;&#x9;_tweets = new Vector&lt;Tweet>();&#xA;&#x9;&#x9;_followers = new Vector&lt;TwitterAccount>();&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public String getUserName() {&#xA;&#x9;&#x9;return _username;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public void follow(TwitterAccount account) {&#xA;&#x9;&#x9;account._followers.addElement(this);&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public void unfollow(TwitterAccount account) {&#xA;&#x9;&#x9;account._followers.removeElement(this);&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public boolean isFollowing(TwitterAccount account) {&#xA;&#x9;&#x9;return account._followers.contains(this);&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public boolean isFollowedBy(TwitterAccount account) {&#xA;&#x9;&#x9;return _followers.contains(account);&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public void tweet(String tweetText) {&#xA;&#x9;&#x9;Tweet tweet = new Tweet(this, tweetText);&#xA;&#x9;&#x9;_tweets.addElement(tweet);&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public void retweet(Tweet tweet) {&#xA;&#x9;&#x9;Tweet newTweet = new Tweet(this, tweet);&#xA;&#x9;&#x9;_tweets.addElement(newTweet);&#xA;&#x9;&#x9;tweet.incRetweetCount(tweet);&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public Tweet getTweet(int i) {&#xA;&#x9;&#x9;return _tweets.elementAt(i);&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public int getTweetCount() {&#xA;&#x9;&#x9;return TweetCount;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public int getRetweetCount() {&#xA;&#x9;&#x9;return _retweetCount;" edit="/1/@proposals.0/@proposals.1/@attempts.1/@edit" start="27" end="-8"/>
          <markers xsi:type="jdt:JdtMarkerInfo" lineNumber="28" charStart="623" charEnd="623" severity="2" problemCategory="20" problemType="1610612976"/>
        </attempts>
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1519742878749" resourcePath="/ovinger/src/objectstructures/TwitterAccount.java" sizeMeasure="76" errorCount="2" className="objectstructures.TwitterAccount">
          <edit xsi:type="exercise:ReplaceSubstringEdit" storedString="if (isFollowing(account)) {&#xA;&#x9;&#x9;account._followers.addElement(this);&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;else {&#xA;&#x9;&#x9;&#x9;throw new RuntimeException(&quot;Already Following&quot;);&#xA;&#x9;&#x9;}&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public void unfollow(TwitterAccount account) {&#xA;&#x9;&#x9;account._followers.removeElement(this);&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public boolean isFollowing(TwitterAccount account) {&#xA;&#x9;&#x9;return account._followers.contains(this);&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public boolean isFollowedBy(TwitterAccount account) {&#xA;&#x9;&#x9;return _followers.contains(account);&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public void tweet(String tweetText) {&#xA;&#x9;&#x9;Tweet tweet = new Tweet(this, tweetText);&#xA;&#x9;&#x9;_tweets.addElement(tweet);&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public void retweet(Tweet tweet) {&#xA;&#x9;&#x9;Tweet newTweet = new Tweet(this, tweet);&#xA;&#x9;&#x9;_tweets.addElement(newTweet);&#xA;&#x9;&#x9;tweet.incRetweetCount(tweet);&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public Tweet getTweet(int i) {&#xA;&#x9;&#x9;if (_tweets.size()&lt;i||i&lt;1) {&#xA;&#x9;&#x9;&#x9;throw new IllegalArgumentException(&quot;Ikke godkjent inpunt på GetTweet()&quot;);&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;else {&#xA;&#x9;&#x9;&#x9;return _tweets.elementAt(i-1);&#xA;&#x9;&#x9;}" edit="/1/@proposals.0/@proposals.1/@attempts.2/@edit" start="587" end="-125"/>
          <markers xsi:type="jdt:JdtMarkerInfo" lineNumber="33" charStart="722" charEnd="722" severity="2" problemCategory="20" problemType="1610612976"/>
        </attempts>
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1519743018222" resourcePath="/ovinger/src/objectstructures/TwitterAccount.java" sizeMeasure="81" className="objectstructures.TwitterAccount">
          <edit xsi:type="exercise:ReplaceSubstringEdit" storedString="!isFollowing(account)) {&#xA;&#x9;&#x9;account._followers.addElement(this);&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;else {&#xA;&#x9;&#x9;&#x9;throw new RuntimeException(&quot;Already Following&quot;);&#xA;&#x9;&#x9;}&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public void unfollow(TwitterAccount account) {&#xA;&#x9;&#x9;if (isFollowing(account)) {&#xA;&#x9;&#x9;&#x9;account._followers.removeElement(this);&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;else {&#xA;&#x9;&#x9;&#x9;throw new RuntimeException(&quot;Not Following&quot;);&#xA;&#x9;&#x9;}" edit="/1/@proposals.0/@proposals.1/@attempts.3/@edit" start="591" end="-788"/>
        </attempts>
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1519743459652" resourcePath="/ovinger/src/objectstructures/TwitterAccount.java" sizeMeasure="81" className="objectstructures.TwitterAccount">
          <edit xsi:type="exercise:ReplaceSubstringEdit" storedString="_followers.contains(account);&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public boolean isFollowedBy(TwitterAccount account) {&#xA;&#x9;&#x9;return account.isFollowing(this" edit="/1/@proposals.0/@proposals.1/@attempts.4/@edit" start="983" end="-588"/>
        </attempts>
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1519743577102" resourcePath="/ovinger/src/objectstructures/TwitterAccount.java" sizeMeasure="78" className="objectstructures.TwitterAccount">
          <edit xsi:type="exercise:ReplaceSubstringEdit" storedString="}" edit="/1/@proposals.0/@proposals.1/@attempts.5/@edit" start="855" end="-777"/>
        </attempts>
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1519743818783" resourcePath="/ovinger/src/objectstructures/TwitterAccount.java" sizeMeasure="82" className="objectstructures.TwitterAccount">
          <edit xsi:type="exercise:ReplaceSubstringEdit" storedString="_followers.addElement(account);&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;else {&#xA;&#x9;&#x9;&#x9;throw new RuntimeException(&quot;Already Following&quot;);&#xA;&#x9;&#x9;}&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public void unfollow(TwitterAccount account) {&#xA;&#x9;&#x9;if (isFollowing(account)) {&#xA;&#x9;&#x9;&#x9;_followers.removeElement(account);&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;else {&#xA;&#x9;&#x9;&#x9;throw new RuntimeException(&quot;Not Following&quot;);&#xA;&#x9;&#x9;}&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public boolean isFollowing(TwitterAccount account) {&#xA;&#x9;&#x9;return _followers.contains(account);&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public boolean isFollowedBy(TwitterAccount account) {&#xA;&#x9;&#x9;return account.isFollowing(this);&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public void tweet(String tweetText) {&#xA;&#x9;&#x9;Tweet tweet = new Tweet(this, tweetText);&#xA;&#x9;&#x9;_tweets.addElement(tweet);&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public void retweet(Tweet tweet) {&#xA;&#x9;&#x9;Tweet newTweet = new Tweet(this, tweet);&#xA;&#x9;&#x9;_tweets.addElement(newTweet);&#xA;&#x9;&#x9;tweet.incRetweetCount(tweet);&#xA;&#x9;&#x9;tweet.getOwner()._retweetCount++" edit="/1/@proposals.0/@proposals.1/@attempts.6/@edit" start="618" end="-322"/>
        </attempts>
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1519743904441" resourcePath="/ovinger/src/objectstructures/TwitterAccount.java" sizeMeasure="82" className="objectstructures.TwitterAccount">
          <edit xsi:type="exercise:ReplaceSubstringEdit" storedString="ing;&#xA;&#x9;&#xA;&#x9;/**&#xA;&#x9; * konstruktør for TwitterAccount&#xA;&#x9; * @param Username Brukernavn av Twitteraccount&#xA;&#x9; */&#xA;&#x9;public TwitterAccount(String username){&#xA;&#x9;&#x9;_username=username;&#xA;&#x9;&#x9;_tweets = new Vector&lt;Tweet>();&#xA;&#x9;&#x9;_following = new Vector&lt;TwitterAccount>();&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public String getUserName() {&#xA;&#x9;&#x9;return _username;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public void follow(TwitterAccount account) {&#xA;&#x9;&#x9;if (!isFollowing(account)) {&#xA;&#x9;&#x9;_following.addElement(account);&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;else {&#xA;&#x9;&#x9;&#x9;throw new RuntimeException(&quot;Already Following&quot;);&#xA;&#x9;&#x9;}&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public void unfollow(TwitterAccount account) {&#xA;&#x9;&#x9;if (isFollowing(account)) {&#xA;&#x9;&#x9;&#x9;_following.removeElement(account);&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;else {&#xA;&#x9;&#x9;&#x9;throw new RuntimeException(&quot;Not Following&quot;);&#xA;&#x9;&#x9;}&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public boolean isFollowing(TwitterAccount account) {&#xA;&#x9;&#x9;return _following" edit="/1/@proposals.0/@proposals.1/@attempts.7/@edit" start="236" end="-737"/>
        </attempts>
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1519744124543" resourcePath="/ovinger/src/objectstructures/TwitterAccount.java" sizeMeasure="82" className="objectstructures.TwitterAccount">
          <edit xsi:type="exercise:ReplaceSubstringEdit" edit="/1/@proposals.0/@proposals.1/@attempts.8/@edit" start="1719"/>
        </attempts>
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1519751482350" resourcePath="/ovinger/src/objectstructures/TwitterAccount.java" sizeMeasure="82" className="objectstructures.TwitterAccount">
          <edit xsi:type="exercise:ReplaceSubstringEdit" storedString="&#x9;" edit="/1/@proposals.0/@proposals.1/@attempts.9/@edit" start="618" end="-1102"/>
        </attempts>
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1519751638502" resourcePath="/ovinger/src/objectstructures/TwitterAccount.java" sizeMeasure="79" className="objectstructures.TwitterAccount">
          <edit xsi:type="exercise:ReplaceSubstringEdit" storedString="}" edit="/1/@proposals.0/@proposals.1/@attempts.10/@edit" start="846" end="-813"/>
        </attempts>
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1519751749362" resourcePath="/ovinger/src/objectstructures/TwitterAccount.java" sizeMeasure="81" className="objectstructures.TwitterAccount">
          <edit xsi:type="exercise:ReplaceSubstringEdit" storedString="&#x9;TweetCount++;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public void retweet(Tweet tweet) {&#xA;&#x9;&#x9;Tweet newTweet = new Tweet(this, tweet);&#xA;&#x9;&#x9;_tweets.addElement(newTweet);&#xA;&#x9;&#x9;tweet.incRetweetCount(tweet);&#xA;&#x9;&#x9;tweet.getOwner()._retweetCount++;&#xA;&#x9;&#x9;T" edit="/1/@proposals.0/@proposals.1/@attempts.11/@edit" start="1157" end="-333"/>
        </attempts>
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1519752464148" resourcePath="/ovinger/src/objectstructures/TwitterAccount.java" sizeMeasure="82" className="objectstructures.TwitterAccount">
          <edit xsi:type="exercise:ReplaceSubstringEdit" storedString="&#x9;_ret" edit="/1/@proposals.0/@proposals.1/@attempts.12/@edit" start="1173" end="-533"/>
        </attempts>
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1519767148598" resourcePath="/ovinger/src/objectstructures/TwitterAccount.java" sizeMeasure="81" className="objectstructures.TwitterAccount">
          <edit xsi:type="exercise:ReplaceSubstringEdit" storedString="}" edit="/1/@proposals.0/@proposals.1/@attempts.13/@edit" start="1173" end="-518"/>
        </attempts>
      </proposals>
      <proposals xsi:type="jdt:JdtLaunchProposal" question="/0/@parts.0/@tasks.2/@q" answer="/0/@parts.0/@tasks.2/@a"/>
      <proposals xsi:type="jdt:JdtLaunchProposal" question="/0/@parts.0/@tasks.3/@q" answer="/0/@parts.0/@tasks.3/@a"/>
      <proposals xsi:type="junit:JunitTestProposal" question="/0/@parts.0/@tasks.4/@q" answer="/0/@parts.0/@tasks.4/@a">
        <attempts xsi:type="junit:JunitTestEvent" timestamp="1519739095726" completion="1.0" testRunName="objectstructures.TweetTest" successCount="4">
          <successTests>testGetRetweetCount</successTests>
          <successTests>testGetOriginalTweet</successTests>
          <successTests>testConstructorNewTweet</successTests>
          <successTests>testConstructorRetweet</successTests>
        </attempts>
      </proposals>
      <proposals xsi:type="junit:JunitTestProposal" question="/0/@parts.0/@tasks.5/@q" answer="/0/@parts.0/@tasks.5/@a">
        <attempts xsi:type="junit:JunitTestEvent" timestamp="1519742889754" completion="0.3333333333333333" testRunName="objectstructures.TwitterAccountTest" successCount="2" failureCount="2" errorCount="2">
          <successTests>testGetTweetIllegal</successTests>
          <successTests>testConstructor</successTests>
          <failureTests>testRetweet</failureTests>
          <failureTests>testNewTweet</failureTests>
          <errorTests>testUnfollow</errorTests>
          <errorTests>testFollow</errorTests>
        </attempts>
        <attempts xsi:type="junit:JunitTestEvent" timestamp="1519743025383" completion="0.5" testRunName="objectstructures.TwitterAccountTest" successCount="3" failureCount="2" errorCount="1">
          <successTests>testGetTweetIllegal</successTests>
          <successTests>testFollow</successTests>
          <successTests>testConstructor</successTests>
          <failureTests>testRetweet</failureTests>
          <failureTests>testNewTweet</failureTests>
          <errorTests>testUnfollow</errorTests>
        </attempts>
        <attempts xsi:type="junit:JunitTestEvent" timestamp="1519743460116" completion="0.3333333333333333" testRunName="objectstructures.TwitterAccountTest" successCount="2" failureCount="3" errorCount="1">
          <successTests>testGetTweetIllegal</successTests>
          <successTests>testConstructor</successTests>
          <failureTests>testRetweet</failureTests>
          <failureTests>testFollow</failureTests>
          <failureTests>testNewTweet</failureTests>
          <errorTests>testUnfollow</errorTests>
        </attempts>
        <attempts xsi:type="junit:JunitTestEvent" timestamp="1519743577577" completion="0.3333333333333333" testRunName="objectstructures.TwitterAccountTest" successCount="2" failureCount="4">
          <successTests>testGetTweetIllegal</successTests>
          <successTests>testConstructor</successTests>
          <failureTests>testUnfollow</failureTests>
          <failureTests>testRetweet</failureTests>
          <failureTests>testFollow</failureTests>
          <failureTests>testNewTweet</failureTests>
        </attempts>
        <attempts xsi:type="junit:JunitTestEvent" timestamp="1519743825294" completion="0.5" testRunName="objectstructures.TwitterAccountTest" successCount="3" failureCount="2" errorCount="1">
          <successTests>testGetTweetIllegal</successTests>
          <successTests>testFollow</successTests>
          <successTests>testConstructor</successTests>
          <failureTests>testRetweet</failureTests>
          <failureTests>testNewTweet</failureTests>
          <errorTests>testUnfollow</errorTests>
        </attempts>
        <attempts xsi:type="junit:JunitTestEvent" timestamp="1519744010349" completion="0.5" testRunName="objectstructures.TwitterAccountTest" successCount="3" failureCount="2" errorCount="1">
          <successTests>testGetTweetIllegal</successTests>
          <successTests>testFollow</successTests>
          <successTests>testConstructor</successTests>
          <failureTests>testRetweet</failureTests>
          <failureTests>testNewTweet</failureTests>
          <errorTests>testUnfollow</errorTests>
        </attempts>
        <attempts xsi:type="junit:JunitTestEvent" timestamp="1519751018569" completion="0.5" testRunName="objectstructures.TwitterAccountTest" successCount="3" failureCount="2" errorCount="1">
          <successTests>testGetTweetIllegal</successTests>
          <successTests>testFollow</successTests>
          <successTests>testConstructor</successTests>
          <failureTests>testRetweet</failureTests>
          <failureTests>testNewTweet</failureTests>
          <errorTests>testUnfollow</errorTests>
        </attempts>
        <attempts xsi:type="junit:JunitTestEvent" timestamp="1519751482946" completion="0.5" testRunName="objectstructures.TwitterAccountTest" successCount="3" failureCount="2" errorCount="1">
          <successTests>testGetTweetIllegal</successTests>
          <successTests>testFollow</successTests>
          <successTests>testConstructor</successTests>
          <failureTests>testRetweet</failureTests>
          <failureTests>testNewTweet</failureTests>
          <errorTests>testUnfollow</errorTests>
        </attempts>
        <attempts xsi:type="junit:JunitTestEvent" timestamp="1519751641938" completion="0.6666666666666666" testRunName="objectstructures.TwitterAccountTest" successCount="4" failureCount="2">
          <successTests>testGetTweetIllegal</successTests>
          <successTests>testUnfollow</successTests>
          <successTests>testFollow</successTests>
          <successTests>testConstructor</successTests>
          <failureTests>testRetweet</failureTests>
          <failureTests>testNewTweet</failureTests>
        </attempts>
        <attempts xsi:type="junit:JunitTestEvent" timestamp="1519751794033" completion="0.6666666666666666" testRunName="objectstructures.TwitterAccountTest" successCount="4" failureCount="2">
          <successTests>testGetTweetIllegal</successTests>
          <successTests>testUnfollow</successTests>
          <successTests>testFollow</successTests>
          <successTests>testConstructor</successTests>
          <failureTests>testRetweet</failureTests>
          <failureTests>testNewTweet</failureTests>
        </attempts>
        <attempts xsi:type="junit:JunitTestEvent" timestamp="1519752464711" completion="0.6666666666666666" testRunName="objectstructures.TwitterAccountTest" successCount="4" failureCount="2">
          <successTests>testGetTweetIllegal</successTests>
          <successTests>testUnfollow</successTests>
          <successTests>testFollow</successTests>
          <successTests>testConstructor</successTests>
          <failureTests>testRetweet</failureTests>
          <failureTests>testNewTweet</failureTests>
        </attempts>
      </proposals>
    </proposals>
    <proposals exercisePart="/0/@parts.1">
      <proposals xsi:type="workbench:DebugEventProposal" question="/0/@parts.1/@tasks.0/@q" answer="/0/@parts.1/@tasks.0/@a"/>
      <proposals xsi:type="workbench:DebugEventProposal" question="/0/@parts.1/@tasks.1/@q" answer="/0/@parts.1/@tasks.1/@a">
        <attempts xsi:type="workbench:WorkbenchTaskEvent" timestamp="1519744131949" elementId="objectstructures.TwitterAccount" action="suspend.breakpoint"/>
        <attempts xsi:type="workbench:WorkbenchTaskEvent" timestamp="1519751097324" elementId="objectstructures.TwitterAccount" action="suspend.breakpoint"/>
        <attempts xsi:type="workbench:WorkbenchTaskEvent" timestamp="1519751097325" elementId="objectstructures.TwitterAccount" action="suspend.breakpoint"/>
        <attempts xsi:type="workbench:WorkbenchTaskEvent" timestamp="1519752125558" elementId="objectstructures.TwitterAccount" action="suspend.breakpoint"/>
      </proposals>
      <proposals xsi:type="workbench:CommandExecutionProposal" question="/0/@parts.1/@tasks.2/@q" answer="/0/@parts.1/@tasks.2/@a">
        <attempts xsi:type="workbench:WorkbenchTaskEvent" timestamp="1517912685537" elementId="org.eclipse.debug.ui.commands.StepOver" action="executeSuccess"/>
        <attempts xsi:type="workbench:WorkbenchTaskEvent" timestamp="1519751199568" elementId="org.eclipse.debug.ui.commands.StepOver" action="executeSuccess"/>
        <attempts xsi:type="workbench:WorkbenchTaskEvent" timestamp="1519751203417" elementId="org.eclipse.debug.ui.commands.StepOver" action="executeSuccess"/>
      </proposals>
      <proposals xsi:type="workbench:CommandExecutionProposal" question="/0/@parts.1/@tasks.3/@q" answer="/0/@parts.1/@tasks.3/@a">
        <attempts xsi:type="workbench:WorkbenchTaskEvent" timestamp="1519751136803" elementId="org.eclipse.debug.ui.commands.StepInto" action="executeSuccess"/>
        <attempts xsi:type="workbench:WorkbenchTaskEvent" timestamp="1519751192725" elementId="org.eclipse.debug.ui.commands.StepInto" action="executeSuccess"/>
      </proposals>
      <proposals xsi:type="workbench:PartTaskProposal" question="/0/@parts.1/@tasks.4/@q" answer="/0/@parts.1/@tasks.4/@a">
        <attempts xsi:type="workbench:PartTaskEvent" timestamp="1517690287824" elementId="org.eclipse.debug.ui.VariableView" action="activated"/>
        <attempts xsi:type="workbench:PartTaskEvent" timestamp="1517751040745" elementId="org.eclipse.debug.ui.VariableView" action="activated"/>
        <attempts xsi:type="workbench:PartTaskEvent" timestamp="1517755546592" elementId="org.eclipse.debug.ui.VariableView" action="activated"/>
        <attempts xsi:type="workbench:PartTaskEvent" timestamp="1517755646416" elementId="org.eclipse.debug.ui.VariableView" action="activated"/>
        <attempts xsi:type="workbench:PartTaskEvent" timestamp="1517755855878" elementId="org.eclipse.debug.ui.VariableView" action="activated"/>
        <attempts xsi:type="workbench:PartTaskEvent" timestamp="1517756726252" elementId="org.eclipse.debug.ui.VariableView" action="activated"/>
        <attempts xsi:type="workbench:PartTaskEvent" timestamp="1517756978596" elementId="org.eclipse.debug.ui.VariableView" action="activated"/>
        <attempts xsi:type="workbench:PartTaskEvent" timestamp="1517757188611" elementId="org.eclipse.debug.ui.VariableView" action="activated"/>
        <attempts xsi:type="workbench:PartTaskEvent" timestamp="1517757318049" elementId="org.eclipse.debug.ui.VariableView" action="activated"/>
        <attempts xsi:type="workbench:PartTaskEvent" timestamp="1517846004797" elementId="org.eclipse.debug.ui.VariableView" action="activated"/>
        <attempts xsi:type="workbench:PartTaskEvent" timestamp="1517846409784" elementId="org.eclipse.debug.ui.VariableView" action="activated"/>
        <attempts xsi:type="workbench:PartTaskEvent" timestamp="1517912640317" elementId="org.eclipse.debug.ui.VariableView" action="activated"/>
        <attempts xsi:type="workbench:PartTaskEvent" timestamp="1517912711628" elementId="org.eclipse.debug.ui.VariableView" action="activated"/>
        <attempts xsi:type="workbench:PartTaskEvent" timestamp="1517913183145" elementId="org.eclipse.debug.ui.VariableView" action="activated"/>
        <attempts xsi:type="workbench:PartTaskEvent" timestamp="1517995520140" elementId="org.eclipse.debug.ui.VariableView" action="activated"/>
        <attempts xsi:type="workbench:PartTaskEvent" timestamp="1519735710801" elementId="org.eclipse.debug.ui.VariableView" action="activated"/>
        <attempts xsi:type="workbench:PartTaskEvent" timestamp="1519744172621" elementId="org.eclipse.debug.ui.VariableView" action="activated"/>
        <attempts xsi:type="workbench:PartTaskEvent" timestamp="1519751109796" elementId="org.eclipse.debug.ui.VariableView" action="activated"/>
        <attempts xsi:type="workbench:PartTaskEvent" timestamp="1519751177968" elementId="org.eclipse.debug.ui.VariableView" action="activated"/>
        <attempts xsi:type="workbench:PartTaskEvent" timestamp="1519752146351" elementId="org.eclipse.debug.ui.VariableView" action="activated"/>
      </proposals>
    </proposals>
  </exercise:ExerciseProposals>
</xmi:XMI>
