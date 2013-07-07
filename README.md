Time Bank Project
=========

[![Travis Build](https://travis-ci.org/jd-erreape/time-bank.png)](https://travis-ci.org/jd-erreape/time-bank)
[![Code Climate](https://codeclimate.com/github/jd-erreape/time-bank.png)](https://codeclimate.com/github/jd-erreape/time-bank)
[![Coverage Status](https://coveralls.io/repos/jd-erreape/time-bank/badge.png?branch=master)](https://coveralls.io/r/jd-erreape/time-bank?branch=master)

## Installing for contributing

### What do you need?

We are using:

* Ruby 2.0.0
* MySQL
 
so you need those installed in your system before continue (we'll assume that you've installed ruby using rvm)

### Installation

* Fork and clone the project into a local directory
* Create a gemset 
```
rvm 2.0.0@time-bank --create
``` 
* Create a .ruby-version file in the project root folder with the following content
```
2.0.0
```  
* Create a .ruby-gemset file in the project root folder with the following content
```
time-bank
```  
* Install bundler 1.3.5
```
gem install bundler -v 1.3.5
```  
* Install all the gems
```
bundle install
```  
* Create de database
```
rake db:create
```  
* Run the migrations
```
rake db:seed
```  

And that's it, you're ready to go!

### Running the tests

First of all prepare the test database

```
rake db:test:prepare
```  

Now you can run the tests with the traditional rake task

```
rake test
```

But we're using zeus and guard in development mode so our recomendation is to run this two commands in different terminal windows

```
zeus start
guard
```

This way, guard will be watching for changes in the app and it will be running the tests automatically :)
