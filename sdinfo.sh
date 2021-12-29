#!/usr/bin/env bash
# (c) 24 December 2021 All rights reserved OneOfTheInfiniteMonkeys
#
# SD Card Information - SDInfo
#---------------------------------------

#--------><--------><--------><--------><--------><--------><--------><-------->
# Author           : OneOfTheInfinteMonkeys
# Revision         : 0.1
# Date             : 24 Dec 2021
# License          : MIT
#------------------:
# Comments         : Recover Raspberry Pi SD Card information from the SD Card 
#                  : CID
#                  :
# Comments         :
#                  : Original source location :
#                  : https://github.com/OneOfTheInfiniteMonkeys/sdinfo
#                  :
#                  : Searches for a file CID in the default location
#                  :
#------------------:
# Requires         : Intended for Raspberry PiOS or similar
#--------------------------------------------------------------------------------
#

#---------------------------------------
readonly App_version="00.10"                      # Version
readonly App_rel_date="2021-12-24"                # Release date
readonly App_rel_time="00:00"                     # Release time
readonly App_Name="SDInfo"                        # Default application name

#--------------------------------------


#---------------------------------------
# Colour Constants using setaf function
#---------------------------------------
# black     COLOR_BLACK       0     0, 0, 0
# red       COLOR_RED         1     max,0,0
# green     COLOR_GREEN       2     0,max,0
# yellow    COLOR_YELLOW      3     max,max,0
# blue      COLOR_BLUE        4     0,0,max
# magenta   COLOR_MAGENTA     5     max,0,max
# cyan      COLOR_CYAN        6     0,max,max
# white     COLOR_WHITE       7     max,max,max

# The format of color coding below permits use of colour codes via printf "%s" $COL_StdText
COL_Logo=""
#COL_StdText=""
#COL_MnuText=""
#COL_WhiteText=""
#COL_RedText=""
#COL_Tck=""
#COL_Crs=""
#COL_Spinner=""

COL_Logo=$(tput setaf 3)                 # Yellow
#COL_StdText=$(tput setaf 5)              # Magenta
#COL_MnuText=$(tput setaf 5)              # Magenta
#COL_WhiteText=$(tput setaf 7)            # Bright White
#COL_RedText=$(tput setaf 1)              # Bright Red
#COL_Tck=$(tput setaf 2)                  # Bright Green
#COL_Crs=$(tput setaf 1)                  # Bright Red
#COL_Spinner=$(tput setaf 6)              # Cyan

#---------------------------------------
# Set defaults for any Command Line Parameters
#---------------------------------------
cmd_additional="n"                                # Don't output additional detection information
cmd_minimal="n"                                   # Install all needed and optional pacakges for fully featured installation
cmd_cidsrc="/"                                    # Default path to start seaching for CID - reduces potential miss hits
cmd_extcid=""

