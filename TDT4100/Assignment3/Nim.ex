<?xml version="1.0" encoding="UTF-8"?>
<xmi:XMI xmi:version="2.0" xmlns:xmi="http://www.omg.org/XMI" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:exercise="platform:/plugin/no.hal.learning.exercise.model/model/exercise.ecore" xmlns:jdt="platform:/plugin/no.hal.learning.exercise.jdt/model/jdt-exercise.ecore" xmlns:junit="platform:/plugin/no.hal.learning.exercise.junit/model/junit-exercise.ecore" xmlns:workbench="platform:/plugin/no.hal.learning.exercise.workbench/model/workbench-exercise.ecore">
  <exercise:Exercise>
    <parts xsi:type="exercise:ExercisePart" title="Nim">
      <tasks xsi:type="exercise:Task">
        <q xsi:type="exercise:StringQuestion" question="Write source code for the Nim class."/>
        <a xsi:type="jdt:JdtSourceEditAnswer" className="encapsulation.Nim"/>
      </tasks>
      <tasks xsi:type="exercise:Task">
        <q xsi:type="exercise:StringQuestion" question="Run the Nim class, to test it."/>
        <a xsi:type="jdt:JdtLaunchAnswer" className="encapsulation.Nim"/>
      </tasks>
      <tasks xsi:type="exercise:Task">
        <q xsi:type="exercise:StringQuestion" question="Test the Nim class, by running the NimTest JUnit test."/>
        <a xsi:type="junit:JunitTestAnswer" testRunName="encapsulation.NimTest"/>
      </tasks>
    </parts>
    <parts xsi:type="exercise:ExercisePart" title="Using Eclipse">
      <tasks xsi:type="exercise:Task">
        <q xsi:type="exercise:StringQuestion" question="Use breakpoints to debug code."/>
        <a xsi:type="workbench:DebugEventAnswer" action="suspend.breakpoint"/>
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
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1517683423003" resourcePath="/ovinger/src/encapsulation/Nim.java" sizeMeasure="5" className="encapsulation.Nim">
          <edit xsi:type="exercise:StringEdit" storedString="package encapsulation;&#xA;&#xA;public class Nim {&#xA;&#xA;}&#xA;"/>
        </attempts>
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1517684383745" resourcePath="/ovinger/src/encapsulation/Nim.java" sizeMeasure="35" className="encapsulation.Nim">
          <edit xsi:type="exercise:ReplaceSubstringEdit" storedString="&#x9;&#xA;&#x9;int[]&#xA;&#x9;&#xA;&#x9;Nim(){&#xA;&#x9;&#x9;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;Nim(int pileSize){&#xA;&#x9;&#x9;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;int getPile(int targetPile) {&#xA;&#x9;&#x9;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;String toString() {&#xA;&#x9;&#x9;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;boolean isGameOver() {&#xA;&#x9;&#x9;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;boolean isValidMove(int number, int targetPile) {&#xA;&#x9;&#x9;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;void removePieces(int number, int targetPile) {&#xA;&#x9;&#x9;&#xA;&#x9;}&#xA;&#x9;" edit="/1/@proposals.0/@proposals.0/@attempts.0/@edit" start="43" end="-4"/>
        </attempts>
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1517687742643" resourcePath="/ovinger/src/encapsulation/Nim.java" sizeMeasure="62" className="encapsulation.Nim">
          <edit xsi:type="exercise:ReplaceSubstringEdit" storedString="private int[] piles = {0,0,0};&#xA;&#x9;private int initPileSize = 0;&#xA;&#x9;&#xA;&#x9;&#xA;&#x9;public Nim(){&#xA;&#x9;&#x9;for(int i=0; i&lt;3; i++) {&#xA;&#x9;&#x9;&#x9;piles[i]=10;&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public Nim(int pileSize){&#xA;&#x9;&#x9;initPileSize=pileSize;&#xA;&#x9;&#x9;for(int i=0; i&lt;3; i++) {&#xA;&#x9;&#x9;&#x9;piles[i]=initPileSize;&#xA;&#x9;&#x9;}&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public int getPile(int targetPile) {&#xA;&#x9;&#x9;return piles[targetPile];&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public String toString() {&#xA;&#x9;&#x9;String tilstand = &quot;Spillets tilstand er: Stack 0 har &quot; + piles[0] + &quot;brikker, Stack 1 har &quot; + piles[1] + &quot;brikker og Stack 2 har &quot; + piles[2]  + &quot;brikker.&quot;;&#xA;&#x9;&#x9;return tilstand;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public boolean isGameOver() {&#xA;&#x9;&#x9;if (piles[0]==0|piles[1]==0|piles[2]==0) {&#xA;&#x9;&#x9;&#x9;return true;&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;return false;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;//sjekk at game=over også da eller?&#xA;&#x9;public boolean isValidMove(int number, int targetPile) {&#xA;&#x9;&#x9;if (isGameOver()) {&#xA;&#x9;&#x9;&#x9;return false;&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;if (targetPile > 2 | targetPile &lt; 0) {&#xA;&#x9;&#x9;&#x9;return false;&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;if (number > piles[targetPile]) {&#xA;&#x9;&#x9;&#x9;return false;&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;return true;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public void removePieces(int number, int targetPile) throws IllegalArgumentException{&#xA;&#x9;&#x9;if (isValidMove(number, targetPile)) {&#xA;&#x9;&#x9;&#x9;piles[targetPile]=piles[targetPile]-number;&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;else {&#xA;&#x9;&#x9;&#x9;throw new IllegalArgumentException(&quot;FAAIIILLL&quot;);&#xA;&#x9;&#x9;}" edit="/1/@proposals.0/@proposals.0/@attempts.1/@edit" start="46" end="-9"/>
        </attempts>
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1517688453047" resourcePath="/ovinger/src/encapsulation/Nim.java" sizeMeasure="62" className="encapsulation.Nim">
          <edit xsi:type="exercise:ReplaceSubstringEdit" storedString="throws IllegalArgumentException{&#xA;&#x9;&#x9;if (piles[0]==0|piles[1]==0|piles[2]==0) {&#xA;&#x9;&#x9;&#x9;return true;&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;return false;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;//sjekk at game=over også da eller?&#xA;&#x9;public boolean isValidMove(int number, int targetPile) throws IllegalArgumentException" edit="/1/@proposals.0/@proposals.0/@attempts.2/@edit" start="607" end="-436"/>
        </attempts>
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1517688976258" resourcePath="/ovinger/src/encapsulation/Nim.java" sizeMeasure="62" className="encapsulation.Nim">
          <edit xsi:type="exercise:ReplaceSubstringEdit" storedString="!isValidMove(number, targetPile)) {&#xA;&#x9;&#x9;&#x9;throw new IllegalArgumentException(&quot;FAAIIILLL&quot;);&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;else {&#xA;&#x9;&#x9;&#x9;piles[targetPile]=piles[targetPile]-number" edit="/1/@proposals.0/@proposals.0/@attempts.3/@edit" start="1127" end="-14"/>
        </attempts>
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1517689205928" resourcePath="/ovinger/src/encapsulation/Nim.java" sizeMeasure="65" className="encapsulation.Nim">
          <edit xsi:type="exercise:ReplaceSubstringEdit" storedString="if (number &lt; 0" edit="/1/@proposals.0/@proposals.0/@attempts.4/@edit" start="1016" end="-298"/>
        </attempts>
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1517689243693" resourcePath="/ovinger/src/encapsulation/Nim.java" sizeMeasure="65" className="encapsulation.Nim">
          <edit xsi:type="exercise:ReplaceSubstringEdit" storedString="1" edit="/1/@proposals.0/@proposals.0/@attempts.5/@edit" start="1029" end="-298"/>
        </attempts>
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1517689680010" resourcePath="/ovinger/src/encapsulation/Nim.java" sizeMeasure="68" className="encapsulation.Nim">
          <edit xsi:type="exercise:ReplaceSubstringEdit" storedString=" == 0 | piles[1] == 0 | piles[2] == 0) {&#xA;&#x9;&#x9;&#x9;return true;&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;return false;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;//sjekk at game=over også da eller?&#xA;&#x9;public boolean isValidMove(int number, int targetPile) throws IllegalArgumentException{&#xA;&#x9;&#x9;if (isGameOver()) {&#xA;&#x9;&#x9;&#x9;return false;&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;if (targetPile > 2 | targetPile &lt; 0) {&#xA;&#x9;&#x9;&#x9;return false;&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;if (number > piles[targetPile]) {&#xA;&#x9;&#x9;&#x9;return false;&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;if (number &lt; 1) {&#xA;&#x9;&#x9;&#x9;return false;&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;return true;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public void removePieces(int number, int targetPile) throws IllegalArgumentException{&#xA;&#x9;&#x9;if (isGameOver()) {&#xA;&#x9;&#x9;&#x9;throw new IllegalArgumentException(&quot;Kampen er over!&quot;);&#xA;&#x9;&#x9;}" edit="/1/@proposals.0/@proposals.0/@attempts.6/@edit" start="654" end="-167"/>
        </attempts>
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1517692369506" resourcePath="/ovinger/src/encapsulation/Nim.java" sizeMeasure="71" className="encapsulation.Nim">
          <edit xsi:type="exercise:ReplaceSubstringEdit" storedString="if (piles[0] &lt;= 0 | piles[1] &lt;= 0 | piles[2] &lt;= 0) {&#xA;&#x9;&#x9;&#x9;throw new IllegalArgumentException(&quot;Faen funk da!&quot;)" edit="/1/@proposals.0/@proposals.0/@attempts.7/@edit" start="717" end="-713"/>
        </attempts>
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1517693061701" resourcePath="/ovinger/src/encapsulation/Nim.java" sizeMeasure="71" className="encapsulation.Nim">
          <edit xsi:type="exercise:ReplaceSubstringEdit" storedString="throws IllegalArgumentException {&#xA;&#x9;&#x9;return piles[targetPile];&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public String toString() {&#xA;&#x9;&#x9;String tilstand = &quot;Spillets tilstand er: Stack 0 har &quot; + piles[0] + &quot;brikker, Stack 1 har &quot; + piles[1] + &quot;brikker og Stack 2 har &quot; + piles[2]  + &quot;brikker.&quot;;&#xA;&#x9;&#x9;return tilstand;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public boolean isGameOver() throws IllegalArgumentException{&#xA;&#x9;&#x9;if (piles[0] == 0 | piles[1] == 0 | piles[2] == 0) {&#xA;&#x9;&#x9;&#x9;return true;&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;if (piles[0] &lt;= 0 | piles[1] &lt;= 0 | piles[2] &lt;= 0) {&#xA;&#x9;&#x9;&#x9;throw new IllegalArgumentException(&quot;Faen funk da!&quot;);&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;return false;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;//sjekk at game=over også da eller?&#xA;&#x9;public boolean isValidMove(int number, int targetPile) throws IllegalArgumentException{&#xA;&#x9;&#x9;if (isGameOver()) {&#xA;&#x9;&#x9;&#x9;return false;&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;if (targetPile > 2 | targetPile &lt; 0) {&#xA;&#x9;&#x9;&#x9;return false;&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;if (number > piles[targetPile]) {&#xA;&#x9;&#x9;&#x9;return false;&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;if (number &lt; 1) {&#xA;&#x9;&#x9;&#x9;return false;&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;return true;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public void removePieces(int number, int targetPile) throws IllegalArgumentException{&#xA;&#x9;&#x9;if (isGameOver()) {&#xA;&#x9;&#x9;&#x9;throw new IllegalArgumentException(&quot;Kampen er over!&quot;);&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;else " edit="/1/@proposals.0/@proposals.0/@attempts.8/@edit" start="332" end="-164"/>
        </attempts>
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1517693504322" resourcePath="/ovinger/src/encapsulation/Nim.java" sizeMeasure="68" className="encapsulation.Nim">
          <edit xsi:type="exercise:ReplaceSubstringEdit" storedString="targetPile > 2 | targetPile &lt; 0) {&#xA;&#x9;&#x9;&#x9;return false;&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;if (number > piles[targetPile]) {&#xA;&#x9;&#x9;&#x9;return false;&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;if (number &lt; 1) {&#xA;&#x9;&#x9;&#x9;return false;&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;return true;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public void removePieces(int number, int targetPile) throws IllegalArgumentException{&#xA;&#x9;&#x9;if (isGameOver()) {&#xA;&#x9;&#x9;&#x9;throw new IllegalArgumentException(&quot;Kampen er over!&quot;);&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;else if (!isValidMove(number, targetPile)) {&#xA;&#x9;&#x9;&#x9;throw new IllegalArgumentException(&quot;FAAIIILLL&quot;);&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;else {&#xA;&#x9;&#x9;&#x9;piles[targetPile]=piles[targetPile] - " edit="/1/@proposals.0/@proposals.0/@attempts.9/@edit" start="1015" end="-20"/>
        </attempts>
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1517693524173" resourcePath="/ovinger/src/encapsulation/Nim.java" sizeMeasure="71" className="encapsulation.Nim">
          <edit xsi:type="exercise:ReplaceSubstringEdit" storedString="isGameOver()) {&#xA;&#x9;&#x9;&#x9;return false;&#xA;&#x9;&#x9;}" edit="/1/@proposals.0/@proposals.0/@attempts.10/@edit" start="1015" end="-525"/>
        </attempts>
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1517694115431" resourcePath="/ovinger/src/encapsulation/Nim.java" sizeMeasure="71" className="encapsulation.Nim">
          <edit xsi:type="exercise:ReplaceSubstringEdit" storedString="{&#xA;&#x9;&#x9;return piles[targetPile];&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public String toString() {&#xA;&#x9;&#x9;String tilstand = &quot;Spillets tilstand er: Stack 0 har &quot; + piles[0] + &quot;brikker, Stack 1 har &quot; + piles[1] + &quot;brikker og Stack 2 har &quot; + piles[2]  + &quot;brikker.&quot;;&#xA;&#x9;&#x9;return tilstand;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public boolean isGameOver() throws IllegalStateException{&#xA;&#x9;&#x9;if (piles[0] == 0 | piles[1] == 0 | piles[2] == 0) {&#xA;&#x9;&#x9;&#x9;return true;&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;if (piles[0] &lt;= 0 | piles[1] &lt;= 0 | piles[2] &lt;= 0) {&#xA;&#x9;&#x9;&#x9;throw new IllegalStateException(&quot;Faen funk da!&quot;);&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;return false;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;//sjekk at game=over også da eller?&#xA;&#x9;public boolean isValidMove(int number, int targetPile) throws IllegalArgumentException{&#xA;&#x9;&#x9;if (isGameOver()) {&#xA;&#x9;&#x9;&#x9;return false;&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;if (targetPile > 2 | targetPile &lt; 0) {&#xA;&#x9;&#x9;&#x9;return false;&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;if (number > piles[targetPile]) {&#xA;&#x9;&#x9;&#x9;return false;&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;if (number &lt; 1) {&#xA;&#x9;&#x9;&#x9;return false;&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;return true;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public void removePieces(int number, int targetPile) throws IllegalArgumentException{&#xA;&#x9;&#x9;if (isGameOver()) {&#xA;&#x9;&#x9;&#x9;throw new IllegalState" edit="/1/@proposals.0/@proposals.0/@attempts.11/@edit" start="332" end="-207"/>
        </attempts>
      </proposals>
      <proposals xsi:type="jdt:JdtLaunchProposal" question="/0/@parts.0/@tasks.1/@q" answer="/0/@parts.0/@tasks.1/@a"/>
      <proposals xsi:type="junit:JunitTestProposal" question="/0/@parts.0/@tasks.2/@q" answer="/0/@parts.0/@tasks.2/@a">
        <attempts xsi:type="junit:JunitTestEvent" timestamp="1517687744543" completion="0.25" testRunName="encapsulation.NimTest" successCount="1" failureCount="3">
          <successTests>testConstructor</successTests>
          <failureTests>testGameOver</failureTests>
          <failureTests>testIsValidMove</failureTests>
          <failureTests>testRemovePieces</failureTests>
        </attempts>
        <attempts xsi:type="junit:JunitTestEvent" timestamp="1517688454880" completion="0.25" testRunName="encapsulation.NimTest" successCount="1" failureCount="3">
          <successTests>testConstructor</successTests>
          <failureTests>testGameOver</failureTests>
          <failureTests>testIsValidMove</failureTests>
          <failureTests>testRemovePieces</failureTests>
        </attempts>
        <attempts xsi:type="junit:JunitTestEvent" timestamp="1517688978312" completion="0.25" testRunName="encapsulation.NimTest" successCount="1" failureCount="3">
          <successTests>testConstructor</successTests>
          <failureTests>testGameOver</failureTests>
          <failureTests>testIsValidMove</failureTests>
          <failureTests>testRemovePieces</failureTests>
        </attempts>
        <attempts xsi:type="junit:JunitTestEvent" timestamp="1517689207826" completion="0.25" testRunName="encapsulation.NimTest" successCount="1" failureCount="3">
          <successTests>testConstructor</successTests>
          <failureTests>testGameOver</failureTests>
          <failureTests>testIsValidMove</failureTests>
          <failureTests>testRemovePieces</failureTests>
        </attempts>
        <attempts xsi:type="junit:JunitTestEvent" timestamp="1517689246874" completion="0.75" testRunName="encapsulation.NimTest" successCount="3" failureCount="1">
          <successTests>testIsValidMove</successTests>
          <successTests>testRemovePieces</successTests>
          <successTests>testConstructor</successTests>
          <failureTests>testGameOver</failureTests>
        </attempts>
        <attempts xsi:type="junit:JunitTestEvent" timestamp="1517689681874" completion="0.75" testRunName="encapsulation.NimTest" successCount="3" failureCount="1">
          <successTests>testIsValidMove</successTests>
          <successTests>testRemovePieces</successTests>
          <successTests>testConstructor</successTests>
          <failureTests>testGameOver</failureTests>
        </attempts>
        <attempts xsi:type="junit:JunitTestEvent" timestamp="1517690170749" completion="0.75" testRunName="encapsulation.NimTest" successCount="3" failureCount="1">
          <successTests>testIsValidMove</successTests>
          <successTests>testRemovePieces</successTests>
          <successTests>testConstructor</successTests>
          <failureTests>testGameOver</failureTests>
        </attempts>
        <attempts xsi:type="junit:JunitTestEvent" timestamp="1517690564800" completion="0.75" testRunName="encapsulation.NimTest" successCount="3" failureCount="1">
          <successTests>testIsValidMove</successTests>
          <successTests>testRemovePieces</successTests>
          <successTests>testConstructor</successTests>
          <failureTests>testGameOver</failureTests>
        </attempts>
        <attempts xsi:type="junit:JunitTestEvent" timestamp="1517692371426" completion="0.75" testRunName="encapsulation.NimTest" successCount="3" failureCount="1">
          <successTests>testIsValidMove</successTests>
          <successTests>testRemovePieces</successTests>
          <successTests>testConstructor</successTests>
          <failureTests>testGameOver</failureTests>
        </attempts>
        <attempts xsi:type="junit:JunitTestEvent" timestamp="1517693064280" completion="0.75" testRunName="encapsulation.NimTest" successCount="3" failureCount="1">
          <successTests>testIsValidMove</successTests>
          <successTests>testRemovePieces</successTests>
          <successTests>testConstructor</successTests>
          <failureTests>testGameOver</failureTests>
        </attempts>
        <attempts xsi:type="junit:JunitTestEvent" timestamp="1517693506284" completion="0.5" testRunName="encapsulation.NimTest" successCount="2" failureCount="2">
          <successTests>testRemovePieces</successTests>
          <successTests>testConstructor</successTests>
          <failureTests>testGameOver</failureTests>
          <failureTests>testIsValidMove</failureTests>
        </attempts>
        <attempts xsi:type="junit:JunitTestEvent" timestamp="1517693526800" completion="0.75" testRunName="encapsulation.NimTest" successCount="3" failureCount="1">
          <successTests>testIsValidMove</successTests>
          <successTests>testRemovePieces</successTests>
          <successTests>testConstructor</successTests>
          <failureTests>testGameOver</failureTests>
        </attempts>
        <attempts xsi:type="junit:JunitTestEvent" timestamp="1517694117213" completion="1.0" testRunName="encapsulation.NimTest" successCount="4">
          <successTests>testGameOver</successTests>
          <successTests>testIsValidMove</successTests>
          <successTests>testRemovePieces</successTests>
          <successTests>testConstructor</successTests>
        </attempts>
      </proposals>
    </proposals>
    <proposals exercisePart="/0/@parts.1">
      <proposals xsi:type="workbench:DebugEventProposal" question="/0/@parts.1/@tasks.0/@q" answer="/0/@parts.1/@tasks.0/@a">
        <attempts xsi:type="workbench:WorkbenchTaskEvent" timestamp="1517690272618" elementId="encapsulation.NimTest" action="suspend.breakpoint"/>
        <attempts xsi:type="workbench:WorkbenchTaskEvent" timestamp="1517690537801" elementId="encapsulation.NimTest" action="suspend.breakpoint"/>
        <attempts xsi:type="workbench:WorkbenchTaskEvent" timestamp="1517690542971" elementId="encapsulation.NimTest" action="suspend.breakpoint"/>
        <attempts xsi:type="workbench:WorkbenchTaskEvent" timestamp="1517690547376" elementId="encapsulation.NimTest" action="suspend.breakpoint"/>
        <attempts xsi:type="workbench:WorkbenchTaskEvent" timestamp="1517690553041" elementId="encapsulation.NimTest" action="suspend.breakpoint"/>
      </proposals>
      <proposals xsi:type="workbench:CommandExecutionProposal" question="/0/@parts.1/@tasks.1/@q" answer="/0/@parts.1/@tasks.1/@a"/>
      <proposals xsi:type="workbench:CommandExecutionProposal" question="/0/@parts.1/@tasks.2/@q" answer="/0/@parts.1/@tasks.2/@a"/>
      <proposals xsi:type="workbench:PartTaskProposal" question="/0/@parts.1/@tasks.3/@q" answer="/0/@parts.1/@tasks.3/@a">
        <attempts xsi:type="workbench:PartTaskEvent" timestamp="1517690287824" elementId="org.eclipse.debug.ui.VariableView" action="activated"/>
      </proposals>
    </proposals>
  </exercise:ExerciseProposals>
</xmi:XMI>
