<?xml version="1.0" encoding="UTF-8"?>
<xmi:XMI xmi:version="2.0" xmlns:xmi="http://www.omg.org/XMI" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:exercise="platform:/plugin/no.hal.learning.exercise.model/model/exercise.ecore" xmlns:jdt="platform:/plugin/no.hal.learning.exercise.jdt/model/jdt-exercise.ecore" xmlns:junit="platform:/plugin/no.hal.learning.exercise.junit/model/junit-exercise.ecore" xmlns:workbench="platform:/plugin/no.hal.learning.exercise.workbench/model/workbench-exercise.ecore">
  <exercise:Exercise>
    <parts xsi:type="exercise:ExercisePart" title="Account">
      <tasks xsi:type="exercise:Task">
        <q xsi:type="exercise:StringQuestion" question="Write source code for the Account class."/>
        <a xsi:type="jdt:JdtSourceEditAnswer" className="encapsulation.Account"/>
      </tasks>
      <tasks xsi:type="exercise:Task">
        <q xsi:type="exercise:StringQuestion" question="Run the Account class, to test it."/>
        <a xsi:type="jdt:JdtLaunchAnswer" className="encapsulation.Account"/>
      </tasks>
      <tasks xsi:type="exercise:Task">
        <q xsi:type="exercise:StringQuestion" question="Test the Account class, by running the AccountTest JUnit test."/>
        <a xsi:type="junit:JunitTestAnswer" testRunName="encapsulation.AccountTest"/>
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
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1517077539185" sizeMeasure="41" errorCount="1">
          <edit xsi:type="exercise:StringEdit" storedString="package encapsulation;&#xA;&#xA;public class Account {&#xA;&#x9;&#xA;&#x9;private double balance;&#xA;&#x9;private double interestRate;&#xA;&#x9;&#xA;&#x9;public Account(double startBalance, double startInterestRate) {&#xA;&#x9;&#x9;balance=startBalance;&#xA;&#x9;&#x9;interestRate=startInterestRate;&#x9;&#x9;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public double getBalance() {&#xA;&#x9;&#x9;return balance;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public double getInterestRate(){&#xA;&#x9;&#x9;return interestRate;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public void setInterestRate(double interestRate) {&#xA;&#x9;&#x9;this.interestRate=interestRate;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public void deposit(double amount) {&#xA;&#x9;&#x9;balance=balance+amount;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public void withdraw(double amount) {&#xA;&#x9;&#x9;if (balance&lt;amount) {&#xA;&#x9;&#x9;&#x9;throw new IllegalArgumentException(&quot;Amount Exceeds balance&quot;)&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;balance=balance-amount;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public void addInterest() {&#xA;&#x9;&#x9;double interest=balance*interestRate;&#xA;&#x9;&#x9;balance=balance+interest;&#xA;&#x9;}&#xA;&#x9;&#xA;}&#xA;"/>
          <markers xsi:type="jdt:JdtMarkerInfo" lineNumber="31" charStart="636" charEnd="637" severity="2" problemCategory="20" problemType="1610612976"/>
        </attempts>
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1517077904820" sizeMeasure="50" errorCount="1">
          <edit xsi:type="exercise:ReplaceSubstringEdit" storedString="if (startbalance&lt;0) {&#xA;&#x9;&#x9;&#x9;throw new IllegalArgumentException(&quot;Start balance must be positive.&quot;);&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;balance=startBalance;&#xA;&#x9;&#x9;interestRate=startInterestRate;&#x9;&#x9;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public double getBalance() {&#xA;&#x9;&#x9;return balance;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public double getInterestRate(){&#xA;&#x9;&#x9;return interestRate;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public void setInterestRate(double interestRate) {&#xA;&#x9;&#x9;if (interestRate&lt;0) {&#xA;&#x9;&#x9;&#x9;throw new IllegalArgumentException(&quot;Amount Exceeds balance&quot;);&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;this.interestRate=interestRate;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public void deposit(double amount) {&#xA;&#x9;&#x9;if (amount&lt;0) {&#xA;&#x9;&#x9;&#x9;throw new IllegalArgumentException(&quot;Amount Exceeds balance&quot;);&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;balance=balance+amount;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public void withdraw(double amount) {&#xA;&#x9;&#x9;if (balance&lt;amount) {&#xA;&#x9;&#x9;&#x9;throw new IllegalArgumentException(&quot;Amount Exceeds balance&quot;);" edit="/1/@proposals.0/@proposals.0/@attempts.0/@edit" start="173" end="-141"/>
          <markers xsi:type="jdt:JdtMarkerInfo" lineNumber="9" charStart="177" charEnd="189" severity="2" problemCategory="50" problemType="33554515"/>
        </attempts>
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1517077931999" sizeMeasure="50">
          <edit xsi:type="exercise:ReplaceSubstringEdit" storedString="B" edit="/1/@proposals.0/@proposals.0/@attempts.1/@edit" start="182" end="-878"/>
        </attempts>
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1517077964699" sizeMeasure="53">
          <edit xsi:type="exercise:ReplaceSubstringEdit" storedString="if (startInterestRat" edit="/1/@proposals.0/@proposals.0/@attempts.2/@edit" start="275" end="-873"/>
        </attempts>
      </proposals>
      <proposals xsi:type="jdt:JdtLaunchProposal" question="/0/@parts.0/@tasks.1/@q" answer="/0/@parts.0/@tasks.1/@a"/>
      <proposals xsi:type="junit:JunitTestProposal" question="/0/@parts.0/@tasks.2/@q" answer="/0/@parts.0/@tasks.2/@a" completion="1.0">
        <attempts xsi:type="junit:JunitTestEvent" timestamp="1517077545859" completion="0.16666666666666666" successCount="1" failureCount="3" errorCount="2">
          <successTests>testDeposit</successTests>
          <failureTests>testAccount</failureTests>
          <failureTests>testSetInterestRate</failureTests>
          <failureTests>testDepositNegativeAmount</failureTests>
          <errorTests>testWithdrawTooLargeAmount</errorTests>
          <errorTests>testWithdraw</errorTests>
        </attempts>
        <attempts xsi:type="junit:JunitTestEvent" timestamp="1517077907567" completion="0.0" errorCount="6">
          <errorTests>testAccount</errorTests>
          <errorTests>testSetInterestRate</errorTests>
          <errorTests>testWithdrawTooLargeAmount</errorTests>
          <errorTests>testWithdraw</errorTests>
          <errorTests>testDepositNegativeAmount</errorTests>
          <errorTests>testDeposit</errorTests>
        </attempts>
        <attempts xsi:type="junit:JunitTestEvent" timestamp="1517077934429" completion="0.8333333333333334" successCount="5" failureCount="1">
          <successTests>testSetInterestRate</successTests>
          <successTests>testWithdrawTooLargeAmount</successTests>
          <successTests>testWithdraw</successTests>
          <successTests>testDepositNegativeAmount</successTests>
          <successTests>testDeposit</successTests>
          <failureTests>testAccount</failureTests>
        </attempts>
        <attempts xsi:type="junit:JunitTestEvent" timestamp="1517077966414" completion="1.0" successCount="6">
          <successTests>testAccount</successTests>
          <successTests>testSetInterestRate</successTests>
          <successTests>testWithdrawTooLargeAmount</successTests>
          <successTests>testWithdraw</successTests>
          <successTests>testDepositNegativeAmount</successTests>
          <successTests>testDeposit</successTests>
        </attempts>
      </proposals>
    </proposals>
    <proposals exercisePart="/0/@parts.1">
      <proposals xsi:type="workbench:DebugEventProposal" question="/0/@parts.1/@tasks.0/@q" answer="/0/@parts.1/@tasks.0/@a"/>
      <proposals xsi:type="workbench:CommandExecutionProposal" question="/0/@parts.1/@tasks.1/@q" answer="/0/@parts.1/@tasks.1/@a"/>
      <proposals xsi:type="workbench:CommandExecutionProposal" question="/0/@parts.1/@tasks.2/@q" answer="/0/@parts.1/@tasks.2/@a"/>
      <proposals xsi:type="workbench:PartTaskProposal" question="/0/@parts.1/@tasks.3/@q" answer="/0/@parts.1/@tasks.3/@a" performedCount="2">
        <attempts timestamp="1517229206115"/>
        <attempts timestamp="1517229211803"/>
      </proposals>
    </proposals>
  </exercise:ExerciseProposals>
</xmi:XMI>
