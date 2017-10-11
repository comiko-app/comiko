<h1 align="center">
	<br>
	<img width="1153" src="lib/assets/comiko_long.png" alt="Comiko">
	<br>
	<br>
	<br>
</h1>

[![Build Status](https://travis-ci.org/comiko-app/comiko.svg?branch=master)](https://travis-ci.org/comiko-app/comiko)
[![codecov](https://codecov.io/gh/comiko-app/comiko/branch/master/graph/badge.svg)](https://codecov.io/gh/comiko-app/comiko)

#### Qu'est-ce que c'est?
Comiko, c'est une application mobile qui permet de découvrir les humoristes et artistes locaux avec simplicité!
Grâce à comiko, simplifiez vos recherches et passez de superbes soirées! 

filtrez vos recherches par:
* Date de présentation
* Distance
* Prix

Découvrez de nouveau artiste en vous amusant et développez votre CULTURE humoristique!
Ajoutez des spectacles à vos favoris!

## Development

The project is contained in a few projects.

- [Comiko](https://github.com/comiko-app/comiko) is the main mobile application running in flutter. It depends on a few other projects. If you only need to modify the mobile application, you can simply check this project out and hack.

- [Data-Scraper](https://github.com/comiko-app/data-scraper) is the data scraping project.

- [Data_Importer_Firestore](https://github.com/comiko-app/data_importer_firestore) is the project used to populate the Firestore database with the data coming from the Data-Scraper.

- [Backend](https://github.com/comiko-app/backend) is the backend project. This may go away eventually since we're migrating things to Firebase. 

- [Shared](https://github.com/comiko-app/shared) is the project containing the models and several business logic rules. If you want to modify stuff in this project, be careful to test [Comiko](https://github.com/comiko-app/comiko), [Backend](https://github.com/comiko-app/backend) , and [Data-Scraper](https://github.com/comiko-app/data-scraper) since they all depend on this.

### Setup for Firebase

- Go to [Firebase console](https://console.firebase.google.com/`)
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
