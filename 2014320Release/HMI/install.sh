#!/bin/sh

APPS="/apps"
appPpsObject="/pps/system/navigator/applications/applications"

INSTALLER=$1
INSTALLER_DIR=$(cd "$(dirname "$1")"; pwd)
CURRENT_DIR=$(cd "$(dirname "$0")"; pwd)
NAVIINSTALLER_DIR="$INSTALLER_DIR/.navigation_install.$$"

APPLICATION_NAME=navigation
NATIVEDATA_DIR=/koteinavidata
APPLICATION_DIR=`cat $appPpsObject | grep "^$APPLICATION_NAME\." 2> /dev/null | sed 's/:.*//'`
FULLAPPLICATION_DIR="$APPS"/"$APPLICATION_DIR"/native

NAVIGATOR_NAME=Navigator
NAVIGATOR_DIR=`cat $appPpsObject | grep "^$NAVIGATOR_NAME\." 2> /dev/null | sed 's/:.*//'`
NAVIGATORRESOURCE_DIR='/apps/common/themes/default/Navigator/1280x720/img'
FULLNAVIGATOR_DIR="$APPS"/"$NAVIGATOR_DIR"/native
FULLNAVIGATOR_BAK_DIR="$APPS"/"$NAVIGATOR_DIR"/native_bak
NEWNAVIGATOR_DIR="$NAVIINSTALLER_DIR"/Navigator


# delete current derectory
function removeInstallDir
{
    if [ -d $NAVIINSTALLER_DIR ]; then
        rm -rf $NAVIINSTALLER_DIR || exit $?
    else 
        echo "Warning: Delete [$NAVIINSTALLER_DIR] failed !!!" >&2
    fi
    return 0
}


# Modify Navigator
function BackUpNavigator
{
	if ! [ -d $FULLNAVIGATOR_BAK_DIR ]; then
		mkdir $FULLNAVIGATOR_BAK_DIR
		if [ -d $FULLNAVIGATOR_BAK_DIR ]; then
			mkdir "$FULLNAVIGATOR_BAK_DIR"/js
			cp "$FULLNAVIGATOR_DIR"/index.html "$FULLNAVIGATOR_BAK_DIR"/index.html	
			cp -R "$FULLNAVIGATOR_DIR"/js "$FULLNAVIGATOR_BAK_DIR"

			if ! [ -d $FULLNAVIGATOR_BAK_DIR/chrome ]; then
				mkdir $FULLNAVIGATOR_BAK_DIR/chrome
				mkdir $FULLNAVIGATOR_BAK_DIR/chrome/lib
			fi
			
			if [ -d $FULLNAVIGATOR_BAK_DIR/chrome/lib ]; then
				cp $FULLNAVIGATOR_DIR/chrome/lib/webview.js $FULLNAVIGATOR_BAK_DIR/chrome/lib/webview.js 
			fi
		fi
	fi
}


# Modify Navigator
function ModifyNavigator
{
	mount -uw /base
	
	BackUpNavigator
	
	#mv "$NEWNAVIGATOR_DIR"/index.html "$FULLNAVIGATOR_DIR"/index.html
	mv "$NEWNAVIGATOR_DIR"/Applications.js "$FULLNAVIGATOR_DIR"/js/Applications.js
	#mv "$NEWNAVIGATOR_DIR"/koteinavigator.css "$FULLNAVIGATOR_DIR"/koteinavigator.css
	#mv "$NEWNAVIGATOR_DIR"/Navigator.js "$FULLNAVIGATOR_DIR"/js/Navigator.js
	#mv "$NEWNAVIGATOR_DIR"/Tabs.js "$FULLNAVIGATOR_DIR"/js/Tabs.js
	mv "$NEWNAVIGATOR_DIR"/chrome/lib/webview.js "$FULLNAVIGATOR_DIR"/chrome/lib/webview.js
	
	# if [ -d "$NEWNAVIGATOR_DIR"/resourse ]; then
	# 	for image in `ls "$NEWNAVIGATOR_DIR"/resourse`
	# 	do
	# 		mv "$NEWNAVIGATOR_DIR"/resourse/$image "$NAVIGATORRESOURCE_DIR"/$image
	# 		echo "Moving $NEWNAVIGATOR_DIR"/resourse/$image to "$NAVIGATORRESOURCE_DIR"/$image
	# 	done
	# fi
	
   	return 0
}