#---------------------------------------
# Process Command Line Parameters
#---------------------------------------
PROG=${0##*/}                                     # Get script name to reporting in help as script may be adapted for other installs
# Now see if a cry for 'help' was issued giving it absolute priority, even if other paramters were passed
while [[ $# -gt 0 ]]; do
    case "$1" in
        -a|--additional)
            printf "      - Additional information will be output\n"
            cmd_additional="y"
            ;;
        -c|--cid)
		    tmp=$2
		    if [[ ${#tmp} -lt 32 ]] ; then
			  printf "Supplied CID too short\n"
			  exit 1
			fi
		    if [[ ${#tmp} -gt 33 ]] ; then
			  printf "Supplied CID too long\n"
			  exit 1
			fi
			tmp=""
		    cmd_extcid=$2
			;;
        -m|--minimal)
            # Minimal output infomation. i.e. No banners or other messages
            cmd_minimal="y"
            ;;
        -s|--sourcepath)
 		    if [ -d "$2" ] ; then
		      printf "Directory %s \n" "$2"
			  cmd_cidsrc="$2"  
			else 
			  printf "Unable to locate folder\n"
              exit 1			
		    fi
            ;;
        -v|--version)
            printf "      %s %s %s ( %s %s ) \n" "$App_Name" "$PROG" "$App_version" "$App_rel_date" "$App_rel_time"
            exit 0
            ;;
        -h|--help|-?)
            printf " Usage: %s [OPTION...] [COMMAND]...\n" "$PROG"
            printf " Options:\n"
            printf "   -a, --additional       Output additional information during operation\n"
            printf "   -m, --minimal          Only minimal ouptut from the script.\n"
            printf "                            i.e. No banners or other messages.\n"
            printf " Commands:\n"
            printf "   -h, --help, -?         Displays this help and exits\n"
            printf "   -v, --version          Displays output version and exits\n"
            printf " Examples:\n"
            printf "   %s -h \n" "$PROG"
            printf "   %s -a \n" "$PROG"
			printf "   %s -c 1b534d454332515430615763c7013633" "$PROG"
            printf "\n\n"
			printf " Sample Output                Decoded\n"
			printf "    MID : Samsung           - Manufacturer name\n"
			printf "    OID : SM                - OEM identifier\n"
			printf "    PNM : EC2QT             - Part Name\n"
			printf "    PRV : 30                - Part revision\n"
			printf "    PSN : 1633117127        - Product serial number\n"
			printf "    MDT : 2019/1/1          - Date yyyy/mm/dd\n"
			printf "    AID : 1092              - Age in days from MDT\n"
            printf "\n\n"
			printf " All data for indication only\n"
            exit 0
            ;;
        # *)
        #    printf "      - Unrecognised option\n"
        #    exit 0
        #    ;;
    esac # End of case
    shift
done # End of While command line options


#---------------------------------------
function Logo() {
# Prints the Logo to the console
#
#------------------:
# Inputs           :
#                  : None
#------------------:
# Ouputs           :
#                  : None
#------------------:
# Globals          :
#                  : $COL_Logo,  $COL_WhiteText, $App_Name, ${App_rel_date}
#------------------:

  printf "%s" "$COL_Logo"
  printf "\n"
  printf "       ___________________  \n"
  printf "      |                   | \n"
  printf "      | |               ==| \n"
  printf "      | |               ==| \n"
  printf "      | |  %s" "$COL_WhiteText"
  printf "%-.15s" " $App_Name      "
  printf "%s==| \n" "$COL_Logo"
  printf "      | |   %s  ==| \n" "${App_rel_date}"
  printf "      | |               ==| \n"
  printf "      | |       __    ____| \n"
  printf "      |________/  |__/      \n"
  printf "\n"
}


#--------><--------><--------><-------->
# Output Install Logo to the terminal
if [[ $cmd_minimal = "n" ]] ; then
  Logo

  printf " - All data for indication only !"
  printf "\r                                  "
  printf "\n"

fi  

if [[ $cmd_extcid = "" ]]; then 
  cidpath=$(find "$cmd_cidsrc" -name "cid" -print 2>/dev/null)
  cidinfo=$(cat "$cidpath")
else
  cidpath="/"
  cidinfo=$cmd_extcid
fi  

if [[ $cidpath == "" ]]; then
  # Appears as if there is no SD
  printf "No CID file located for an SD card.\n"
  printf " - Possibly there is no SD card or the code\n"
  printf "   was unable to identify a suitable entry.\n"
  exit 1
fi


if [[ $cmd_additional = "y" ]]; then
  # Output located path and CID detected
  printf "PTH : %s \n" "$cidpath"
  printf "CID : %s \n" "$cidinfo"
  printf "\n"
fi

if [[ ${#cidinfo} -lt 32  ]] ; then 
  # we expect something like 1b534d454332515430615763c7013633
  printf "No or invalid CID content\n"
  printf "%s \n" "$cidinfo"
  exit 2
fi

# Decode CID
# example               1b534d454332515430615763c7013633
#                       1b 534d 4543325154 30 615763c7 0136 33
mid=${cidinfo:0:2} #     2 chars - 1 byte   - Unique manufacturer identifier
oid=${cidinfo:2:4} #     4 chars - 2 bytes  - Manf. card type identifier
pnm=${cidinfo:6:10} #   10 chars - 5 bytes  - Manf. Part name
prv=${cidinfo:16:2} #    2 chars - 1 bytes  - Manf. Version (BCD)
psn=${cidinfo:18:8} #    8 chars - 4 bytes  - Manf. Serial No. 32 bit uint
mdt=${cidinfo:27:3} #    3 chars - 1.5 byte - Manf. Date - 12 bits - BCD YYM (YY + 2000)
crc=${cidinfo:30:2} #    2 chars - 1 byte   - Data CRC - 7 bits (LSB always 1 i.e. odd)
#((mdt&=4095))       #    Limit MDT to 12 bits

if [[ $cmd_additional = "y" ]]; then
  # output raw infromation from CID
  printf "MID : %s\n" "$mid"
  printf "OID : %s\n" "$oid"
  printf "PNM : %s\n" "$pnm"
  printf "PRV : %s\n" "$prv"
  printf "PSN : %s\n" "$psn"
  printf "MDT : %s\n" "$mdt"
  printf "CRC : %s\n" "$crc"
  printf "\n"
fi

# The principle applied is source identified as manufacturer where possible,
# which may not match marking see www.bunniestudios.com/blog/?page_id=1022
# Sources - Manufacturers data sheets, some SD cards, 
# Cross checked with a number of sources in addition (in no specific order):
# elinux.org/RPi_SD_cards github.com/kbiva/stm32f103_projects https://goughlui.com/ www.cameramemeoryspeed.com 
d_mid='' #                                        Decoded primary brand
d_mid_id='' #                                     2 character ID
d_mid_aka='' #                                    Decoded - Also Known As
case $mid in
  '01')
    d_mid='Panasonic'
	d_mid_id='PA'
	;;
  '02')
    d_mid='Toshiba'
	d_mid_id='TM'
	d_mid_aka='Kingston'
	;;
  '03')
    d_mid='Sandisk'
    d_mid_id='SD'
	;;
  '06')
    d_mid='Ritek'
    d_mid_id='RK'
	;;
  '09')
    d_mid='ATP'
    d_mid_id='AT'
	;;
  '12')
    d_mid='Shenzen Market'
    d_mid_id='??'
	d_mid_aka='Many brands'
	;;
  '13')
    d_mid='Kingmax'
    d_mid_id='KG'
	;;
  '19')
    d_mid='Dynacard'
    d_mid_id='DY'
	;;
  '1a')
    d_mid='PQI'
    d_mid_id='PQ'
	;;
  '1b')
    d_mid='Samsung'
    d_mid_id='SM'
	d_mid_aka=''
	;;
  '1d')
    d_mid='Adata'
    d_mid_id='AD'
	d_mid_aka=''
	;;
  '27')
    d_mid='Phison'
    d_mid_id='20'
	d_mid_aka='7DAYSHOP, AgfaPhoto, Delkin, Emtec, Flexon, HIDISC, Integral, Lexar, Medion, Patriot, Philips, Polariod, Promaster, Sony, Verbatim'
	;;
  '28')
    d_mid='Lexar'
    d_mid_id='BE'
	d_mid_aka='PNY, ProGrade'
	;;
  '30')
    d_mid='Sandisk'
    d_mid_id='SD'
	;;
  '31')
    d_mid='Silicon Power'
    d_mid_id='SP'
	;;
  '41')
    d_mid='Kingston'
    d_mid_id='SP'
	;;
  '5d')
    d_mid='Swissbit'
    d_mid_id='SB'
	;;
  '61')
    d_mid='Netlist'
    d_mid_id='NL'
	;;
  '63')
    d_mid='Cactus'
    d_mid_id='CL'
	;;
  '6f')
    d_mid='Plantinum'
    d_mid_id='PL'
	;;
  '73')
    d_mid='Fuji'
    d_mid_id='FJ'
	;;
  '74')
    d_mid='Jialec'
    d_mid_id='JE'
	d_mid_aka='Transcend'
	;;
  '76')
    d_mid='Patriot'
    d_mid_id='PA'
	;;
  '82')
    d_mid='Sony'
    d_mid_id='JT'
	d_mid_aka='Jangtay'
	;;
  '83')
    d_mid='Netcom'
    d_mid_id='NC'
	;;
  '84')
    d_mid='Strontium'
    d_mid_id='ST'
	;;
  '88')
    d_mid='Pretec'
    d_mid_id='0x03 0x02'
	;;
  '89')
    d_mid='MemoryStar'
    d_mid_id='JT'
	d_mid_aka="Team"
	;;
  '92')
    d_mid='Sony'
    d_mid_id='JT'
	d_mid_aka='Gobe'
	;;
  '9c')
    d_mid='Anglebird'
    d_mid_id='BE'
	d_mid_aka='Hoodman'
	;;
  '9f')
    d_mid='Blackweb'
    d_mid_id='BW'
	;;
	
  *)
    d_mid='unknown'
	d_mid_id='XX' 
	d_mid_aka=''
	;;
