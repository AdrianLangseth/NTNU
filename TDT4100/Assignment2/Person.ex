<?xml version="1.0" encoding="UTF-8"?>
<xmi:XMI xmi:version="2.0" xmlns:xmi="http://www.omg.org/XMI" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:exercise="platform:/plugin/no.hal.learning.exercise.model/model/exercise.ecore" xmlns:jdt="platform:/plugin/no.hal.learning.exercise.jdt/model/jdt-exercise.ecore" xmlns:junit="platform:/plugin/no.hal.learning.exercise.junit/model/junit-exercise.ecore" xmlns:workbench="platform:/plugin/no.hal.learning.exercise.workbench/model/workbench-exercise.ecore">
  <exercise:Exercise>
    <parts xsi:type="exercise:ExercisePart" title="Person">
      <tasks xsi:type="exercise:Task">
        <q xsi:type="exercise:StringQuestion" question="Write source code for the Person class."/>
        <a xsi:type="jdt:JdtSourceEditAnswer" className="encapsulation.Person"/>
      </tasks>
      <tasks xsi:type="exercise:Task">
        <q xsi:type="exercise:StringQuestion" question="Run the Person class, to test it."/>
        <a xsi:type="jdt:JdtLaunchAnswer" className="encapsulation.Person"/>
      </tasks>
      <tasks xsi:type="exercise:Task">
        <q xsi:type="exercise:StringQuestion" question="Test the Person class, by running the PersonTest JUnit test."/>
        <a xsi:type="junit:JunitTestAnswer" testRunName="encapsulation.PersonTest"/>
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
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1517237072393" resourcePath="/ovinger/src/encapsulation/Person.java" sizeMeasure="121" errorCount="3" className="encapsulation.Person">
          <edit xsi:type="exercise:StringEdit" storedString="package encapsulation;&#xA;&#xA;import java.util.Date;&#xA;&#xA;public class Person {&#xA;&#x9;&#xA;&#x9;private String firstName;&#xA;&#x9;private String lastName;&#xA;&#x9;private String email;&#xA;&#x9;private String domain;&#xA;&#x9;private String countryCode;&#xA;&#x9;private Date birthday;&#xA;&#x9;private char gender;&#xA;&#x9;&#xA;&#x9;private boolean isValidDate(Date date) {&#xA;&#x9;&#x9;Date now = new Date();&#xA;&#x9;&#x9;if (birthday.getTime() > now.getTime()){&#xA;&#x9;&#x9;&#x9;return false;&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;return true;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;private boolean isValidName(String name) {&#xA;&#x9;&#x9;String[] splitName=name.split(&quot; &quot;);&#xA;&#x9;&#x9;&#xA;&#x9;&#x9;if (splitName.length != 2 || splitName[0].length()&lt;2 || splitName[1].length()&lt;2 || !splitName[0].matches(&quot;[a-zA-Z]+&quot;) || !splitName[1].matches(&quot;[a-zA-Z]+&quot;)) {&#xA;&#x9;&#x9;&#x9;return false;&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;return true;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;private boolean isValidCountryCode(String countryCode) {&#xA;&#x9;&#x9;String[] validCodes = {&quot;ad&quot;, &quot;ae&quot;, &quot;af&quot;, &quot;ag&quot;, &quot;ai&quot;, &quot;al&quot;, &quot;am&quot;, &quot;ao&quot;, &quot;aq&quot;, &quot;ar&quot;, &quot;as&quot;, &quot;at&quot;, &quot;au&quot;, &quot;aw&quot;, &quot;ax&quot;, &quot;az&quot;,&#xA;&#x9;&#x9;&#x9;      &quot;ba&quot;, &quot;bb&quot;, &quot;bd&quot;, &quot;be&quot;, &quot;bf&quot;, &quot;bg&quot;, &quot;bh&quot;, &quot;bi&quot;, &quot;bj&quot;, &quot;bl&quot;, &quot;bm&quot;, &quot;bn&quot;, &quot;bo&quot;, &quot;bq&quot;, &quot;br&quot;, &quot;bs&quot;,&#xA;&#x9;&#x9;&#x9;      &quot;bt&quot;, &quot;bv&quot;, &quot;bw&quot;, &quot;by&quot;, &quot;bz&quot;, &quot;ca&quot;, &quot;cc&quot;, &quot;cd&quot;, &quot;cf&quot;, &quot;cg&quot;, &quot;ch&quot;, &quot;ci&quot;, &quot;ck&quot;, &quot;cl&quot;, &quot;cm&quot;, &quot;cn&quot;,&#xA;&#x9;&#x9;&#x9;      &quot;co&quot;, &quot;cr&quot;, &quot;cu&quot;, &quot;cv&quot;, &quot;cw&quot;, &quot;cx&quot;, &quot;cy&quot;, &quot;cz&quot;, &quot;de&quot;, &quot;dj&quot;, &quot;dk&quot;, &quot;dm&quot;, &quot;do&quot;, &quot;dz&quot;, &quot;ec&quot;, &quot;ee&quot;,&#xA;&#x9;&#x9;&#x9;      &quot;eg&quot;, &quot;eh&quot;, &quot;er&quot;, &quot;es&quot;, &quot;et&quot;, &quot;fi&quot;, &quot;fj&quot;, &quot;fk&quot;, &quot;fm&quot;, &quot;fo&quot;, &quot;fr&quot;, &quot;ga&quot;, &quot;gb&quot;, &quot;gd&quot;, &quot;ge&quot;, &quot;gf&quot;,&#xA;&#x9;&#x9;&#x9;      &quot;gg&quot;, &quot;gh&quot;, &quot;gi&quot;, &quot;gl&quot;, &quot;gm&quot;, &quot;gn&quot;, &quot;gp&quot;, &quot;gq&quot;, &quot;gr&quot;, &quot;gs&quot;, &quot;gt&quot;, &quot;gu&quot;, &quot;gw&quot;, &quot;gy&quot;, &quot;hk&quot;, &quot;hm&quot;,&#xA;&#x9;&#x9;&#x9;      &quot;hn&quot;, &quot;hr&quot;, &quot;ht&quot;, &quot;hu&quot;, &quot;id&quot;, &quot;ie&quot;, &quot;il&quot;, &quot;im&quot;, &quot;in&quot;, &quot;io&quot;, &quot;iq&quot;, &quot;ir&quot;, &quot;is&quot;, &quot;it&quot;, &quot;je&quot;, &quot;jm&quot;,&#xA;&#x9;&#x9;&#x9;      &quot;jo&quot;, &quot;jp&quot;, &quot;ke&quot;, &quot;kg&quot;, &quot;kh&quot;, &quot;ki&quot;, &quot;km&quot;, &quot;kn&quot;, &quot;kp&quot;, &quot;kr&quot;, &quot;kw&quot;, &quot;ky&quot;, &quot;kz&quot;, &quot;la&quot;, &quot;lb&quot;, &quot;lc&quot;,&#xA;&#x9;&#x9;&#x9;      &quot;li&quot;, &quot;lk&quot;, &quot;lr&quot;, &quot;ls&quot;, &quot;lt&quot;, &quot;lu&quot;, &quot;lv&quot;, &quot;ly&quot;, &quot;ma&quot;, &quot;mc&quot;, &quot;md&quot;, &quot;me&quot;, &quot;mf&quot;, &quot;mg&quot;, &quot;mh&quot;, &quot;mk&quot;,&#xA;&#x9;&#x9;&#x9;      &quot;ml&quot;, &quot;mm&quot;, &quot;mn&quot;, &quot;mo&quot;, &quot;mp&quot;, &quot;mq&quot;, &quot;mr&quot;, &quot;ms&quot;, &quot;mt&quot;, &quot;mu&quot;, &quot;mv&quot;, &quot;mw&quot;, &quot;mx&quot;, &quot;my&quot;, &quot;mz&quot;, &quot;na&quot;,&#xA;&#x9;&#x9;&#x9;      &quot;nc&quot;, &quot;ne&quot;, &quot;nf&quot;, &quot;ng&quot;, &quot;ni&quot;, &quot;nl&quot;, &quot;no&quot;, &quot;np&quot;, &quot;nr&quot;, &quot;nu&quot;, &quot;nz&quot;, &quot;om&quot;, &quot;pa&quot;, &quot;pe&quot;, &quot;pf&quot;, &quot;pg&quot;,&#xA;&#x9;&#x9;&#x9;      &quot;ph&quot;, &quot;pk&quot;, &quot;pl&quot;, &quot;pm&quot;, &quot;pn&quot;, &quot;pr&quot;, &quot;ps&quot;, &quot;pt&quot;, &quot;pw&quot;, &quot;py&quot;, &quot;qa&quot;, &quot;re&quot;, &quot;ro&quot;, &quot;rs&quot;, &quot;ru&quot;, &quot;rw&quot;,&#xA;&#x9;&#x9;&#x9;      &quot;sa&quot;, &quot;sb&quot;, &quot;sc&quot;, &quot;sd&quot;, &quot;se&quot;, &quot;sg&quot;, &quot;sh&quot;, &quot;si&quot;, &quot;sj&quot;, &quot;sk&quot;, &quot;sl&quot;, &quot;sm&quot;, &quot;sn&quot;, &quot;so&quot;, &quot;sr&quot;, &quot;ss&quot;,&#xA;&#x9;&#x9;&#x9;      &quot;st&quot;, &quot;sv&quot;, &quot;sx&quot;, &quot;sy&quot;, &quot;sz&quot;, &quot;tc&quot;, &quot;td&quot;, &quot;tf&quot;, &quot;tg&quot;, &quot;th&quot;, &quot;tj&quot;, &quot;tk&quot;, &quot;tl&quot;, &quot;tm&quot;, &quot;tn&quot;, &quot;to&quot;,&#xA;&#x9;&#x9;&#x9;      &quot;tr&quot;, &quot;tt&quot;, &quot;tv&quot;, &quot;tw&quot;, &quot;tz&quot;, &quot;ua&quot;, &quot;ug&quot;, &quot;um&quot;, &quot;us&quot;, &quot;uy&quot;, &quot;uz&quot;, &quot;va&quot;, &quot;vc&quot;, &quot;ve&quot;, &quot;vg&quot;, &quot;vi&quot;,&#xA;&#x9;&#x9;&#x9;      &quot;vn&quot;, &quot;vu&quot;, &quot;wf&quot;, &quot;ws&quot;, &quot;ye&quot;, &quot;yt&quot;, &quot;za&quot;, &quot;zm&quot;, &quot;zw&quot;};&#xA;&#x9;&#x9;for (int i = 0; i &lt; validCodes.length; i++) {&#xA;&#x9;&#x9;&#x9;if (countryCode.equals(validCodes[i])) {&#xA;&#x9;&#x9;&#x9;&#x9;return true;&#xA;&#x9;&#x9;&#x9;}&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;return false;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;private boolean isValidGender(char gender) {&#xA;&#x9;&#x9;if (gender != 'M' &amp;&amp; gender != 'F' &amp;&amp; gender != '\0') {&#xA;&#x9;&#x9;&#x9;return false;&#x9;&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;return true;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public Person() {&#xA;&#x9;&#x9;firstName=&quot;&quot;;&#xA;&#x9;&#x9;lastName=&quot;&quot;;&#xA;&#x9;&#x9;email=&quot;&quot;;&#xA;&#x9;&#x9;domain=&quot;&quot;;&#xA;&#x9;&#x9;countryCode=&quot;&quot;;&#xA;&#x9;&#x9;birthday=null;&#xA;&#x9;&#x9;gender='\0';&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;&#xA;&#x9;public void setName(String name) {&#xA;&#x9;&#x9;if (!isValidName(name)) {&#xA;&#x9;&#x9;&#x9;throw new IllegalArgumentException(&quot;Name has to be two words of at least two letters sepparated by a space&quot;);&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;String[] splitName=name.split(&quot; &quot;);&#xA;&#x9;&#x9;firstName = splitName[0];&#xA;&#x9;    lastName = splitName[1];&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public void setEmail(String Email) {&#xA;&#x9;&#x9;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public void setBirthday(Date setDate) {&#xA;&#x9;&#x9;if (!isValidDate(setDate)) {&#xA;&#x9;&#x9;&#x9;throw new IllegalArgumentException(&quot;Birthday has to be in the past&quot;);&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;birthday=setDate;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public void setGender(char newGender) {&#xA;&#x9;&#x9;if (!isValidGender(newGender)) {&#xA;&#x9;&#x9;&#x9;throw new IllegalArgumentException(&quot;Gender has to be 'M', 'F' or '\0'&quot;);&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;gender=newGender;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public String getName() {&#xA;&#x9;&#x9;return firstName + &quot; &quot; + lastName;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public String getEmail() {&#xA;&#x9;&#x9;return email + &quot;@&quot; + domain + &quot;.&quot; + countryCode;&#xA;&#x9;&#x9;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public Date getBirthday() {&#xA;&#x9;&#x9;return birthday;&#xA;&#x9;&#x9;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public char getGender() {&#xA;&#x9;&#x9;return gender;&#xA;&#x9;&#x9;&#xA;&#x9;}&#xA;&#xA;}&#xA;"/>
          <markers xsi:type="jdt:JdtMarkerInfo" lineNumber="76" charStart="2877" charEnd="2877" severity="2" problemCategory="50" problemType="33554515"/>
        </attempts>
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1517238102427" resourcePath="/ovinger/src/encapsulation/Person.java" sizeMeasure="135" className="encapsulation.Person">
          <edit xsi:type="exercise:ReplaceSubstringEdit" storedString="rivate boolean verifyMail(String name0, String name1) {&#xA;&#x9;    return (name0.toLowerCase().equals(firstName.toLowerCase()) &amp;&amp; name1.toLowerCase().equals(lastName.toLowerCase()));&#xA;&#x9;  }&#xA;&#x9;&#xA;&#x9;public Person() {&#xA;&#x9;&#x9;firstName=&quot;&quot;;&#xA;&#x9;&#x9;lastName=&quot;&quot;;&#xA;&#x9;&#x9;email=&quot;&quot;;&#xA;&#x9;&#x9;domain=&quot;&quot;;&#xA;&#x9;&#x9;countryCode=&quot;&quot;;&#xA;&#x9;&#x9;birthday=null;&#xA;&#x9;&#x9;gender='\0';&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;&#xA;&#x9;public void setName(String newName) {&#xA;&#x9;&#x9;if (!isValidName(newName)) {&#xA;&#x9;&#x9;&#x9;throw new IllegalArgumentException(&quot;Name has to be two words of at least two letters sepparated by a space&quot;);&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;String[] splitName=newName.split(&quot; &quot;);&#xA;&#x9;&#x9;firstName = splitName[0];&#xA;&#x9;    lastName = splitName[1];&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public void setEmail(String Email) {&#xA;&#x9;&#x9;String[] splitEmail=email.split(&quot;@&quot;);&#xA;&#x9;&#x9;if (splitEmail.length != 2) {&#xA;&#x9;        throw new IllegalArgumentException(&quot;Illegal email format&quot;);&#xA;&#x9;      }&#xA;&#x9;&#x9;String[] name = splitEmail[0].split(&quot;.&quot;);&#xA;&#x9;&#x9;String[] address = splitEmail[1].split(&quot;.&quot;);&#xA;&#x9;&#x9;if (name.length != 2 || verifyMail(name[0],name[1]) || address.length != 2 || !isValidCountryCode(address[1])) {&#xA;&#x9;&#x9;&#x9;throw new IllegalArgumentException(&quot;Illegal email format&quot;);&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;domain=address[0];&#xA;&#x9;&#x9;countryCode=address[1];" edit="/1/@proposals.0/@proposals.0/@attempts.0/@edit" start="2687" end="-627"/>
        </attempts>
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1517300150760" resourcePath="/ovinger/src/encapsulation/Person.java" sizeMeasure="134" errorCount="1" className="encapsulation.Person">
          <edit xsi:type="exercise:ReplaceSubstringEdit" storedString="domain;&#xA;&#x9;private String countryCode;&#xA;&#x9;private Date birthday;&#xA;&#x9;private char gender;&#xA;&#x9;&#xA;&#x9;private boolean isValidDate(Date date) throws IllegalArgumentException{&#xA;&#x9;&#x9;Date now = new Date();&#xA;&#x9;&#x9;if (birthday.getTime() > now.getTime()){&#xA;&#x9;&#x9;&#x9;return false;&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;return true;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;private boolean isValidName(String name) {&#xA;&#x9;&#x9;String[] splitName=name.split(&quot; &quot;);&#xA;&#x9;&#x9;&#xA;&#x9;&#x9;if (splitName.length != 2 || splitName[0].length()&lt;2 || splitName[1].length()&lt;2 || !splitName[0].matches(&quot;[a-zA-Z]+&quot;) || !splitName[1].matches(&quot;[a-zA-Z]+&quot;)) {&#xA;&#x9;&#x9;&#x9;return false;&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;return true;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;private boolean isValidCountryCode(String countryCode) {&#xA;&#x9;&#x9;String[] validCodes = {&quot;ad&quot;, &quot;ae&quot;, &quot;af&quot;, &quot;ag&quot;, &quot;ai&quot;, &quot;al&quot;, &quot;am&quot;, &quot;ao&quot;, &quot;aq&quot;, &quot;ar&quot;, &quot;as&quot;, &quot;at&quot;, &quot;au&quot;, &quot;aw&quot;, &quot;ax&quot;, &quot;az&quot;,&#xA;&#x9;&#x9;&#x9;      &quot;ba&quot;, &quot;bb&quot;, &quot;bd&quot;, &quot;be&quot;, &quot;bf&quot;, &quot;bg&quot;, &quot;bh&quot;, &quot;bi&quot;, &quot;bj&quot;, &quot;bl&quot;, &quot;bm&quot;, &quot;bn&quot;, &quot;bo&quot;, &quot;bq&quot;, &quot;br&quot;, &quot;bs&quot;,&#xA;&#x9;&#x9;&#x9;      &quot;bt&quot;, &quot;bv&quot;, &quot;bw&quot;, &quot;by&quot;, &quot;bz&quot;, &quot;ca&quot;, &quot;cc&quot;, &quot;cd&quot;, &quot;cf&quot;, &quot;cg&quot;, &quot;ch&quot;, &quot;ci&quot;, &quot;ck&quot;, &quot;cl&quot;, &quot;cm&quot;, &quot;cn&quot;,&#xA;&#x9;&#x9;&#x9;      &quot;co&quot;, &quot;cr&quot;, &quot;cu&quot;, &quot;cv&quot;, &quot;cw&quot;, &quot;cx&quot;, &quot;cy&quot;, &quot;cz&quot;, &quot;de&quot;, &quot;dj&quot;, &quot;dk&quot;, &quot;dm&quot;, &quot;do&quot;, &quot;dz&quot;, &quot;ec&quot;, &quot;ee&quot;,&#xA;&#x9;&#x9;&#x9;      &quot;eg&quot;, &quot;eh&quot;, &quot;er&quot;, &quot;es&quot;, &quot;et&quot;, &quot;fi&quot;, &quot;fj&quot;, &quot;fk&quot;, &quot;fm&quot;, &quot;fo&quot;, &quot;fr&quot;, &quot;ga&quot;, &quot;gb&quot;, &quot;gd&quot;, &quot;ge&quot;, &quot;gf&quot;,&#xA;&#x9;&#x9;&#x9;      &quot;gg&quot;, &quot;gh&quot;, &quot;gi&quot;, &quot;gl&quot;, &quot;gm&quot;, &quot;gn&quot;, &quot;gp&quot;, &quot;gq&quot;, &quot;gr&quot;, &quot;gs&quot;, &quot;gt&quot;, &quot;gu&quot;, &quot;gw&quot;, &quot;gy&quot;, &quot;hk&quot;, &quot;hm&quot;,&#xA;&#x9;&#x9;&#x9;      &quot;hn&quot;, &quot;hr&quot;, &quot;ht&quot;, &quot;hu&quot;, &quot;id&quot;, &quot;ie&quot;, &quot;il&quot;, &quot;im&quot;, &quot;in&quot;, &quot;io&quot;, &quot;iq&quot;, &quot;ir&quot;, &quot;is&quot;, &quot;it&quot;, &quot;je&quot;, &quot;jm&quot;,&#xA;&#x9;&#x9;&#x9;      &quot;jo&quot;, &quot;jp&quot;, &quot;ke&quot;, &quot;kg&quot;, &quot;kh&quot;, &quot;ki&quot;, &quot;km&quot;, &quot;kn&quot;, &quot;kp&quot;, &quot;kr&quot;, &quot;kw&quot;, &quot;ky&quot;, &quot;kz&quot;, &quot;la&quot;, &quot;lb&quot;, &quot;lc&quot;,&#xA;&#x9;&#x9;&#x9;      &quot;li&quot;, &quot;lk&quot;, &quot;lr&quot;, &quot;ls&quot;, &quot;lt&quot;, &quot;lu&quot;, &quot;lv&quot;, &quot;ly&quot;, &quot;ma&quot;, &quot;mc&quot;, &quot;md&quot;, &quot;me&quot;, &quot;mf&quot;, &quot;mg&quot;, &quot;mh&quot;, &quot;mk&quot;,&#xA;&#x9;&#x9;&#x9;      &quot;ml&quot;, &quot;mm&quot;, &quot;mn&quot;, &quot;mo&quot;, &quot;mp&quot;, &quot;mq&quot;, &quot;mr&quot;, &quot;ms&quot;, &quot;mt&quot;, &quot;mu&quot;, &quot;mv&quot;, &quot;mw&quot;, &quot;mx&quot;, &quot;my&quot;, &quot;mz&quot;, &quot;na&quot;,&#xA;&#x9;&#x9;&#x9;      &quot;nc&quot;, &quot;ne&quot;, &quot;nf&quot;, &quot;ng&quot;, &quot;ni&quot;, &quot;nl&quot;, &quot;no&quot;, &quot;np&quot;, &quot;nr&quot;, &quot;nu&quot;, &quot;nz&quot;, &quot;om&quot;, &quot;pa&quot;, &quot;pe&quot;, &quot;pf&quot;, &quot;pg&quot;,&#xA;&#x9;&#x9;&#x9;      &quot;ph&quot;, &quot;pk&quot;, &quot;pl&quot;, &quot;pm&quot;, &quot;pn&quot;, &quot;pr&quot;, &quot;ps&quot;, &quot;pt&quot;, &quot;pw&quot;, &quot;py&quot;, &quot;qa&quot;, &quot;re&quot;, &quot;ro&quot;, &quot;rs&quot;, &quot;ru&quot;, &quot;rw&quot;,&#xA;&#x9;&#x9;&#x9;      &quot;sa&quot;, &quot;sb&quot;, &quot;sc&quot;, &quot;sd&quot;, &quot;se&quot;, &quot;sg&quot;, &quot;sh&quot;, &quot;si&quot;, &quot;sj&quot;, &quot;sk&quot;, &quot;sl&quot;, &quot;sm&quot;, &quot;sn&quot;, &quot;so&quot;, &quot;sr&quot;, &quot;ss&quot;,&#xA;&#x9;&#x9;&#x9;      &quot;st&quot;, &quot;sv&quot;, &quot;sx&quot;, &quot;sy&quot;, &quot;sz&quot;, &quot;tc&quot;, &quot;td&quot;, &quot;tf&quot;, &quot;tg&quot;, &quot;th&quot;, &quot;tj&quot;, &quot;tk&quot;, &quot;tl&quot;, &quot;tm&quot;, &quot;tn&quot;, &quot;to&quot;,&#xA;&#x9;&#x9;&#x9;      &quot;tr&quot;, &quot;tt&quot;, &quot;tv&quot;, &quot;tw&quot;, &quot;tz&quot;, &quot;ua&quot;, &quot;ug&quot;, &quot;um&quot;, &quot;us&quot;, &quot;uy&quot;, &quot;uz&quot;, &quot;va&quot;, &quot;vc&quot;, &quot;ve&quot;, &quot;vg&quot;, &quot;vi&quot;,&#xA;&#x9;&#x9;&#x9;      &quot;vn&quot;, &quot;vu&quot;, &quot;wf&quot;, &quot;ws&quot;, &quot;ye&quot;, &quot;yt&quot;, &quot;za&quot;, &quot;zm&quot;, &quot;zw&quot;};&#xA;&#x9;&#x9;for (int i = 0; i &lt; validCodes.length; i++) {&#xA;&#x9;&#x9;&#x9;if (countryCode.equals(validCodes[i])) {&#xA;&#x9;&#x9;&#x9;&#x9;return true;&#xA;&#x9;&#x9;&#x9;}&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;return false;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;private boolean isValidGender(char gender) {&#xA;&#x9;&#x9;if (gender != 'M' &amp;&amp; gender != 'F' &amp;&amp; gender != '\0') {&#xA;&#x9;&#x9;&#x9;return false;&#x9;&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;return true;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;private boolean verifyMail(String name0, String name1) {&#xA;&#x9;    return (name0.toLowerCase().equals(firstName.toLowerCase()) &amp;&amp; name1.toLowerCase().equals(lastName.toLowerCase()));&#xA;&#x9;  }&#xA;&#x9;&#xA;&#x9;public Person() {&#xA;&#x9;&#x9;firstName=&quot;&quot;;&#xA;&#x9;&#x9;lastName=&quot;&quot;;&#xA;&#x9;&#x9;email=&quot;&quot;;&#xA;&#x9;&#x9;domain=&quot;&quot;;&#xA;&#x9;&#x9;countryCode=&quot;&quot;;&#xA;&#x9;&#x9;birthday=null;&#xA;&#x9;&#x9;gender='\0';&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;&#xA;&#x9;public void setName(String newName) {&#xA;&#x9;&#x9;if (!isValidName(newName)) {&#xA;&#x9;&#x9;&#x9;throw new IllegalArgumentException(&quot;Name has to be two words of at least two letters sepparated by a space&quot;);&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;String[] splitName=newName.split(&quot; &quot;);&#xA;&#x9;&#x9;firstName = splitName[0];&#xA;&#x9;    lastName = splitName[1];&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public void setEmail(String Email) {&#xA;&#x9;&#x9;String[] splitEmail=Email.split(&quot;@&quot;);&#xA;&#x9;&#x9;if (splitEmail.length != 2) {&#xA;&#x9;        throw new IllegalArgumentException(&quot;Illegal email format&quot;);&#xA;&#x9;      }&#xA;&#x9;&#x9;String[] name = splitEmail[0].split(&quot;.&quot;);&#xA;&#x9;&#x9;String[] address = splitEmail[1].split(&quot;.&quot;);&#xA;&#x9;&#x9;if (name.length != 2 || verifyMail(name[0],name[1]) || address.length != 2 || !isValidCountryCode(address[1])) {&#xA;&#x9;&#x9;&#x9;throw new IllegalArgumentException(&quot;Illegal email format&quot;);&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;domain=address[0];&#xA;&#x9;&#x9;countryCode=address[1];&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public void setBirthday(Date setDate) {&#xA;&#x9;&#x9;if (!isValidDate(setDate)) {&#xA;&#x9;&#x9;&#x9;throw new IllegalArgumentException(&quot;Birthday has to be in the past&quot;);&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;birthday=setDate;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public void setGender(char newGender) {&#xA;&#x9;&#x9;if (!isValidGender(newGender)) {&#xA;&#x9;&#x9;&#x9;throw new IllegalArgumentException(&quot;Gender has to be 'M', 'F' or '\0'&quot;);&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;gender=newGender;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public String getName() {&#xA;&#x9;&#x9;return firstName + &quot; &quot; + lastName;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public String getEmail() {&#xA;&#x9;&#x9;return firstName.toLowerCase() + &quot;.&quot; + lastName.toLowerCase()" edit="/1/@proposals.0/@proposals.0/@attempts.1/@edit" start="141" end="-155"/>
          <markers xsi:type="jdt:JdtMarkerInfo" lineNumber="70" charStart="2931" charEnd="2936" severity="2" problemCategory="50" problemType="33554515"/>
        </attempts>
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1517300182002" resourcePath="/ovinger/src/encapsulation/Person.java" sizeMeasure="133" className="encapsulation.Person">
          <edit xsi:type="exercise:ReplaceSubstringEdit" storedString="d" edit="/1/@proposals.0/@proposals.0/@attempts.2/@edit" start="2931" end="-1541"/>
        </attempts>
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1517300472852" resourcePath="/ovinger/src/encapsulation/Person.java" sizeMeasure="133" className="encapsulation.Person">
          <edit xsi:type="exercise:ReplaceSubstringEdit" storedString="throws IllegalArgumentException {&#xA;&#x9;&#x9;if (!isValidDate(setDate)) {&#xA;&#x9;&#x9;&#x9;throw new IllegalArgumentException(&quot;Birthday has to be in the past&quot;);&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;birthday=setDate;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public void setGender(char newGender) {&#xA;&#x9;&#x9;if (!isValidGender(newGender)) {&#xA;&#x9;&#x9;&#x9;throw new IllegalArgumentException(&quot;Gender has to be 'M', 'F' or '\0'&quot;);&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;gender=newGender;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public String getName() {&#xA;&#x9;&#x9;return firstName + &quot; &quot; + lastName;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public String getEmail() {&#xA;&#x9;&#x9;return firstName.toLowerCase() + &quot;.&quot; + lastName.toLowerCase() + &quot;@&quot; + domain + &quot;.&quot; + countryCode;&#xA;&#x9;&#x9;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public Date getBirthday() throws IllegalArgumentException" edit="/1/@proposals.0/@proposals.0/@attempts.3/@edit" start="3842" end="-83"/>
        </attempts>
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1517301547459" resourcePath="/ovinger/src/encapsulation/Person.java" sizeMeasure="135" warningCount="3" className="encapsulation.Person">
          <edit xsi:type="exercise:ReplaceSubstringEdit" storedString="      if (countryCode.equals(validCodes[i])) {&#xA;&#x9;&#x9;        return true;&#xA;&#x9;&#x9;      }&#xA;&#x9;&#x9;    }&#xA;&#x9;&#x9;return false;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;private boolean isValidGender(char gender) {&#xA;&#x9;&#x9;if (gender != 'M' &amp;&amp; gender != 'F' &amp;&amp; gender != '\0') {&#xA;&#x9;&#x9;&#x9;return false;&#x9;&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;return true;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;private boolean verifyMail(String name0, String name1) {&#xA;&#x9;    return (name0.toLowerCase().equals(firstName.toLowerCase()) &amp;&amp; name1.toLowerCase().equals(lastName.toLowerCase()));&#xA;&#x9;  }&#xA;&#x9;&#xA;&#x9;public Person() {&#xA;&#x9;&#x9;firstName=&quot;&quot;;&#xA;&#x9;&#x9;lastName=&quot;&quot;;&#xA;&#x9;&#x9;domain=&quot;&quot;;&#xA;&#x9;&#x9;countryCode=&quot;&quot;;&#xA;&#x9;&#x9;birthday=null;&#xA;&#x9;&#x9;gender='\0';&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;&#xA;&#x9;public void setName(String newName) throws IllegalArgumentException {&#xA;&#x9;&#x9;String[] splitName=newName.split(&quot; &quot;);&#xA;&#x9;&#x9;&#xA;&#x9;&#x9;if (splitName.length != 2 || splitName[0].length()&lt;2 || splitName[1].length()&lt;2 || !splitName[0].matches(&quot;[a-zA-Z]+&quot;) || !splitName[1].matches(&quot;[a-zA-Z]+&quot;)) {&#xA;&#x9;&#x9;&#x9;throw new IllegalArgumentException(&quot;Name has to be two words of at least two letters sepparated by a space&quot;);&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;firstName = splitName[0];&#xA;&#x9;    lastName = splitName[1];&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public void setEmail(String Email) {&#xA;&#x9;&#x9;String[] splitEmail=Email.split(&quot;@&quot;);&#xA;&#x9;&#x9;if (splitEmail.length != 2) {&#xA;&#x9;        throw new IllegalArgumentException(&quot;Illegal email format&quot;);&#xA;&#x9;      }&#xA;&#x9;&#x9;String[] name = splitEmail[0].split(&quot;\\.&quot;);&#xA;&#x9;&#x9;String[] address = splitEmail[1].split(&quot;\\.&quot;);&#xA;&#x9;&#x9;if (name.length != 2 || verifyMail(name[0],name[1]) || address.length != 2 || !isValidCountryCode(address[1])) {&#xA;&#x9;&#x9;&#x9;throw new IllegalArgumentException(&quot;Illegal email format&quot;);&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;domain=address[0];&#xA;&#x9;&#x9;countryCode=address[1];&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public void setBirthday(Date setDate) throws IllegalArgumentException {&#xA;&#x9;&#x9;Date now = new Date();&#xA;&#x9;&#x9;if ( setDate.getTime() > now.getTime() ) {&#xA;&#x9;&#x9;&#x9;throw new IllegalArgumentException(&quot;Birthday has to be in the past&quot;);&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;birthday=setDate;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public void setGender(char newGender) throws IllegalArgumentException {&#xA;&#x9;&#x9;if (newGender != 'M' &amp;&amp; newGender != 'F' &amp;&amp; newGender != '\0') {&#xA;&#x9;&#x9;      throw new IllegalArgumentException(&quot;Gender has to be 'M', 'F' or '\0'&quot;);&#xA;&#x9;&#x9;}&#xA;&#x9;&#x9;gender=newGender;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public String getName() {&#xA;&#x9;&#x9;return firstName + &quot; &quot; + lastName;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public String getEmail() {&#xA;&#x9;&#x9;return firstName.toLowerCase() + &quot;.&quot; + lastName.toLowerCase() + &quot;@&quot; + domain + &quot;.&quot; + countryCode;&#xA;&#x9;&#x9;&#xA;&#x9;}&#xA;&#x9;&#xA;&#x9;public Date getBirthday() " edit="/1/@proposals.0/@proposals.0/@attempts.4/@edit" start="2458" end="-83"/>
          <markers xsi:type="jdt:JdtMarkerInfo" lineNumber="22" charStart="425" charEnd="449" severity="1" problemCategory="120" problemType="603979894"/>
        </attempts>
        <attempts xsi:type="jdt:JdtSourceEditEvent" timestamp="1517301582338" resourcePath="/ovinger/src/encapsulation/Person.java" sizeMeasure="135" warningCount="3" className="encapsulation.Person">
          <edit xsi:type="exercise:ReplaceSubstringEdit" storedString="!" edit="/1/@proposals.0/@proposals.0/@attempts.5/@edit" start="3784" end="-1018"/>
          <markers xsi:type="jdt:JdtMarkerInfo" lineNumber="22" charStart="425" charEnd="449" severity="1" problemCategory="120" problemType="603979894"/>
        </attempts>
      </proposals>
      <proposals xsi:type="jdt:JdtLaunchProposal" question="/0/@parts.0/@tasks.1/@q" answer="/0/@parts.0/@tasks.1/@a"/>
      <proposals xsi:type="junit:JunitTestProposal" question="/0/@parts.0/@tasks.2/@q" answer="/0/@parts.0/@tasks.2/@a">
        <attempts xsi:type="junit:JunitTestEvent" timestamp="1517238104796" completion="0.4" testRunName="encapsulation.PersonTest" successCount="2" failureCount="3">
          <successTests>testSetGender</successTests>
          <successTests>testSetName</successTests>
          <failureTests>testSetBirthday</failureTests>
          <failureTests>testExtraCountryTopLevelDomains</failureTests>
          <failureTests>testSetEmail</failureTests>
        </attempts>
        <attempts xsi:type="junit:JunitTestEvent" timestamp="1517252694329" completion="0.4" testRunName="encapsulation.PersonTest" successCount="2" failureCount="3">
          <successTests>testSetGender</successTests>
          <successTests>testSetName</successTests>
          <failureTests>testSetBirthday</failureTests>
          <failureTests>testExtraCountryTopLevelDomains</failureTests>
          <failureTests>testSetEmail</failureTests>
        </attempts>
        <attempts xsi:type="junit:JunitTestEvent" timestamp="1517300152965" completion="0.0" testRunName="encapsulation.PersonTest" errorCount="5">
          <errorTests>testSetBirthday</errorTests>
          <errorTests>testExtraCountryTopLevelDomains</errorTests>
          <errorTests>testSetGender</errorTests>
          <errorTests>testSetName</errorTests>
          <errorTests>testSetEmail</errorTests>
        </attempts>
        <attempts xsi:type="junit:JunitTestEvent" timestamp="1517300184074" completion="0.4" testRunName="encapsulation.PersonTest" successCount="2" failureCount="3">
          <successTests>testSetGender</successTests>
          <successTests>testSetName</successTests>
          <failureTests>testSetBirthday</failureTests>
          <failureTests>testExtraCountryTopLevelDomains</failureTests>
          <failureTests>testSetEmail</failureTests>
        </attempts>
        <attempts xsi:type="junit:JunitTestEvent" timestamp="1517300475209" completion="0.4" testRunName="encapsulation.PersonTest" successCount="2" failureCount="3">
          <successTests>testSetGender</successTests>
          <successTests>testSetName</successTests>
          <failureTests>testSetBirthday</failureTests>
          <failureTests>testExtraCountryTopLevelDomains</failureTests>
          <failureTests>testSetEmail</failureTests>
        </attempts>
        <attempts xsi:type="junit:JunitTestEvent" timestamp="1517301554006" completion="0.6" testRunName="encapsulation.PersonTest" successCount="3" failureCount="2">
          <successTests>testSetBirthday</successTests>
          <successTests>testSetGender</successTests>
          <successTests>testSetName</successTests>
          <failureTests>testExtraCountryTopLevelDomains</failureTests>
          <failureTests>testSetEmail</failureTests>
        </attempts>
      </proposals>
    </proposals>
    <proposals exercisePart="/0/@parts.1">
      <proposals xsi:type="workbench:DebugEventProposal" question="/0/@parts.1/@tasks.0/@q" answer="/0/@parts.1/@tasks.0/@a"/>
      <proposals xsi:type="workbench:CommandExecutionProposal" question="/0/@parts.1/@tasks.1/@q" answer="/0/@parts.1/@tasks.1/@a"/>
      <proposals xsi:type="workbench:CommandExecutionProposal" question="/0/@parts.1/@tasks.2/@q" answer="/0/@parts.1/@tasks.2/@a"/>
      <proposals xsi:type="workbench:PartTaskProposal" question="/0/@parts.1/@tasks.3/@q" answer="/0/@parts.1/@tasks.3/@a"/>
    </proposals>
  </exercise:ExerciseProposals>
</xmi:XMI>