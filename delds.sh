#!/usr/bin/env zsh

# If argument is empty, use current work dir
if [ -z "$1" ]; then
	echo -e "\033[33mNo directory found, using current working directory as default ($(pwd))\033[0m"
	dir=$(pwd)
else
	dir=$1
fi

# If argument is a directory and user has writing permissions
if [ -d $dir -a -w $dir ]; then
	
	# Finds all .DS_Store in directory
	# Files is an array
	# Use of f flag to split array at line endings instead of space (For file name with space)
	# More info at https://unix.stackexchange.com/questions/29724/how-to-properly-collect-an-array-of-lines-in-zsh
	files=("${(@f)$(find $dir -name '.DS_Store')}")

	if [ -z "${files[@]:0:1}" ]; then
		files=()
	fi
	
	# For each files, print out name and hoghlight .DS_Store with grep
	# This simulate a regular find + grep
	for i in ${files[@]}; do
		echo ${i:a} | grep ".DS_Store"
	done
	
	# Choose a highlight color depending if files are found
	if (( ${#files[@]} == 0 ));then
		color="\033[31m"
	else
		color="\033[1;32m"
	fi		

	# Display if we found files or not
	echo "found ${color}${#files[@]}\033[0m files"
	
	# If we found files
	if (( ${#files[@]} != 0 )); then
		
		# Confirm deletion
		read -q "re?Confirm deletion? (Y/n) "
		echo # Cariage return

		# If confirmed
		if [[ $re =~ ^[Yy]$ ]]; then
			# Remove all files (array)
			rm $files

			# If rm did not returned any errors
			if (( $? == 0 )); then 
				echo -e "\033[1;32mSuccessfully deleted ${#files[@]} files\033[0m"
			else
				errorcode=$?
				echo -e "\033[31mError while deleting files\033[0m"
				exit errorcode
			fi

		# If NOT confirmed
		else
			echo -e "\033[33mNo files deleted\033[0m"
		fi
	fi

# If argument is not a directory, or does not exist, or is not writable
else
	echo -e "\033[31mEither file is \033[1mnot a directory\033[0;31m, or does \033[1mnot exist\033[0;31m, or you do not have \033[1mwrite permission\033[0;31m on that file.\033[0m"
	exit 1
fi

