<h1 align="center">Super Scripteroni</h1>
<h3>A PowerShell script to deploy software to domain joined computers via GPO. This script is meant to bypass the use of the built in software deployment GPO. Super Scripteroni runs in the background via a scheduled task after Group Policies have applied.</h3>
<h2>How does Super Scripteroni Work?</h2>
<h3>Super Scripteroni Folder Tree</h3>
<img src="https://raw.githubusercontent.com/belowaverage-org/SuperScripteroni/master/images/filetree.bmp">
<h3><a href="https://github.com/belowaverage-org/SuperScripteroni/blob/master/SuperScripteroni.ps1">SuperScripteroni.ps1</a></h3>
<ol>
  <li>Group policies apply.</li>
  <li>Scheduled task starts SuperScripteroni.ps1.</li>
  <li>SuperScripteroni.ps1 searches the "Deploy" directory and sub-directories as shown above for any *.ps1 files.</li>
  <li>SuperScripteroni.ps1 runs each *.ps1 file found in the directories they are found in. (<a href="https://en.wikipedia.org/wiki/Working_directory">Working Directory</a>)</li>
  <li>SuperScripteroni.ps1 writes the PowerShell output to an event in the Applications event log.</li>
</ol>
<p>Because of the way the SuperScripteroni.ps1 script works, each deployment script will need to perform the nessesary checks to see if the application that is to be deployed already exists to prevent duplicate installs. See <a href="https://github.com/belowaverage-org/SuperScripteroni/blob/master/ChromeInstall.ps1">ChromeInstall.ps1</a> for an example.</p>
<h2>How do I set up the Group Policy for Super Scripteroni?</h2>
<ol>
  <li>In a GPO of your choice, under Computer Configuration / Preferences / Windows Settings / Files, copy and paste the contents of <a href="https://github.com/belowaverage-org/SuperScripteroni/blob/master/ScriptCopy.xml">ScriptCopy.xml</a> into the Group Policy Management Editor.</li>
</ol>
