#!/bin/sh

# This script deploys the latest code in GitHub's master branch to Amazon S3
# so that it can be served to the world through S3 website hosting.


# Coding challenge participants: You won't actually have access to write to
# this S3 bucket. You can create a bucket of your own and point S3_BUCKET to
# that instead. Or just comment out the line that copies the file to S3 --
# you don't actually need to write to S3 to finish the challenge.

S3_BUCKET="guild-devops-challenge"


# Make sure the user has git and aws CLI tools installed
if [ -z "$(which git)" ]; then
    echo "Error: This script needs git to run."
    exit 1
elif [ -z "$(which aws)" ]; then
    echo "Error: This script needs the AWS CLI installed."
    echo "Learn more at https://aws.amazon.com/cli/."
    exit 1
fi

# Make sure the user has AWS access credentials in their environment
if [ -z "$AWS_ACCESS_KEY_ID" -o -z "$AWS_SECRET_ACCESS_KEY" ]; then
    echo "Error: This script requires guild-dev AWS access credentials."
    exit 1
fi

# Make sure the user doesn't have any unsaved changes in the current directory
git status | grep -q "nothing to commit, working tree clean"
if [ "$?" -ne "0" ]; then
    echo "Error: The working directory must be clean before each deploy."
    exit 1
fi

set -x  # prints each command that is going to be executed

# Make sure our master branch contains the latest version from GitHub
# immediately before deploying
git fetch origin && git checkout master && git reset --hard origin/master
if [ "$?" -ne "0" ]; then
    echo "Error fetching the latest code from GitHub; aborting."
    exit 1
fi

# Deploy the index.html file to s3
aws s3 cp "index.html" "s3://$S3_BUCKET/index.html"
if [ "$?" -eq "0" ]; then
    echo "Deploy finished successfully!"
else
    echo "Deploy failed!"
    exit 1
fi
