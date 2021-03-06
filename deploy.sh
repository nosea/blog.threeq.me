#!/bin/bash

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

fail() {
	echo "$1"
	exit 1
}

# Build the project.
hugo # if using a theme, replace with `hugo -t <YOURTHEME>`
echo "search key $2"
searchKey="$2"
python2 search_process.py -k "${searchKey}" || fail "site search data process fail. Error Code: [ $? ]"


# Go To Public folder
cd public
# Add changes to git.
git add .

# Commit changes.
msg="rebuilding site `date`"
if [ $# -ge 1  ]
    then msg="$1"
fi
    git commit -m "$msg"

 # Push source and build repos.
git push origin master

# Come Back up to the Project Root
cd ..
