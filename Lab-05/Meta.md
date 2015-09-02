<h1 id="it-infrastructure-lab-5-instructions">IT Infrastructure Lab 5 Instructions</h1>
<p><strong>Overview</strong></p>
<p>Lab objectives:
Examine the details of an end to end DevOps pipeline and participate in it using your development environment.</p>
<p>outline (somewhat meta)</p>
<p>first, the default is not for each student to install their own entire pipeline on the server. the server will not scale to that level, and it's too much complexity for me to support.</p>
<p>so, we need to stand up ONE pipeline. (I need to get the pipeline working end to end on seis660)</p>
<p>they each need their own development machine working... or should I do one per team?  I may need to configure the whole cluster. This is where containers would make a lot more sense. </p>
<p>they need to examine the chain step by step and run small experiments</p>
<p>we need a lab that has the students collaborating on making small contributions to the application in a distributed way.</p>
<p>they each need to add a small piece of functionality with a small test case</p>
<ul>
<li>each should add their own Class and TestClass</li>
<li>and one main class should call each method</li>
</ul>
<p>they need to check out, make changes, refresh &amp; sync &amp; test locally, then push and run the build.</p>
<p>then deploy to production.</p>
<p>what about breaking and backing out? reverting?</p>
<p>will need XWindows working for Jenkins and Artifactory and the final application result.</p>
<p>=======================</p>
<p>Future:</p>
<p>lab 6: Nagios monitoring</p>
<p>Lab 7: Jira &amp; collab</p>
<p>Lab 8: Project mgmt</p>
<p>Lab 9: ITSM</p>
<p>Lab 10: ITSM?</p>
<p>Lab 11: Portfolio</p>
<p>Lab 12: Performance? Simulated outage?</p>