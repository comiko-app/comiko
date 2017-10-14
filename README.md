<h1 align="center">
	<br>
	<img src="lib/assets/comiko_long.png" alt="Comiko">
	<br>
	<br>
	<br>
</h1>

[![Build Status](https://travis-ci.org/comiko-app/comiko.svg?branch=master)](https://travis-ci.org/comiko-app/comiko)
[![codecov](https://codecov.io/gh/comiko-app/comiko/branch/master/graph/badge.svg)](https://codecov.io/gh/comiko-app/comiko)

#### What is it?
Comiko is a mobile application which allows you to easily discover local comedians and artists!
Using comiko, reduce the amount of time you spend looking, and increase the time you spend enjoying your evenings!


Filter your searches by:
* The date of the show
* How far it is
* The show's cost

Find new artists, enjoy yourself, and develop your humorous side!
Add the best shows to your favourites!

## Development

The project is contained in a few projects.

- [Comiko](https://github.com/comiko-app/comiko) is the main mobile application running in flutter. It depends on a few other projects. If you only need to modify the mobile application, you can simply check this project out and hack.

- [Data-Scraper](https://github.com/comiko-app/data-scraper) is the data scraping project.

- [Data_Importer_Firestore](https://github.com/comiko-app/data_importer_firestore) is the project used to populate the Firestore database with the data coming from the Data-Scraper.

- [Backend](https://github.com/comiko-app/backend) is the backend project. This may go away eventually since we're migrating things to Firebase. 

- [Shared](https://github.com/comiko-app/shared) is the project containing the models and several business logic rules. If you want to modify stuff in this project, be careful to test [Comiko](https://github.com/comiko-app/comiko), [Backend](https://github.com/comiko-app/backend) , and [Data-Scraper](https://github.com/comiko-app/data-scraper) since they all depend on this.

### Setup for Firebase

Note: If you're not part of the Comiko project on Firebase, you can either ask to be invited, or create your own Firebase project, just make sure to use the correct package name (`ca.comiko.comiko`).


- Go to [Firebase console](https://console.firebase.google.com)
- Go to your [project settings]

![settings](https://i.imgur.com/0EXnrEM.png)

- Download the `google-services.json` file.

![google-services.json](https://i.imgur.com/W0N8U1P.png)

- Place it under `comiko-app/android/app`

## Getting Started
For help getting started with Flutter, view our online
[documentation](http://flutter.io/).

## License

[MPL-2.0](LICENSE) © [Comiko](https://comiko.ca/)