function ResetNavigator
{
	if [ -d $FULLNAVIGATOR_BAK_DIR ]; then 
		rm -f $FULLNAVIGATOR_DIR/chrome/lib/webview.js
		cp -f $FULLNAVIGATOR_BAK_DIR/chrome/lib/webview.js $FULLNAVIGATOR_DIR/chrome/lib/webview.js 
		#rm -rf "$FULLNAVIGATOR_BAK_DIR"/index.html
		#cp -f "$FULLNAVIGATOR_DIR"/index.html "$FULLNAVIGATOR_BAK_DIR"/index.html
		rm -rf "$FULLNAVIGATOR_DIR"/native/js	
		cp -R "$FULLNAVIGATOR_BAK_DIR"/js "$FULLNAVIGATOR_DIR"
	else
		echo "ResetNavigator Failed!!"  >&2
	fi
	
	if [ -f "$FULLNAVIGATOR_DIR"/koteinavigator.css ]; then 
		rm -rf "$NEWNAVIGATOR_DIR"/koteinavigator.css
	fi

   	return 0	
}

function UpdateNavigationData
{
	if [ -d $NAVIINSTALLER_DIR/Data ]; then 
		if [ -d $NAVIINSTALLER_DIR/Data/Config ]; then
			rm -rf $NATIVEDATA_DIR/Data/Config > /dev/null
			mv $NAVIINSTALLER_DIR/Data/Config $NATIVEDATA_DIR/Data/Config
		fi

		if [ -d $NAVIINSTALLER_DIR/Data/Font ]; then
			rm -rf $NATIVEDATA_DIR/Data/Font > /dev/null
			mv $NAVIINSTALLER_DIR/Data/Font $NATIVEDATA_DIR/Data/Font
		fi

		if [ -d $NAVIINSTALLER_DIR/Data/Hdr ]; then
			rm -rf $NATIVEDATA_DIR/Data/Hdr > /dev/null
			mv $NAVIINSTALLER_DIR/Data/Hdr $NATIVEDATA_DIR/Data/Hdr
		fi

		if [ -d $NAVIINSTALLER_DIR/Data/GUD ]; then
			rm -rf $NATIVEDATA_DIR/Data/GUD > /dev/null
			mv $NAVIINSTALLER_DIR/Data/GUD $NATIVEDATA_DIR/Data/GUD
		fi

		if [ -d $NAVIINSTALLER_DIR/Data/Locator ]; then
			rm -rf $NATIVEDATA_DIR/Data/Locator > /dev/null
			mv $NAVIINSTALLER_DIR/Data/Locator $NATIVEDATA_DIR/Data/Locator
		fi

		if [ -d $NAVIINSTALLER_DIR/Data/MD ]; then
			rm -rf $NATIVEDATA_DIR/Data/MD > /dev/null
			mv $NAVIINSTALLER_DIR/Data/MD $NATIVEDATA_DIR/Data/MD
		fi

		if [ -d $NAVIINSTALLER_DIR/Data/VICS ]; then
			rm -rf $NATIVEDATA_DIR/Data/VICS > /dev/null
			mv $NAVIINSTALLER_DIR/Data/VICS $NATIVEDATA_DIR/Data/VICS
		fi

		if [ -f $NAVIINSTALLER_DIR/Data/qt.ini ]; then
			rm -rf $NATIVEDATA_DIR/Data/qt.ini > /dev/null
			mv $NAVIINSTALLER_DIR/Data/qt.ini $NATIVEDATA_DIR/Data/qt.ini
		fi

		if [ -f $NAVIINSTALLER_DIR/Data/MeshCodeTable.dat ]; then
			rm -rf $NATIVEDATA_DIR/Data/MeshCodeTable.dat > /dev/null
			mv $NAVIINSTALLER_DIR/Data/MeshCodeTable.dat $NATIVEDATA_DIR/Data/MeshCodeTable.dat
		fi		

		echo "Data was updated !"  >&2	
	else
		echo "Data was not updated !"  >&2
	fi	
}

