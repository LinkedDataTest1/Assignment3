#!/bin/bash

#Name: compileTask.sh
#Description: Validates that the task files exist and compile them if they do
#Parameters: Name of the Tasks to search for
#Output: Descriptions of errors found
#Exit Value: Number of errors found, 0 if the files were correct

errors=0

TOKEN1=8c073f6335e29d1
TOKEN2=e06e0dbade3a8a78405449b5d
sleep 2
username=$(curl -H "Authorization: token $TOKEN1$TOKEN2" -X GET "https://api.github.com/repos/${TRAVIS_REPO_SLUG}/pulls/${TRAVIS_PULL_REQUEST}" | jq -r '.user.login')
#username="LuisFernando100"
sleep 2
number=$(curl -H "Authorization: token $TOKEN1$TOKEN2" -X GET "https://raw.githubusercontent.com/LinkedDataTest1/Assignment1/master/username+matricula.csv" | awk -v username=$username -F "\"*,\"*" '{ if($1 == username) print $2}')
number=$(echo $number)
#number=123

#Check if correct directory exists
if [ ! -d "$username-$number" ]; then
  echo "Directory missing. Make sure it has the correct format" "$username-$number" "If the format is correct make sure your data here is correct https://github.com/LinkedDataTest1/Assignment1/blob/master/username+matricula.csv"
  errors=$((errors+1))
else
	for task in "$@"
	do
		echo $task
		#For each Task check if the Task.java exist
		if [ -f "./$username-$number/"$task".java" ]
		then
			#If it tries to compile it
			javac -cp .:lib/* $username-$number/"$task".java
			if [[ $? -ne 0 ]]
			then
				echo "Error compilating" "$task".java
				errors=$((errors+1))
			#If there were no errors compiling we make the tests
			else
				ant -Dpsourcedir=$username-$number -Dtasktest="$task"Test test > /dev/null 2> /dev/null
				#If the test didnt pass we return
				if [[ $? -ne 0 ]]
				then
					echo "Error testing" "$task".java
					errors=$((errors+1))
				fi
			fi
		else
			#If it doesnt exist show error and continue
			echo "Task missing. Make sure it has the correct format" "./$username-$number/"$task".java"
			errors=$((errors+1))
		fi
	done
fi

exit $errors
