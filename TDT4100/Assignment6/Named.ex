<?xml version="1.0" encoding="UTF-8"?>
<xmi:XMI xmi:version="2.0" xmlns:xmi="http://www.omg.org/XMI" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:exercise="platform:/plugin/no.hal.learning.exercise.model/model/exercise.ecore" xmlns:jdt="platform:/plugin/no.hal.learning.exercise.jdt/model/jdt-exercise.ecore" xmlns:junit="platform:/plugin/no.hal.learning.exercise.junit/model/junit-exercise.ecore" xmlns:workbench="platform:/plugin/no.hal.learning.exercise.workbench/model/workbench-exercise.ecore">
  <exercise:Exercise>
    <parts xsi:type="exercise:ExercisePart" title="Named interface">
      <tasks xsi:type="exercise:Task">
        <q xsi:type="exercise:StringQuestion" question="Write source code for the Named interface."/>
        <a xsi:type="jdt:JdtSourceEditAnswer" className="interfaces.Named"/>
      </tasks>
    </parts>
    <parts xsi:type="exercise:ExercisePart" title="Person1 and Person2">
      <tasks xsi:type="exercise:Task">
        <q xsi:type="exercise:StringQuestion" question="Write source code for the Person1 class."/>
        <a xsi:type="jdt:JdtSourceEditAnswer" className="interfaces.Person1"/>
      </tasks>
      <tasks xsi:type="exercise:Task">
        <q xsi:type="exercise:StringQuestion" question="Write source code for the Person2 class."/>
        <a xsi:type="jdt:JdtSourceEditAnswer" className="interfaces.Person2"/>
      </tasks>
      <tasks xsi:type="exercise:Task">
        <q xsi:type="exercise:StringQuestion" question="Test the Person1 class, by running its main method."/>
        <a xsi:type="jdt:JdtLaunchAnswer" className="interfaces.Person1"/>
      </tasks>
      <tasks xsi:type="exercise:Task">
        <q xsi:type="exercise:StringQuestion" question="Test the Person2 class, by running its main method."/>
        <a xsi:type="jdt:JdtLaunchAnswer" className="interfaces.Person2"/>
      </tasks>
      <tasks xsi:type="exercise:Task">
        <q xsi:type="exercise:StringQuestion" question="Run the Person1Test JUnit test."/>
        <a xsi:type="junit:JunitTestAnswer" testRunName="interfaces.Person1Test"/>
      </tasks>
      <tasks xsi:type="exercise:Task">
        <q xsi:type="exercise:StringQuestion" question="Run the Person2Test JUnit test."/>
        <a xsi:type="junit:JunitTestAnswer" testRunName="interfaces.Person2Test"/>
      </tasks>
    </parts>
    <parts xsi:type="exercise:ExercisePart" title="NamedComparator">
      <tasks xsi:type="exercise:Task">
        <q xsi:type="exercise:StringQuestion" question="Write source code for the NamedComparator class."/>
        <a xsi:type="jdt:JdtSourceEditAnswer" className="interfaces.NamedComparator"/>
      </tasks>
      <tasks xsi:type="exercise:Task">
        <q xsi:type="exercise:StringQuestion" question="Test the NamedComparator class, by running its main method."/>
        <a xsi:type="jdt:JdtLaunchAnswer" className="interfaces.NamedComparator"/>
      </tasks>
      <tasks xsi:type="exercise:Task">
        <q xsi:type="exercise:StringQuestion" question="Run the NamedComparatorTest JUnit test."/>
        <a xsi:type="junit:JunitTestAnswer" testRunName="interfaces.NamedComparatorTest"/>
      </tasks>
    </parts>
    <parts xsi:type="exercise:ExercisePart" title="Tool usage">
      <tasks xsi:type="exercise:Task">
        <q xsi:type="exercise:StringQuestion" question="Use breakpoints to debug the Person classes."/>
        <a xsi:type="workbench:DebugEventAnswer" elementId="interfaces.Person*" action="suspend.breakpoint"/>
      </tasks>
      <tasks xsi:type="exercise:Task">
        <q xsi:type="exercise:StringQuestion" question="Use breakpoints to debug the NamedComparator class."/>
        <a xsi:type="workbench:DebugEventAnswer" elementId="interfaces.Named*" action="suspend.breakpoint"/>
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
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1520440470250" resourcePath="/ovinger/src/interfaces/Named.java" sizeMeasure="13" className="interfaces.Named">
          <edit xsi:type="exercise:StringEdit" storedString="package interfaces;&#xA;&#xA;public interface Named {&#xA;&#x9;&#xA;&#x9;public void setGivenName(String name);&#xA;&#x9;public String getGivenName();&#xA;&#x9;&#xA;&#x9;public void setFamilyName(String familyName);&#xA;&#x9;public String getFamilyName();&#xA;&#x9;&#xA;&#x9;public void setFullName(String fullName);&#xA;&#x9;public String getFullName();&#xA;}&#xA;"/>
        </attempts>
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1520440619484" resourcePath="/ovinger/src/interfaces/Named.java" sizeMeasure="13" className="interfaces.Named">
          <edit xsi:type="exercise:ReplaceSubstringEdit" storedString=".twitter" edit="/1/@proposals.0/@proposals.0/@attempts.0/@edit" start="18" end="-260"/>
        </attempts>
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1520440623679" resourcePath="/ovinger/src/interfaces/Named.java" sizeMeasure="13" className="interfaces.Named">
          <edit xsi:type="exercise:ReplaceSubstringEdit" storedString=";" edit="/1/@proposals.0/@proposals.0/@attempts.1/@edit" start="18" end="-259"/>
        </attempts>
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1520441915381" resourcePath="/ovinger/src/interfaces/Named.java" sizeMeasure="13" className="interfaces.Named">
          <edit xsi:type="exercise:ReplaceSubstringEdit" storedString="n" edit="/1/@proposals.0/@proposals.0/@attempts.2/@edit" start="161" end="-116"/>
        </attempts>
      </proposals>
    </proposals>
    <proposals exercisePart="/0/@parts.1">
      <proposals xsi:type="jdt:JdtSourceEditProposal" question="/0/@parts.1/@tasks.0/@q" answer="/0/@parts.1/@tasks.0/@a">
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1520440538478" resourcePath="/ovinger/src/interfaces/Person1.java" sizeMeasure="5" className="interfaces.Person1">
          <edit xsi:type="exercise:StringEdit" storedString="package interfaces;&#xA;&#xA;public class Person1 {&#xA;&#xA;}&#xA;"/>
        </attempts>
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1520441362857" resourcePath="/ovinger/src/interfaces/Person1.java" sizeMeasure="42" className="interfaces.Person1">
          <edit xsi:type="exercise:ReplaceSubstringEdit" storedString="implements Named{&#xA;&#x9;String _givenName;&#xA;&#x9;String _familyName;&#xA;&#x9;&#xA;&#x9;public Person1(String givenName,String familyName) {&#xA;&#x9;&#x9;_givenName=givenName;&#xA;&#x9;&#x9;_familyName=familyName;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public String getGivenName() {&#xA;&#x9;&#x9;return _givenName;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public void setGivenName(String name) {&#xA;&#x9;&#x9;_givenName=name;&#xA;&#x9;}&#xA;&#xA;&#x9;&#xA;&#x9;public void setFamilyName(String familyName) {&#xA;&#x9;&#x9;_familyName=familyName;&#xA;&#x9;}&#xA;&#xA;&#x9;&#xA;&#x9;public String getFamilyName() {&#xA;&#x9;&#x9;return _familyName;&#xA;&#x9;}&#xA;&#xA;&#x9;&#xA;&#x9;public void setFullName(String fullName) {&#xA;&#x9;&#x9;int index = fullName.indexOf(' ');&#xA;&#x9;&#x9;_givenName=fullName.substring(0, index);&#xA;&#x9;&#x9;_familyName=fullName.substring(index+1);&#xA;&#x9;}&#xA;&#xA;&#x9;&#xA;&#x9;public String getFullName() {&#xA;&#x9;&#x9;return _givenName + &quot; &quot; + _familyName;&#xA;&#x9;}" edit="/1/@proposals.1/@proposals.0/@attempts.0/@edit" start="42" end="-5"/>
        </attempts>
      </proposals>
      <proposals xsi:type="jdt:JdtSourceEditProposal" question="/0/@parts.1/@tasks.1/@q" answer="/0/@parts.1/@tasks.1/@a">
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1520440555266" resourcePath="/ovinger/src/interfaces/Person2.java" sizeMeasure="5" className="interfaces.Person2">
          <edit xsi:type="exercise:StringEdit" storedString="package interfaces;&#xA;&#xA;public class Person2 {&#xA;&#xA;}&#xA;"/>
        </attempts>
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1520440998234" resourcePath="/ovinger/src/interfaces/Person2.java" sizeMeasure="10" className="interfaces.Person2">
          <edit xsi:type="exercise:ReplaceSubstringEdit" storedString="implements Named{&#xA;&#x9;String _fullName;&#xA;&#x9;&#xA;&#x9;public Person2(String fullName){&#xA;&#x9;&#x9;_fullName=fullName;&#xA;&#x9;}" edit="/1/@proposals.1/@proposals.1/@attempts.0/@edit" start="42" end="-5"/>
        </attempts>
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1520441907845" resourcePath="/ovinger/src/interfaces/Person2.java" sizeMeasure="43" errorCount="6" className="interfaces.Person2">
          <edit xsi:type="exercise:ReplaceSubstringEdit" storedString="&#x9;@Override&#xA;&#x9;public void setGivenName(String name) {&#xA;&#x9;&#x9;_fullName=name + ' ' + getFamilyName();&#xA;&#x9;&#x9;&#xA;&#x9;}&#xA;&#xA;&#x9;@Override&#xA;&#x9;public String getGivenName() {&#xA;&#x9;&#x9;return _fullName.substring(0,_fullName.indexOf(' '));&#xA;&#x9;}&#xA;&#xA;&#x9;@Override&#xA;&#x9;public void setFamilyName(String familyName) {&#xA;&#x9;&#x9;_fullName=getGivenName() + ' ' + familyName;&#xA;&#x9;}&#xA;&#xA;&#x9;@Override&#xA;&#x9;public String getFamilyName() {&#xA;&#x9;&#x9;return _fullName.substring(_fullName.indexOf(' ')+1);&#xA;&#x9;}&#xA;&#xA;&#x9;@Override&#xA;&#x9;public void setFullName(String fullName) {&#xA;&#x9;&#x9;_fullName = fullName;&#xA;&#x9;}&#xA;&#xA;&#x9;@Override&#xA;&#x9;public String getFullName() {&#xA;&#x9;&#x9;return _fullName;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;" edit="/1/@proposals.1/@proposals.1/@attempts.1/@edit" start="141" end="-5"/>
          <markers xsi:type="jdt:JdtMarkerInfo" lineNumber="3" charStart="34" charEnd="41" severity="2" problemCategory="50" problemType="67109264"/>
        </attempts>
      </proposals>
      <proposals xsi:type="jdt:JdtLaunchProposal" question="/0/@parts.1/@tasks.2/@q" answer="/0/@parts.1/@tasks.2/@a"/>
      <proposals xsi:type="jdt:JdtLaunchProposal" question="/0/@parts.1/@tasks.3/@q" answer="/0/@parts.1/@tasks.3/@a"/>
      <proposals xsi:type="junit:JunitTestProposal" question="/0/@parts.1/@tasks.4/@q" answer="/0/@parts.1/@tasks.4/@a">
        <attempts xsi:type="junit:JunitTestEvent" timestamp="1520441363324" completion="1.0" testRunName="interfaces.Person1Test" successCount="1">
          <successTests>testPerson1</successTests>
        </attempts>
      </proposals>
      <proposals xsi:type="junit:JunitTestProposal" question="/0/@parts.1/@tasks.5/@q" answer="/0/@parts.1/@tasks.5/@a">
        <attempts xsi:type="junit:JunitTestEvent" timestamp="1520441916008" completion="1.0" testRunName="interfaces.Person2Test" successCount="1">
          <successTests>testPerson2</successTests>
        </attempts>
      </proposals>
    </proposals>
    <proposals exercisePart="/0/@parts.2">
      <proposals xsi:type="jdt:JdtSourceEditProposal" question="/0/@parts.2/@tasks.0/@q" answer="/0/@parts.2/@tasks.0/@a">
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1520442003175" resourcePath="/ovinger/src/interfaces/NamedComparator.java" sizeMeasure="7" className="interfaces.NamedComparator">
          <edit xsi:type="exercise:StringEdit" storedString="package interfaces;&#xA;&#xA;import java.util.Comparator;&#xA;&#xA;public class NamedComparator implements Comparator&lt;T> {&#xA;&#xA;}&#xA;"/>
        </attempts>
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1520442340760" resourcePath="/ovinger/src/interfaces/NamedComparator.java" sizeMeasure="16" className="interfaces.NamedComparator">
          <edit xsi:type="exercise:ReplaceSubstringEdit" storedString="Named> {&#xA;&#xA;&#x9;@Override&#xA;&#x9;public int compare(Named o1, Named o2) {&#xA;&#x9;&#x9;if (o1.getFamilyName()==o2.getFamilyName()) {&#xA;&#x9;&#x9;&#x9;return o1.getGivenName().compareTo(o2.getGivenName());&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;return o1.getFamilyName().compareTo(o2.getFamilyName());&#xA;&#x9;}&#xA;&#x9;" edit="/1/@proposals.2/@proposals.0/@attempts.0/@edit" start="102" end="-5"/>
        </attempts>
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1520442395577" resourcePath="/ovinger/src/interfaces/NamedComparator.java" sizeMeasure="16" className="interfaces.NamedComparator">
          <edit xsi:type="exercise:ReplaceSubstringEdit" storedString="2.getGivenName().compareTo(o1.getGivenName());&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;return o2.getFamilyName().compareTo(o1" edit="/1/@proposals.2/@proposals.0/@attempts.1/@edit" start="224" end="-28"/>
        </attempts>
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1520442625094" resourcePath="/ovinger/src/interfaces/NamedComparator.java" sizeMeasure="17" className="interfaces.NamedComparator">
          <edit xsi:type="exercise:ReplaceSubstringEdit" storedString="import java.util.Objects;&#xA;&#xA;public class NamedComparator implements Comparator&lt;Named> {&#xA;&#xA;&#x9;@Override&#xA;&#x9;public int compare(Named o1, Named o2) {&#xA;&#x9;&#x9;if (Objects.equals(o2.getFamilyName(), o1.getFamilyName()))" edit="/1/@proposals.2/@proposals.0/@attempts.2/@edit" start="50" end="-132"/>
        </attempts>
      </proposals>
      <proposals xsi:type="jdt:JdtLaunchProposal" question="/0/@parts.2/@tasks.1/@q" answer="/0/@parts.2/@tasks.1/@a"/>
      <proposals xsi:type="junit:JunitTestProposal" question="/0/@parts.2/@tasks.2/@q" answer="/0/@parts.2/@tasks.2/@a">
        <attempts xsi:type="junit:JunitTestEvent" timestamp="1520442371497" completion="0.0" testRunName="interfaces.NamedComparatorTest" failureCount="1">
          <failureTests>testNamedComparator</failureTests>
        </attempts>
        <attempts xsi:type="junit:JunitTestEvent" timestamp="1520442396038" completion="0.0" testRunName="interfaces.NamedComparatorTest" failureCount="1">
          <failureTests>testNamedComparator</failureTests>
        </attempts>
      </proposals>
    </proposals>
    <proposals exercisePart="/0/@parts.3">
      <proposals xsi:type="workbench:DebugEventProposal" question="/0/@parts.3/@tasks.0/@q" answer="/0/@parts.3/@tasks.0/@a"/>
      <proposals xsi:type="workbench:DebugEventProposal" question="/0/@parts.3/@tasks.1/@q" answer="/0/@parts.3/@tasks.1/@a"/>
      <proposals xsi:type="workbench:CommandExecutionProposal" question="/0/@parts.3/@tasks.2/@q" answer="/0/@parts.3/@tasks.2/@a">
        <attempts xsi:type="workbench:WorkbenchTaskEvent" timestamp="1517912685537" elementId="org.eclipse.debug.ui.commands.StepOver" action="executeSuccess"/>
        <attempts xsi:type="workbench:WorkbenchTaskEvent" timestamp="1519751199568" elementId="org.eclipse.debug.ui.commands.StepOver" action="executeSuccess"/>
        <attempts xsi:type="workbench:WorkbenchTaskEvent" timestamp="1519751203417" elementId="org.eclipse.debug.ui.commands.StepOver" action="executeSuccess"/>
      </proposals>
      <proposals xsi:type="workbench:CommandExecutionProposal" question="/0/@parts.3/@tasks.3/@q" answer="/0/@parts.3/@tasks.3/@a">
        <attempts xsi:type="workbench:WorkbenchTaskEvent" timestamp="1519751136803" elementId="org.eclipse.debug.ui.commands.StepInto" action="executeSuccess"/>
        <attempts xsi:type="workbench:WorkbenchTaskEvent" timestamp="1519751192725" elementId="org.eclipse.debug.ui.commands.StepInto" action="executeSuccess"/>
      </proposals>
      <proposals xsi:type="workbench:PartTaskProposal" question="/0/@parts.3/@tasks.4/@q" answer="/0/@parts.3/@tasks.4/@a">
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
