<?xml version="1.0" encoding="UTF-8"?>
<xmi:XMI xmi:version="2.0" xmlns:xmi="http://www.omg.org/XMI" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:exercise="platform:/plugin/no.hal.learning.exercise.model/model/exercise.ecore" xmlns:jdt="platform:/plugin/no.hal.learning.exercise.jdt/model/jdt-exercise.ecore" xmlns:junit="platform:/plugin/no.hal.learning.exercise.junit/model/junit-exercise.ecore" xmlns:workbench="platform:/plugin/no.hal.learning.exercise.workbench/model/workbench-exercise.ecore">
  <exercise:Exercise>
    <parts xsi:type="exercise:ExercisePart" title="TwitterComparison">
      <tasks xsi:type="exercise:Task">
        <q xsi:type="exercise:StringQuestion" question="Write source code for the UserNameComparator class."/>
        <a xsi:type="jdt:JdtSourceEditAnswer" className="interfaces.twitter.UserNameComparator"/>
      </tasks>
      <tasks xsi:type="exercise:Task">
        <q xsi:type="exercise:StringQuestion" question="Write source code for the FollowersCountComparator class."/>
        <a xsi:type="jdt:JdtSourceEditAnswer" className="interfaces.twitter.FollowersCountComparator"/>
      </tasks>
      <tasks xsi:type="exercise:Task">
        <q xsi:type="exercise:StringQuestion" question="Write source code for the TweetsCountComparator class."/>
        <a xsi:type="jdt:JdtSourceEditAnswer" className="interfaces.twitter.TweetsCountComparator"/>
      </tasks>
      <tasks xsi:type="exercise:Task">
        <q xsi:type="exercise:StringQuestion" question="Test the UserNameComparator class, by running its main method."/>
        <a xsi:type="jdt:JdtLaunchAnswer" className="interfaces.twitter.UserNameComparator"/>
      </tasks>
      <tasks xsi:type="exercise:Task">
        <q xsi:type="exercise:StringQuestion" question="Test the FollowersCountComparator class, by running its main method."/>
        <a xsi:type="jdt:JdtLaunchAnswer" className="interfaces.twitter.FollowersCountComparator"/>
      </tasks>
      <tasks xsi:type="exercise:Task">
        <q xsi:type="exercise:StringQuestion" question="Test the UserNameComparator class, by running its main method."/>
        <a xsi:type="jdt:JdtLaunchAnswer" className="interfaces.twitter.UserNameComparator"/>
      </tasks>
      <tasks xsi:type="exercise:Task">
        <q xsi:type="exercise:StringQuestion" question="Run the TwitterAccountTest JUnit test."/>
        <a xsi:type="junit:JunitTestAnswer" testRunName="interfaces.twitter.TwitterAccountTest"/>
      </tasks>
      <tasks xsi:type="exercise:Task">
        <q xsi:type="exercise:StringQuestion" question="Run the FollowersCountComparatorTest JUnit test."/>
        <a xsi:type="junit:JunitTestAnswer" testRunName="interfaces.twitter.FollowersCountComparatorTest"/>
      </tasks>
      <tasks xsi:type="exercise:Task">
        <q xsi:type="exercise:StringQuestion" question="Run the UserNameComparatorTest JUnit test."/>
        <a xsi:type="junit:JunitTestAnswer" testRunName="interfaces.twitter.UserNameComparatorTest"/>
      </tasks>
      <tasks xsi:type="exercise:Task">
        <q xsi:type="exercise:StringQuestion" question="Run the TweetsCountComparatorTest JUnit test."/>
        <a xsi:type="junit:JunitTestAnswer" testRunName="interfaces.twitter.TweetsCountComparatorTest"/>
      </tasks>
    </parts>
    <parts xsi:type="exercise:ExercisePart" title="Tool usage">
      <tasks xsi:type="exercise:Task">
        <q xsi:type="exercise:StringQuestion" question="Use breakpoints to debug code."/>
        <a xsi:type="workbench:DebugEventAnswer" elementId="interfaces.twitter.*" action="suspend.breakpoint"/>
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
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1520162486195" resourcePath="/ovinger/src/interfaces/twitter/UserNameComparator.java" sizeMeasure="5" className="interfaces.twitter.UserNameComparator">
          <edit xsi:type="exercise:StringEdit" storedString="package interfaces.twitter;&#xA;&#xA;public class UserNameComparator {&#xA;&#xA;}&#xA;"/>
        </attempts>
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1520345089970" resourcePath="/ovinger/src/interfaces/twitter/UserNameComparator.java" sizeMeasure="14" className="interfaces.twitter.UserNameComparator">
          <edit xsi:type="exercise:ReplaceSubstringEdit" storedString="import java.util.Comparator;&#xA;&#xA;import objectstructures.TwitterAccount;&#xA;&#xA;public class UserNameComparator implements Comparator&lt;TwitterAccount>{&#xA;&#x9;&#xA;&#x9;&#xA;&#x9;public int compare(TwitterAccount o1, TwitterAccount o2) {&#xA;&#x9;&#x9;return o1.getUserName().compareTo(o2.getUserName());&#xA;&#x9;}" edit="/1/@proposals.0/@proposals.0/@attempts.0/@edit" start="29" end="-5"/>
        </attempts>
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1520413763199" resourcePath="/ovinger/src/interfaces/twitter/UserNameComparator.java" sizeMeasure="14" className="interfaces.twitter.UserNameComparator">
          <edit xsi:type="exercise:ReplaceSubstringEdit" storedString="@Override" edit="/1/@proposals.0/@proposals.0/@attempts.1/@edit" start="174" end="-123"/>
        </attempts>
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1520437756255" resourcePath="/ovinger/src/interfaces/twitter/UserNameComparator.java" sizeMeasure="14" className="interfaces.twitter.UserNameComparator">
          <edit xsi:type="exercise:ReplaceSubstringEdit" storedString="interfaces.twitter" edit="/1/@proposals.0/@proposals.0/@attempts.2/@edit" start="66" end="-224"/>
        </attempts>
      </proposals>
      <proposals xsi:type="jdt:JdtSourceEditProposal" question="/0/@parts.0/@tasks.1/@q" answer="/0/@parts.0/@tasks.1/@a">
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1520162503891" resourcePath="/ovinger/src/interfaces/twitter/FollowersCountComparator.java" sizeMeasure="5" className="interfaces.twitter.FollowersCountComparator">
          <edit xsi:type="exercise:StringEdit" storedString="package interfaces.twitter;&#xA;&#xA;public class FollowersCountComparator {&#xA;&#xA;}&#xA;"/>
        </attempts>
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1520438192503" resourcePath="/ovinger/src/interfaces/twitter/FollowersCountComparator.java" sizeMeasure="14" errorCount="2" className="interfaces.twitter.FollowersCountComparator">
          <edit xsi:type="exercise:ReplaceSubstringEdit" storedString="import java.util.Comparator;&#xA;&#xA;import interfaces.twitter.TwitterAccount;&#xA;&#xA;public class FollowersCountComparator implements Comparator&lt;TwitterAccount>{&#xA;&#xA;&#x9;@Override&#xA;&#x9;public int compare(TwitterAccount o1, TwitterAccount o2) {&#xA;&#x9;&#x9;return o1.getFollowerCount()-o2.getFollowerCount();&#xA;&#x9;}&#xA;&#x9;" edit="/1/@proposals.0/@proposals.1/@attempts.0/@edit" start="29" end="-4"/>
          <markers xsi:type="jdt:JdtMarkerInfo" lineNumber="11" charStart="285" charEnd="301" severity="2" problemCategory="50" problemType="67108964"/>
        </attempts>
      </proposals>
      <proposals xsi:type="jdt:JdtSourceEditProposal" question="/0/@parts.0/@tasks.2/@q" answer="/0/@parts.0/@tasks.2/@a">
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1520162517096" resourcePath="/ovinger/src/interfaces/twitter/TweetsCountComparator.java" sizeMeasure="5" className="interfaces.twitter.TweetsCountComparator">
          <edit xsi:type="exercise:StringEdit" storedString="package interfaces.twitter;&#xA;&#xA;public class TweetsCountComparator {&#xA;&#xA;}&#xA;"/>
        </attempts>
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1520345617660" resourcePath="/ovinger/src/interfaces/twitter/TweetsCountComparator.java" sizeMeasure="15" className="interfaces.twitter.TweetsCountComparator">
          <edit xsi:type="exercise:ReplaceSubstringEdit" storedString="import java.util.Comparator;&#xA;&#xA;import objectstructures.TwitterAccount;&#xA;&#xA;public class TweetsCountComparator implements Comparator&lt;TwitterAccount>{&#xA;&#xA;&#x9;@Override&#xA;&#x9;public int compare(TwitterAccount o1, TwitterAccount o2) {&#xA;&#x9;&#x9;return o1.getTweetCount()-o2.getTweetCount();&#xA;&#x9;}&#xA;&#x9;" edit="/1/@proposals.0/@proposals.2/@attempts.0/@edit" start="29" end="-5"/>
        </attempts>
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1520437794286" resourcePath="/ovinger/src/interfaces/twitter/TweetsCountComparator.java" sizeMeasure="15" className="interfaces.twitter.TweetsCountComparator">
          <edit xsi:type="exercise:ReplaceSubstringEdit" storedString="interfaces.twitter" edit="/1/@proposals.0/@proposals.2/@attempts.1/@edit" start="66" end="-221"/>
        </attempts>
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1520438159867" resourcePath="/ovinger/src/interfaces/twitter/TweetsCountComparator.java" sizeMeasure="13" className="interfaces.twitter.TweetsCountComparator">
          <edit xsi:type="exercise:ReplaceSubstringEdit" storedString="public class TweetsCountComparator implements Comparator&lt;TwitterAccount>{&#xA;&#xA;&#x9;@Override&#xA;&#x9;public int compare(TwitterAccount o1, TwitterAccount o2) {&#xA;&#x9;&#x9;return o2.getTweetCount()-o1" edit="/1/@proposals.0/@proposals.2/@attempts.2/@edit" start="59" end="-27"/>
        </attempts>
      </proposals>
      <proposals xsi:type="jdt:JdtLaunchProposal" question="/0/@parts.0/@tasks.3/@q" answer="/0/@parts.0/@tasks.3/@a"/>
      <proposals xsi:type="jdt:JdtLaunchProposal" question="/0/@parts.0/@tasks.4/@q" answer="/0/@parts.0/@tasks.4/@a"/>
      <proposals xsi:type="jdt:JdtLaunchProposal" question="/0/@parts.0/@tasks.5/@q" answer="/0/@parts.0/@tasks.5/@a"/>
      <proposals xsi:type="junit:JunitTestProposal" question="/0/@parts.0/@tasks.6/@q" answer="/0/@parts.0/@tasks.6/@a">
        <attempts xsi:type="junit:JunitTestEvent" timestamp="1520438231314" completion="1.0" testRunName="interfaces.twitter.TwitterAccountTest" successCount="6">
          <successTests>testGetTweetIllegal</successTests>
          <successTests>testUnfollow</successTests>
          <successTests>testRetweet</successTests>
          <successTests>testFollow</successTests>
          <successTests>testConstructor</successTests>
          <successTests>testNewTweet</successTests>
        </attempts>
        <attempts xsi:type="junit:JunitTestEvent" timestamp="1520438697733" completion="1.0" testRunName="interfaces.twitter.TwitterAccountTest" successCount="6">
          <successTests>testGetTweetIllegal</successTests>
          <successTests>testUnfollow</successTests>
          <successTests>testRetweet</successTests>
          <successTests>testFollow</successTests>
          <successTests>testConstructor</successTests>
          <successTests>testNewTweet</successTests>
        </attempts>
      </proposals>
      <proposals xsi:type="junit:JunitTestProposal" question="/0/@parts.0/@tasks.7/@q" answer="/0/@parts.0/@tasks.7/@a">
        <attempts xsi:type="junit:JunitTestEvent" timestamp="1520345642848" completion="0.0" testRunName="interfaces.twitter.FollowersCountComparatorTest" errorCount="1">
          <errorTests>initializationError</errorTests>
        </attempts>
      </proposals>
      <proposals xsi:type="junit:JunitTestProposal" question="/0/@parts.0/@tasks.8/@q" answer="/0/@parts.0/@tasks.8/@a">
        <attempts xsi:type="junit:JunitTestEvent" timestamp="1520345618511" completion="0.0" testRunName="interfaces.twitter.UserNameComparatorTest" errorCount="1">
          <errorTests>initializationError</errorTests>
        </attempts>
        <attempts xsi:type="junit:JunitTestEvent" timestamp="1520437362469" completion="0.0" testRunName="interfaces.twitter.UserNameComparatorTest" errorCount="1">
          <errorTests>initializationError</errorTests>
        </attempts>
        <attempts xsi:type="junit:JunitTestEvent" timestamp="1520437637457" completion="0.0" testRunName="interfaces.twitter.UserNameComparatorTest" errorCount="1">
          <errorTests>testCompare</errorTests>
        </attempts>
        <attempts xsi:type="junit:JunitTestEvent" timestamp="1520437756820" completion="1.0" testRunName="interfaces.twitter.UserNameComparatorTest" successCount="1">
          <successTests>testCompare</successTests>
        </attempts>
        <attempts xsi:type="junit:JunitTestEvent" timestamp="1520438227965" completion="1.0" testRunName="interfaces.twitter.UserNameComparatorTest" successCount="1">
          <successTests>testCompare</successTests>
        </attempts>
      </proposals>
      <proposals xsi:type="junit:JunitTestProposal" question="/0/@parts.0/@tasks.9/@q" answer="/0/@parts.0/@tasks.9/@a">
        <attempts xsi:type="junit:JunitTestEvent" timestamp="1520345648181" completion="0.0" testRunName="interfaces.twitter.TweetsCountComparatorTest" errorCount="1">
          <errorTests>initializationError</errorTests>
        </attempts>
        <attempts xsi:type="junit:JunitTestEvent" timestamp="1520437802174" completion="0.0" testRunName="interfaces.twitter.TweetsCountComparatorTest" failureCount="1">
          <failureTests>testCompare</failureTests>
        </attempts>
        <attempts xsi:type="junit:JunitTestEvent" timestamp="1520438223316" completion="1.0" testRunName="interfaces.twitter.TweetsCountComparatorTest" successCount="1">
          <successTests>testCompare</successTests>
        </attempts>
      </proposals>
    </proposals>
    <proposals exercisePart="/0/@parts.1">
      <proposals xsi:type="workbench:DebugEventProposal" question="/0/@parts.1/@tasks.0/@q" answer="/0/@parts.1/@tasks.0/@a"/>
      <proposals xsi:type="workbench:CommandExecutionProposal" question="/0/@parts.1/@tasks.1/@q" answer="/0/@parts.1/@tasks.1/@a">
        <attempts xsi:type="workbench:WorkbenchTaskEvent" timestamp="1517912685537" elementId="org.eclipse.debug.ui.commands.StepOver" action="executeSuccess"/>
        <attempts xsi:type="workbench:WorkbenchTaskEvent" timestamp="1519751199568" elementId="org.eclipse.debug.ui.commands.StepOver" action="executeSuccess"/>
        <attempts xsi:type="workbench:WorkbenchTaskEvent" timestamp="1519751203417" elementId="org.eclipse.debug.ui.commands.StepOver" action="executeSuccess"/>
      </proposals>
      <proposals xsi:type="workbench:CommandExecutionProposal" question="/0/@parts.1/@tasks.2/@q" answer="/0/@parts.1/@tasks.2/@a">
        <attempts xsi:type="workbench:WorkbenchTaskEvent" timestamp="1519751136803" elementId="org.eclipse.debug.ui.commands.StepInto" action="executeSuccess"/>
        <attempts xsi:type="workbench:WorkbenchTaskEvent" timestamp="1519751192725" elementId="org.eclipse.debug.ui.commands.StepInto" action="executeSuccess"/>
      </proposals>
      <proposals xsi:type="workbench:PartTaskProposal" question="/0/@parts.1/@tasks.3/@q" answer="/0/@parts.1/@tasks.3/@a">
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
        <attempts xsi:type="workbench:PartTaskEvent" timestamp="1520112152597" elementId="org.eclipse.debug.ui.VariableView" action="activated"/>
        <attempts xsi:type="workbench:PartTaskEvent" timestamp="1520112172582" elementId="org.eclipse.debug.ui.VariableView" action="activated"/>
        <attempts xsi:type="workbench:PartTaskEvent" timestamp="1520112287458" elementId="org.eclipse.debug.ui.VariableView" action="activated"/>
        <attempts xsi:type="workbench:PartTaskEvent" timestamp="1520112508807" elementId="org.eclipse.debug.ui.VariableView" action="activated"/>
        <attempts xsi:type="workbench:PartTaskEvent" timestamp="1520112615103" elementId="org.eclipse.debug.ui.VariableView" action="activated"/>
        <attempts xsi:type="workbench:PartTaskEvent" timestamp="1520112889395" elementId="org.eclipse.debug.ui.VariableView" action="activated"/>
        <attempts xsi:type="workbench:PartTaskEvent" timestamp="1520415379974" elementId="org.eclipse.debug.ui.VariableView" action="activated"/>
        <attempts xsi:type="workbench:PartTaskEvent" timestamp="1520415502356" elementId="org.eclipse.debug.ui.VariableView" action="activated"/>
        <attempts xsi:type="workbench:PartTaskEvent" timestamp="1520415528859" elementId="org.eclipse.debug.ui.VariableView" action="activated"/>
        <attempts xsi:type="workbench:PartTaskEvent" timestamp="1520415670417" elementId="org.eclipse.debug.ui.VariableView" action="activated"/>
        <attempts xsi:type="workbench:PartTaskEvent" timestamp="1520416810299" elementId="org.eclipse.debug.ui.VariableView" action="activated"/>
        <attempts xsi:type="workbench:PartTaskEvent" timestamp="1520416851017" elementId="org.eclipse.debug.ui.VariableView" action="activated"/>
        <attempts xsi:type="workbench:PartTaskEvent" timestamp="1520416911902" elementId="org.eclipse.debug.ui.VariableView" action="activated"/>
        <attempts xsi:type="workbench:PartTaskEvent" timestamp="1520417078916" elementId="org.eclipse.debug.ui.VariableView" action="activated"/>
        <attempts xsi:type="workbench:PartTaskEvent" timestamp="1520417125091" elementId="org.eclipse.debug.ui.VariableView" action="activated"/>
        <attempts xsi:type="workbench:PartTaskEvent" timestamp="1520417181656" elementId="org.eclipse.debug.ui.VariableView" action="activated"/>
        <attempts xsi:type="workbench:PartTaskEvent" timestamp="1520437149043" elementId="org.eclipse.debug.ui.VariableView" action="activated"/>
      </proposals>
    </proposals>
  </exercise:ExerciseProposals>
</xmi:XMI>
