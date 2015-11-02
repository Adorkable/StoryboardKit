#!/bin/sh

if [ $3 == '1' ]
then
	branch=$(git rev-parse --abbrev-ref HEAD)
	if [[ $branch == release/* ]]
	then
		if [[ $branch =~ release/([0-9.]*)$ ]]
		then
			version=${BASH_REMATCH[1]}
		else
			exit 0
		fi
	fi
fi

root='../'

plistFiles=("StoryboardKit/Info.plist")
podspecFile="StoryboardKit.podspec"

echo "Set Version to $version, using root $root"

function updatePlist()
{
	if [ -z "$1" ]
	then
		echo "updatePlist() expects a version for first parameter" >&2
		return -1
	fi
	version=$1

	if [ -z "$2" ]
	then
		echo "updatePlist() expects a file name for second parameter" >&2
		return -1
	fi
	plistFile=$2

	# TODO: support both PlistBuddy and plutil, test for which available
	#PlistBuddy "$2" Set "CFBundleShortVersionString" "$1"
	if plutil -replace "CFBundleShortVersionString" -string "$version" "$root/$plistFile"
	then
		echo "Updated plist file $plistFile to version $version"
	else
		return -1
	fi

	return 0
}

function updatePlists() {
	if [ -z "$1" ]
	then
		echo "updatePlists() expects a version for first parameter"
		return -1
	fi
	version=$1

	if [ -z ="$2" ]
	then
		echo "updatePlists() expects a list of PList files for second parameter"
		return -1
	fi
	plistFiles=$2

	for plistFile in ${plistFiles[@]}
	do
		if !(updatePlist "$version" "$plistFile")
		then
			echo "Error while updatingPlist($version, $plistFile)" >&2
			exit -1
		fi
	done
}

function updatePodspec()
{
	if [ -z "$1" ]
	then
		echo "updatePodspec() expects a version for first parameter"
		return -1
	fi
	version=$1

	if [ -z ="$2" ]
	then
		echo "updatePodspec() expects a Podspec file for second parameter"
		return -1
	fi
	podspecFile=$2

	search="s/s.version      = \"[0-9.]*\"/s.version      = \"$version\"/g"
	if sed -i -e "$search" "$root/$podspecFile"
	then
		echo "Updated podspec file $podspecFile to version $version"
	else
		return -1
	fi
	return 0
}

if !(updatePlists "$version" "$plistFiles")
then
	echo "Error while updatePlists($version, $plistFiles)" >&2
	exit -1
fi

if !(updatePodspec "$version" "$podspecFile")
then
	echo "Error while updatePodspec($version, $podspecFile)" >&2
	exit -1
fi