esac

# Decode the OEM ID a two character ASCII code frm the two hex OID bytes
d_oid=""
if [[ $((16#${oid:0:2})) -lt 32 ]] || [[ $((16#${pnm:2:2})) -lt 32 ]] ; then
  d_oid=$((16#${oid:0:2}))$((16#${oid:2:2}))
else
  d_oid=$(printf "%s" "0x${oid:0:2}.0x${oid:2:2}" | xxd -r)
fi  

# Decode the Part Name from hex to decimal
d_pnm=""
d_pnm=$(printf "%s" "0x${pnm:0:2}.0x${pnm:2:2}.0x${pnm:4:2}.0x${pnm:6:2}.0x${pnm:8:2}" | xxd -r)

d_prv=""
d_prv=$prv

# Decode the part serial number from Hex to Integer
d_psn=""
d_psn=$((16#$psn))

# Decode the manufactured date contained within the CID string
d_mdt=""
d_mdt=$((16#${mdt:0:2})) #                          Extract the year from the CID
d_mdt=$((d_mdt + 2000))  #                          Add the centry offset of 2000
if [[ $d_mdt -gt $(date +%Y) ]] ; then  #           Probable date coding error - not to SD format rules
  d_mdt=2000
fi

d_mdm=$((16#${mdt:2:1})) #                          Extract the month 
if [[ $d_mdm -gt 12 ]] || [[ $d_mdm = 0 ]]; then #  Probable date coding error - not to SD format rules
  d_mdm=1
fi 

d_mdt=$d_mdt"/"$d_mdm #                             Concatenate Year and month with sperator
# Calculate approximate number of days - assume 1st of month
d_ndy=$(( ($(date +%s ) - $(date --date="$d_mdt"/1 +%s)) / (86400)  )) # 


# Output the decoded data
printf "MID : %s\n" "$d_mid"
if [[ $d_mid_aka -gt '' ]] ; then
  if [[ $cmd_additional = "y" ]] ; then
    printf "AKA : %s\n" "$d_mid_aka"
  fi	 
fi
printf "OID : %s\n" "$d_oid"
if [[ $cmd_additional = "y" ]] ; then
  if [[ $d_mid_id = "$d_oid" ]] ; then
    printf "IDC : Match\n"
  fi
fi
printf "PNM : %s\n" "$d_pnm"
printf "PRV : %s\n" "$d_prv"
printf "PSN : %s\n" "$d_psn"
if [[ $cmd_minimal = "n" ]] ; then
  printf "MDT : %s\n" "$d_mdt/1"
else
  printf "MDT : %s\n" "$d_mdt"
fi  
if [[ $cmd_minimal = "n" ]] ; then
  printf "AID : %s\n" "$d_ndy"
fi  
printf "\n"

