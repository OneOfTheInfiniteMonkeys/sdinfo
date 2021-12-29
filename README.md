# sdinfo
<a href="https://en.wikipedia.org/wiki/SD_card">Micro SD Card</a> Information in PiOS BASH  
With many devices and cards this utility eases card identification and maintenance, as the Micro SD card may be difficult to access. The utility also provides an estimate of the cards age from the manufacturing date to facilitate management based on age if desired.  

![GitHub release (latest SemVer including pre-releases)](https://img.shields.io/github/v/release/OneOfTheInfiniteMonkeys/sdinfo?include_prereleases)
[![Build Status](https://app.travis-ci.com/OneOfTheInfiniteMonkeys/sdinfo.svg?branch=main)](https://travis-ci.com/github/OneOfTheInfiniteMonkeys/sdinfo)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://github.com/OneOfTheInfiniteMonkeys/sdinfo/graphs/commit-activity)
![GitHub](https://img.shields.io/github/license/OneOftheinfinitemonkeys/sdinfo)
![GitHub repo size](https://img.shields.io/github/repo-size/OneOfTheInfiniteMonkeys/sdinfo)
[![made-with-bash](https://img.shields.io/badge/-Made%20with%20Bash-1f425f.svg?logo=image%2Fpng%3Bbase64%2CiVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyZpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw%2FeHBhY2tldCBiZWdpbj0i77u%2FIiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8%2BIDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuNi1jMTExIDc5LjE1ODMyNSwgMjAxNS8wOS8xMC0wMToxMDoyMCAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENDIDIwMTUgKFdpbmRvd3MpIiB4bXBNTTpJbnN0YW5jZUlEPSJ4bXAuaWlkOkE3MDg2QTAyQUZCMzExRTVBMkQxRDMzMkJDMUQ4RDk3IiB4bXBNTTpEb2N1bWVudElEPSJ4bXAuZGlkOkE3MDg2QTAzQUZCMzExRTVBMkQxRDMzMkJDMUQ4RDk3Ij4gPHhtcE1NOkRlcml2ZWRGcm9tIHN0UmVmOmluc3RhbmNlSUQ9InhtcC5paWQ6QTcwODZBMDBBRkIzMTFFNUEyRDFEMzMyQkMxRDhEOTciIHN0UmVmOmRvY3VtZW50SUQ9InhtcC5kaWQ6QTcwODZBMDFBRkIzMTFFNUEyRDFEMzMyQkMxRDhEOTciLz4gPC9yZGY6RGVzY3JpcHRpb24%2BIDwvcmRmOlJERj4gPC94OnhtcG1ldGE%2BIDw%2FeHBhY2tldCBlbmQ9InIiPz6lm45hAAADkklEQVR42qyVa0yTVxzGn7d9Wy03MS2ii8s%2BeokYNQSVhCzOjXZOFNF4jx%2BMRmPUMEUEqVG36jo2thizLSQSMd4N8ZoQ8RKjJtooaCpK6ZoCtRXKpRempbTv5ey83bhkAUphz8fznvP8znn%2B%2F3NeEEJgNBoRRSmz0ub%2FfuxEacBg%2FDmYtiCjgo5NG2mBXq%2BH5I1ogMRk9Zbd%2BQU2e1ML6VPLOyf5tvBQ8yT1lG10imxsABm7SLs898GTpyYynEzP60hO3trHDKvMigUwdeaceacqzp7nOI4n0SSIIjl36ao4Z356OV07fSQAk6xJ3XGg%2BLCr1d1OYlVHp4eUHPnerU79ZA%2F1kuv1JQMAg%2BE4O2P23EumF3VkvHprsZKMzKwbRUXFEyTvSIEmTVbrysp%2BWr8wfQHGK6WChVa3bKUmdWou%2BjpArdGkzZ41c1zG%2Fu5uGH4swzd561F%2BuhIT4%2BLnSuPsv9%2BJKIpjNr9dXYOyk7%2FBZrcjIT4eCnoKgedJP4BEqhG77E3NKP31FO7cfQA5K0dSYuLgz2TwCWJSOBzG6crzKK%2BohNfni%2Bx6OMUMMNe%2Fgf7ocbw0v0acKg6J8Ql0q%2BT%2FAXR5PNi5dz9c71upuQqCKFAD%2BYhrZLEAmpodaHO3Qy6TI3NhBpbrshGtOWKOSMYwYGQM8nJzoFJNxP2HjyIQho4PewK6hBktoDcUwtIln4PjOWzflQ%2Be5yl0yCCYgYikTclGlxadio%2BBQCSiW1UXoVGrKYwH4RgMrjU1HAB4vR6LzWYfFUCKxfS8Ftk5qxHoCUQAUkRJaSEokkV6Y%2F%2BJUOC4hn6A39NVXVBYeNP8piH6HeA4fPbpdBQV5KOx0QaL1YppX3Jgk0TwH2Vg6S3u%2BdB91%2B%2FpuNYPYFl5uP5V7ZqvsrX7jxqMXR6ff3gCQSTzFI0a1TX3wIs8ul%2Bq4HuWAAiM39vhOuR1O1fQ2gT%2F26Z8Z5vrl2OHi9OXZn995nLV9aFfS6UC9JeJPfuK0NBohWpCHMSAAsFe74WWP%2BvT25wtP9Bpob6uGqqyDnOtaeumjRu%2ByFu36VntK%2FPA5umTJeUtPWZSU9BCgud661odVp3DZtkc7AnYR33RRC708PrVi1larW7XwZIjLnd7R6SgSqWSNjU1B3F72pz5TZbXmX5vV81Yb7Lg7XT%2FUXriu8XLVqw6c6XqWnBKiiYU%2BMt3wWF7u7i91XlSEITwSAZ%2FCzAAHsJVbwXYFFEAAAAASUVORK5CYII%3D)](https://www.gnu.org/software/bash/)
![Raspberry Pi](https://img.shields.io/badge/gadget-Raspberry%20Pi-C51A4A.svg?logo=data%3Aimage%2Fsvg%2Bxml%3Bbase64%2CPHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI0MCIgaGVpZ2h0PSI0MCIgdmlld0JveD0iMTIgMTIgNDAgNDAiPjxwYXRoIGZpbGw9IiMzMzMzMzMiIGQ9Ik0zMiwxMy40Yy0xMC41LDAtMTksOC41LTE5LDE5YzAsOC40LDUuNSwxNS41LDEzLDE4YzEsMC4yLDEuMy0wLjQsMS4zLTAuOWMwLTAuNSwwLTEuNywwLTMuMiBjLTUuMywxLjEtNi40LTIuNi02LjQtMi42QzIwLDQxLjYsMTguOCw0MSwxOC44LDQxYy0xLjctMS4yLDAuMS0xLjEsMC4xLTEuMWMxLjksMC4xLDIuOSwyLDIuOSwyYzEuNywyLjksNC41LDIuMSw1LjUsMS42IGMwLjItMS4yLDAuNy0yLjEsMS4yLTIuNmMtNC4yLTAuNS04LjctMi4xLTguNy05LjRjMC0yLjEsMC43LTMuNywyLTUuMWMtMC4yLTAuNS0wLjgtMi40LDAuMi01YzAsMCwxLjYtMC41LDUuMiwyIGMxLjUtMC40LDMuMS0wLjcsNC44LTAuN2MxLjYsMCwzLjMsMC4yLDQuNywwLjdjMy42LTIuNCw1LjItMiw1LjItMmMxLDIuNiwwLjQsNC42LDAuMiw1YzEuMiwxLjMsMiwzLDIsNS4xYzAsNy4zLTQuNSw4LjktOC43LDkuNCBjMC43LDAuNiwxLjMsMS43LDEuMywzLjVjMCwyLjYsMCw0LjYsMCw1LjJjMCwwLjUsMC40LDEuMSwxLjMsMC45YzcuNS0yLjYsMTMtOS43LDEzLTE4LjFDNTEsMjEuOSw0Mi41LDEzLjQsMzIsMTMuNHoiLz48L3N2Zz4%3D)


<strong> NOTE </strong>  
  - Using the scripts -c option you can check cards from other systems.  
  - Check out the -a (additional) option for re-branded cards. If you have a card not listed. Use the scripts -a option, copy the CID text and place with a photo of the card in an issue headed <strong>'Card ID Request'</strong>.  

### Target platform
Debian - Raspberry PI

### Installation (or update)
If you don't have GIT installed, install with:  
&nbsp;&nbsp; sudo apt install git

Clone the repository to your Raspberry Pi  
e.g.  
&nbsp;&nbsp; cd ~  
&nbsp;&nbsp; sudo git clone https://github.com/OneOfTheInfiniteMonkeys/sdinfo.git  

### Running
Following installation using the steps detailed in the <strong>Installation section</strong>, a folder will have been created in your home directory which contains the <strong>sdinfo</strong> BASH script.  

To run <strong>sdinfo</strong> script enter the following commands:  
&nbsp;&nbsp; cd ~/sdinfo  
Run the script :  
&nbsp;&nbsp; bash sdinfo.sh  
The script will take some time to run as it searches for 

To test the script with an SD Card CID  
&nbsp;&nbsp; cd ~/sdinfo  
&nbsp;&nbsp; bash sdinfo.sh -c 1b534d454332515430615763c7013633  


To update  
&nbsp;&nbsp; cd ~/sdinfo  
run git  
&nbsp;&nbsp; sudo git pull  

### Typical Output
### Options
sdinfo supports the following command line parameters :  

<table>
  <tr><td>  -a, --additional  </td><td> Output additional information  </td></tr>
  <tr><td>  -m, --minimal     </td><td> Only minimal ouptut from the script.  </td></tr>
</table>

### Commands
<table>
  <tr><td>-c, --cid          </td><td> Provide a CID string to be decoded </td></tr>
  <tr><td>-s, --sourcepath   </td><td> Provide a path to the CID (faster if you know the location or have alternate locations) </td></tr>
  <tr><td>-h, --help, -?     </td><td> Displays this help and exits </td></tr>
  <tr><td>-v, --version      </td><td> Displays version information for ${App_Name} and exits </td></tr>
  <tr><td>                   </td><td> < Application Name > < Command > < Revision > ( < Date {yyyy-mm-dd} {hh:mm} > ) </td></tr>
</table>
  
### Output Explanation  
A typical output from sdinfo is shown below for a Raspberry Pi SD card:  

       ___________________
      |                   |
      | |               ==|
      | |               ==|
      | |   SDInfo      ==|
      | |   2021-12-24  ==|
      | |               ==|
      | |       __    ____|
      |________/  |__/


MID : Samsung
OID : SM
PNM : EC2QT
PRV : 30
PSN : 1633117127
MDT : 2019/1/1
AID : 1092

    
The line consists of the following information :
<table>
  <tr><td> MID </td><td> Manufacturer Identifier         </td></tr>
  <tr><td> OID </td><td> OEM Identifier                  </td></tr>
  <tr><td> PNM </td><td> Part number                     </td></tr>
  <tr><td> PRV </td><td> Part version                    </td></tr>
  <tr><td> PSN </td><td> Part serial number              </td></tr>
  <tr><td> MDT </td><td> Manufactured date yyyy/mm/01    </td></tr>
  <tr><td> AID </td><td> Age in days                     </td></tr>
  
</table>
