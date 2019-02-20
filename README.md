# Guild DevOps Challenge single-page app

This repo contains the single-page app that's part of Guild Education's coding challenge for DevOps Engineers. The app is hosted on Amazon S3, in a bucket configured as a public website. You can [view the app](http://guild-devops-challenge.s3-website-us-west-2.amazonaws.com/) from any web browser!


## Contributing and deploying changes

Here's how a Guild developer should make changes and deploy them to the web:

1. Create a Git branch and commit your changes in that branch.
2. Open a GitHub pull request and have a peer review it.
3. After the pull request has been approved, merge the pull request into the `master` branch on GitHub.
4. From your laptop or a dev server, run `deploy.sh` in the root of this repo. The deploy script will pull the latest version of `master` from GitHub and deploy that to Amazon S3.
