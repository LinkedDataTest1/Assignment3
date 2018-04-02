errors=0

sleep 2
username=$(curl -X GET "https://api.github.com/repos/${TRAVIS_REPO_SLUG}/pulls/${TRAVIS_PULL_REQUEST}" | jq -r '.user.login')
sleep 2
number=$(curl -X GET "https://raw.githubusercontent.com/LinkedDataTest1/Assignment1/master/$username.csv" | awk -v username=$username -F "\"*,\"*" '{ if($1 == username) print $2}')
number=$(echo $number)

#Check if correct directory exists
if [ ! -d "$username-$number" ]; then
  echo "Directory missing. Make sure it has the correct format" "$username-$number" "If the format is correct make sure your data here is correct https://github.com/LinkedDataTest1/Assignment1/blob/master/$username.csv"
  errors=$((errors+1))
else
	#Copy all files to src foulder
	cp -R $username-$number/. ./src/main/java/
fi

exit $errors
