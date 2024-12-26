# README

This is a Rails APP that code review each file of a repository, allowing devs to focus where it should improve code quality

For now, only bedrock reviewer is implemented

To run, clone the repository and run:

FILE_EXTENSIONS='py,rb,js,css,erb' FILE_EXCLUSION='/test/dummy|db/migrate' AWS_REGION='us-east-1' AWS_ACCESS_KEY='ACCESS_KEY' AWS_SECRET_ACCESS_KEY='SECRET_ACCESS_KEY' rails s

* ...