function InstallNativeNavigation
{
	if [ ! -d $NATIVEDATA_DIR ]; then
		 mkdir $NATIVEDATA_DIR
	fi

	if [ ! -d $NATIVEDATA_DIR/Data ]; then
		mv $NAVIINSTALLER_DIR/Data $NATIVEDATA_DIR/Data
	else
		UpdateNavigationData
	fi	

	# DataBase 
	if [ -d $NAVIINSTALLER_DIR/db ]; then
		mv $NAVIINSTALLER_DIR/db/navigation.sql /var/tmp/db/navigation.sql
		mv $NAVIINSTALLER_DIR/db/navigation.db	/var/tmp/db/navigation.db
	fi

	# Auto Run 
	mount -uw /base	
	# if [ -d $NAVIINSTALLER_DIR/System ]; then
		# mv $NAVIINSTALLER_DIR/System/ebnav-start.sh /base/scripts/ebnav-start.sh
		# chmod 755	/base/scripts/ebnav-start.sh
		# mv $NAVIINSTALLER_DIR/System/services-enabled	/var/etc/services-enabled
		# chmod 755	/var/etc/services-enabled		
		# mv $NAVIINSTALLER_DIR/System/tablist.json	/base/usr/hmi/common/js/tablist.json
		# chmod 755	/base/usr/hmi/common/js/tablist.json
	# fi

	# Create PPS Dir
	if [ ! -d /pps ]; then
		mkdir -p /pps
	fi
	
	if [ ! -d /pps/kotei ]; then
		mkdir -p /pps/kotei
	fi
	
	if [ ! -d /pps/kotei/navigation ]; then
		mkdir -p /pps/kotei/navigation
	fi
	
	touch /pps/kotei/navigation/poi
	touch /pps/kotei/navigation/md
	touch /pps/kotei/navigation/status
	touch /pps/kotei/navigation/info
	touch /pps/kotei/navigation/windowgroup	
	chmod -R 777 /pps/kotei
	
	# Copy Font
	cp /koteinavidata/Data/Font/ipagp.ttf   /base/usr/fonts/font_repository/monotype/

	mv "$NAVIINSTALLER_DIR"/navigation_car2 /navigation_car2
	chmod 755 /navigation_car2					 
}

function InstallNavigationHtml
{
	echo uninstall "$APPLICATION_NAME"...
	#scripts/bar-uninstall "$APPLICATION_NAME"

	echo install "$APPLICATION_NAME" Html ...
	#/scripts/bar-install "$NAVIINSTALLER_DIR"/2.1/"$APPLICATION_NAME".bar

}

function InstallNavigation
{
	#InstallNavigationHtml	

	InstallNativeNavigation

	return 0
}


function UnzipInstaller
{
	mkdir "${NAVIINSTALLER_DIR:?}"
	if ! unzip $INSTALLER_DIR/navigation -d "${NAVIINSTALLER_DIR:?}"
	then
		echo "Unzip failed" >&2
		exit 1
	fi
}

# Main


#Insatll HTML

if [ "$1" = "-ModifyNavigator" ]; then
	echo ModifyNavigator
	#ModifyNavigator
elif [ "$1" = "-ResetNavigator" ]; then
	echo ResetNavigator
	ResetNavigator
elif [ "$1" = "-help" ]; then
	echo "-ModifyNavigator: Modify Navigator to run full screen navigation"
	echo "-ResetNavigator: Reset Navigator!"
	echo "path/to/navigation.zip: install navigation."
else
	UnzipInstaller
	InstallNavigation
	# ModifyNavigator
	removeInstallDir
fi

echo Done!
