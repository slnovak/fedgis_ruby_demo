# FedGIS 2014 ArcGIS & Ruby Demo App

You will need an ArcGIS developer account and application in order to log into this application. First, create an [account](https://developers.arcgis.com). Next, you will want to create an application so that you will have a *client id* and *client secret*. Also make sure you fill in the redirect uri with *http://localhost:4567* so that OAuth knows where to redirect.


This is an application designed to show a few concepts.

0. Speaking Ruby
0. Using libraries
0. A Ruby web application with Sinatra

```
$ git clone git@github.com:slnovak/fedgis_ruby_demo.git
```

Install the dependencies

`$ bundle install`

Show me what you know how to do

`$ bundle exec rake -T`

First, lets compile the SASS into css

`$ bundle exec rake css:compile`

Next, run the server!

## I need to get bootstrapped

If you are completely new to ruby and you need to set up your machine [Rails Bridge](http://docs.railsbridge.org/installfest/) probably has more then you need. Have fun!
