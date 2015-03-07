# Brunch with Cyclists
An app skeleton for [Brunch](http://brunch.io/).

## Overview
Brunch builds your app (compiles and concatenates scripts, etc.) and is fast at doing it.
Brunch with Cyclists seeds your app structure, including a great JavaScript framework: Cycle.js. It also provides a tiny example app to illustrate how things are hooked together, including tests.

## Features
* [Cycle.js](https://cycle.js.org/)
* [CoffeeScript](http://coffeescript.org/), with [CoffeeLint](http://www.coffeelint.org/)
* [Stylus](http://learnboost.github.io/stylus/), with [Autoprefixer](https://github.com/postcss/autoprefixer)
* [Styledocco](http://jacobrask.github.io/styledocco/)
* Automated tests, with notifications, using:
  * [Mocha](http://mochajs.org/)
  * [Chai](http://chaijs.com/)
  * [Sinon](http://sinonjs.org/)
  * [PhantomJS](http://phantomjs.org/)

## Applications
Brunch with Cyclists hooks up a bunch of useful tools and provides opinionated defaults. If these choices work for you you'll find it an excellent starting point for building:
* Stand-alone single-page applications
* The frontend to go with any type of backend web application/server (Express, Rails, Django, ASP.NET, etc.; consider build steps to invoke `brunch build --production` and copy the contents of public/ to the appropriate assets directory)
* Web views for cross-platform mobile apps (with Cordova, Xamarin, etc.)

## Getting started
### Requirements
* [node](https://nodejs.org/)
* [brunch](http://brunch.io/)

Additionally, phantomjs, stylus, and styledocco should be installed globally to make their executables available (for tests and style guide):

```
npm install -g phantomjs-prebuilt stylus styledocco
```

### Create a project with this skeleton

```
brunch new gh:drakes/brunch-with-cyclists [optional-output-dir]
```

### Build, run tests, and launch a server

```
npm start
```

Editing changes should be picked up by brunch automatically in "watch" mode and recompiled, etc., including re-running tests on script changes.

To view the app browse to: http://localhost:3333/

## License
Brunch with Cyclists is � [Scott Drake](http://3dmdesign.com) and available under the [MIT license](http://opensource.org/licenses/MIT).