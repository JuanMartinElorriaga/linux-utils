#!/bin/bash
# Script for automating repo creation process. The folder needs to be created first, and repo name should be given as input.
# Also, if HTTPS login does not work, SSH is available, but SSH has to be defined manually before proceeding.
# GitHub API Token
GH_API_TOKEN='<token>'
# GitHub User Name
GH_USER='<user>'
# Variable to store first argument to init-repo, the repo name. Will be used as GH repo name, too.
NEW_REPO_NAME=$1
# Project directory can be passed as second argument to init-repo, or will default to current working directory.
PROJECT_DIR=${2:-$PWD}
# GitHub repos Create API call
curl -H "Authorization: token $GH_API_TOKEN" https://api.github.com/user/repos -d '{"name": "'"${NEW_REPO_NAME}"'"}'
echo "just debugging here.."
git init $PROJECT_DIR
echo "just debugging here as well.."
# Initialize Git in project directory, and add the GH repo remote.
git -C $PROJECT_DIR remote add origin git@github.com:$GH_USER/$NEW_REPO_NAME.git
echo "this is the line that decides your future.."
#git -C $PROJECT_DIR remote add origin https://github.com/$GH_USER/$NEW_REPO_NAME.git
# Initial config
touch README.md
touch .gitignore
# Add repo name as title of README.md
echo "# $NEW_REPO_NAME" >> README.md
echo "Creted README.md file with title set as: $NEW_REPO_NAME"
# Note: gitignore_python.txt has to be an existing local file for this to work!!
cat ~/.gitignore_python.txt >> .gitignore
echo "Added .gitignore file with Python 3 config"
git add .
git commit -m "First commit"
git push --set-upstream origin master