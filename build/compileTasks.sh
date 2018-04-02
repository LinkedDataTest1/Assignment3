#!/bin/bash

#Name: compileTask.sh
#Description: Validates that the task files exist and compile them if they do
#Parameters: Name of the Tasks to search for
#Output: Descriptions of errors found
#Exit Value: Number of errors found, 0 if the files were correct

errors=0

sleep 2
#username=$(curl -s -X GET "https://api.github.com/repos/${TRAVIS_REPO_SLUG}/pulls/${TRAVIS_PULL_REQUEST}" | jq -r '.user.login')
username="LuisFernando100"
sleep 2
#number=$(curl -s -X GET "https://raw.githubusercontent.com/LinkedDataTest1/Assignment1/master/$username.csv" | awk -v username=$username -F "\"*,\"*" '{ if($1 == username) print $2}')
#number=$(echo $number)
number=123

#Check if correct directory exists
if [ ! -d "$username-$number" ]; then
  echo "Directory missing. Make sure it has the correct format" "$username-$number" "If the format is correct make sure your data here is correct https://github.com/LinkedDataTest1/Assignment1/blob/master/$username.csv"
  errors=$((errors+1))
else
	#Copy all files to src foulder
	cp -R $username-$number/. ./src/main/java/
	#Compile java files
	mvn -q compile
	if [[ $? -eq 0 ]]
	then
		#If compilation was correct run tests
		mvn -q test
		if [[ $? -ne 0 ]]
		then
			#If tests failed show error
			echo "ERROR ON TEST"
			errors=$((errors+1))
		fi
	else
		#If compilation was incorrect return Error
		echo "ERROR ON COMPILATION"
		errors=$((errors+1))
	fi
fi

exit $errors
