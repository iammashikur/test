#!/bin/bash

# Replace with your GitHub username and repository name
GITHUB_USERNAME="iammashikur"
REPO_NAME="test"
GITHUB_URL="https://github.com/iammashikur/test.git"

# Create a new directory and initialize a git repository
mkdir -p $REPO_NAME
cd $REPO_NAME
git init

# Create an initial README.md file
echo "# $REPO_NAME" > README.md
git add README.md
git commit -m "Initial commit"
git branch -M main

# Prompt for GitHub Personal Access Token
echo "Please enter your GitHub Personal Access Token:"
read -s GITHUB_TOKEN

# Add the remote repository with authentication
git remote add origin "https://$GITHUB_TOKEN@github.com/$GITHUB_USERNAME/$REPO_NAME.git"

# Push the initial commit
git push -u origin main

# Loop through 365 days, update date.txt, and commit
for i in {0..364}
do
    # Calculate the date for $i days ago
    DATE=$(date -d "$i days ago" +"%Y-%m-%d")
    echo $DATE > date.txt

    # Add and commit the changes with the specific date
    git add date.txt
    GIT_AUTHOR_DATE="$DATE 12:00:00" GIT_COMMITTER_DATE="$DATE 12:00:00" git commit -m "Update date.txt with date $DATE"

    # Optional sleep to avoid potential issues with timing
    sleep 1
done

# Push all commits to GitHub
git push origin main

echo "All commits completed!"
