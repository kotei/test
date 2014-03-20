#!/bin/sh

APPS="/apps"
appPpsObject="/pps/system/navigator/applications/applications"
CURRENT_DIR=$(cd "$(dirname "$0")"; pwd)
NATIVEDATA_DIR=/koteinavidata
NaviService=/navigation_car2

APPLICATION_ID=mininavi
RunParam=$2
WebViewID=$2
APPLICATION_NAME="";

FULLID=`cat $appPpsObject | grep "^$APPLICATION_ID\." 2> /dev/null | sed 's/:.*//'`
FULLAPPLICATION_DIR="$APPS"/"$FULLID"/native
Command=""


function RunNaviService
{
	#echo "========================== navi start shell running..."
	cd "$NATIVEDATA_DIR" 
	chmod 755 $NaviService
	/navigation_car2
}


function RunHtml 
{
	if [ "$RunParam" = "Float" ]; then
		echo "Start App in a new WebView"
		echo "msg::start\ndat::$FULLID\n id::$APPLICATION_ID" > /pps/services/launcher/control  		
	else
		echo "Start App in App Section...."
		echo req:json:\{\"id\":\"$APPLICATION_NAME\",\"cmd\":\"launch app\",\"app\":\"$APPLICATION_NAME\",\"dat\":\"\"\} >> /pps/services/app-launcher        
	fi
}


#Main

if [ "$APPLICATION_ID" = "navi" ]; then
	echo "$APPLICATION_ID is Runing..." 
	APPLICATION_NAME="Navi"
	RunNaviService & RunHtml $APPLICATION_ID $RunParam

elif [ "$APPLICATION_ID" = "mininavi" ]; then
	echo "$APPLICATION_ID is Runing..."
	APPLICATION_NAME="MiniNavi"

	RunNaviService & RunHtml $APPLICATION_ID $RunParam 
	 
else
	echo "Error: Error ID !!!" >&2
fi


