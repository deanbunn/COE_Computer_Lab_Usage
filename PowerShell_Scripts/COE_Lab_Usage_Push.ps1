<#
    COE_Lab_Usage_Push.ps1
#>

#Var for Lab Name
[string]$labName = "ASB 2003";

#Var for API Uniform Resource Identifier 
[string]$uri = "https://urgl220xq1.execute-api.us-west-2.amazonaws.com/v1/labusage"

#Create Custom Object for Reporting Lab Usage
$cstLabUsage = New-Object PSObject -Property (@{logged=""; workstation=""; console="0"; lab="";});

#Set Date in Specified Format
$cstLabUsage.logged = (Get-Date).ToString("MM-dd-yyyy-HH:mm:ss");

#Set Work Station Name 
$cstLabUsage.workstation = hostname;

#Set Lab Name
$cstLabUsage.lab = $labName;

#Check Console Status
$crntSysUsage = quser;

#Check System Usage
if($crntSysUsage -ne $null)
{

    if($crntSysUsage -is [array])
    {
        foreach($sysUsage in $crntSysUsage)
        {
            if($sysUsage.STATE -eq "Active" -and [string]::IsNullOrEmpty($sysUsage.SESSIONNAME) -eq $false `
               -and $sysUsage.SESSIONNAME.ToString().ToLower() -eq "console")
               {
                   $cstLabUsage.console = "1";
               }
        }
    }
    else
    {
        if($crntSysUsage.STATE -eq "Active" -and [string]::IsNullOrEmpty($crntSysUsage.SESSIONNAME) -eq $false `
           -and $crntSysUsage.SESSIONNAME.ToString().ToLower() -eq "console")
           {
                $cstLabUsage.console = "1";
           }

    }

}#End of Check System Usage


#Convert Report Object to Json Object
$jsonBody = $cstLabUsage | ConvertTo-Json;

#Make API Call to Report Lab Usage
$callStatus = Invoke-WebRequest -Uri $uri -Method POST -Body $jsonBody -ContentType "application/json";


#To See API Call Status Uncomment These Two Lines
#$callStatus.StatusCode
#$callStatus.Content