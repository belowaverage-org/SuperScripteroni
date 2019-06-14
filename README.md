<p align="center">
  <img height="150" src="https://raw.githubusercontent.com/belowaverage-org/SuperScripteroni/master/images/SuperScripteroni.png">
</p>
<hr>
<h3>Super Scripteroni is a PowerShell script used to deploy software to domain joined computers via GPO. This script is meant to bypass the use of the built in software deployment GPO (Computer Configuration / Software Settings / Software installation). Super Scripteroni runs in the background via a scheduled task after Group Policies have applied. (Or whenever you configure it to run)</h3>
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
<h3>Adding the Super Scripteroni Base Script and Policies to a new GPO.</h3>
<ol>
  <li>In a GPO of your choice, under Computer Configuration / Preferences / Windows Settings / Files, copy and paste the contents of <a href="https://github.com/belowaverage-org/SuperScripteroni/blob/master/ScriptCopy.xml">ScriptCopy.xml</a> into the Group Policy Management Editor.</li>
  <li>After pasted, edit the item to point where you want your SuperScripteroni instance to be installed.</li>
</ol>
<img src="https://raw.githubusercontent.com/belowaverage-org/SuperScripteroni/master/images/ss2.png">
<img src="https://raw.githubusercontent.com/belowaverage-org/SuperScripteroni/master/images/ss1.png">
<h3>Adding a deployment to Super Scripteroni.</h3>
<ol>
  <li>In the SuperScripteroni GPO, under Computer Configuration / Preferences / Windows Settings / Files, copy and paste the contents of <a href="https://github.com/belowaverage-org/SuperScripteroni/blob/master/StandardDeploymentGPO.xml">StandardDeploymentGPO.xml</a> into the Group Policy Management Editor.</li>
  <li>After pasted, edit the file item to copy the contents of a deployment from a server to the client computer under the Deploy folder where your SuperScripteroni instance is located.</li>
</ol>
<img src="https://raw.githubusercontent.com/belowaverage-org/SuperScripteroni/master/images/gc.png">
<img src="https://raw.githubusercontent.com/belowaverage-org/SuperScripteroni/master/images/gc1.png">
<h3>Removing a deployment from Super Scripteroni.</h3>
  <p>When removing a deployment from a GPO you must remove the files policy for the deployment you are trying to remove and add a folder policy to remove the deployment to prevent the SuperScripteroni script from invoking the deployed script next time GPO is updated. For example:</p>
  <img width="500" src="https://raw.githubusercontent.com/belowaverage-org/SuperScripteroni/master/images/deletedeployment.png">
<h3>Targeting a deployment from Super Scripteroni.</h3>
<p>Targeting a deployment from Super Scripteroni requires two additional items to be in place (2 file items and 1 folder item). The <a href="https://github.com/belowaverage-org/SuperScripteroni/blob/master/TargetedDeploymentFilesGPO1.xml">first file item</a> will be set up the same as the items described in <a href="https://github.com/belowaverage-org/SuperScripteroni#adding-a-deployment-to-super-scripteroni">Adding a deployment to Super Scripteroni.</a> The <a href="https://github.com/belowaverage-org/SuperScripteroni/blob/master/TargetedDeploymentFilesGPO2.xml">second file item</a> will be a copy of the first item but set up in "Update" mode with "Apply once" disabled. The third <a href="https://github.com/belowaverage-org/SuperScripteroni/blob/master/TargetedDeploymentFoldersGPO.xml">item (folder item)</a> will point to the targeted package on the local C: drive with the action set to "Delete" with the item level targeting set opposite to the first two items. For example:</p>

<h3>Securing Super Scripteroni.</h3>
<p>Super Scripteroni runs as system (unless you edit the scheduled task otherwise); therefore, any scripts that are placed in the Deploy folder will run as system. To prevent normal users from creating their own scripts and placing them in the Deploy folder an additional policy needs to be enabled under: Computer Configuration / Policies / Windows Settings / Security Settings / File System</p>
<img src="https://raw.githubusercontent.com/belowaverage-org/SuperScripteroni/master/images/gposecurity.png">
<p>Since both the scheduled task for Super Scripteroni and the GPO Client service run as system, the GPO needs to allow full control to system (already set by default when adding this folder) and deny normal users access to the folder (remove from the list).</p>
