chef-cicd
---------

release scripts for the chef entities in a bamboo pipeline

## v0.4.0

* add kitchen-clean.sh, which can be called before kitchen testing

## v0.3.0, v0.3.1, v0.3.2

* release-chef-repo
    * move all syntax/style checking up front
    * exit w/o publishing if not the master branch
    * handle empty or "none" org
    * improve status messages

## v0.2.0

* create bin/test-chef-cookbook to replace current release-chef-cookbook

## v0.1.0

* first version
