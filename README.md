# Project - *CookieMeUp*

**CookieMeUp** is an app that will allow fans of Girl Scount Cookies to be reminded of when cookies are being sold. In addition, users will be able to easily locate nearby Girl Scount Cookie stands to support local troops.



## User Stories

The following **required** functionality is completed:

- [x] User sees app icon in home screen and styled launch screen
- [x] User can login and logout of app
- [x] User is alerted if fields are left blank to prevent account creation
- [x] User can create a new account
- [x] User can have a personal profile account
- [x] Implement a map api
- [x] User can view cookie vendor locations on map
- [x] User can add a new cookie location on map



The following **stretch** features are implemented:

- [x] Users can view a list view of all cookie vendor locations
- [ ] User can click on location to get more information
- [x] User does not have to login with each app usage
- [x] User can add a photo of cookie location as proof
- [x] User sees a loading state while waiting for the the locations to load
- [x] Users login info is persistent


## Wireframe

![Wireframe Image](https://raw.githubusercontent.com/CSUMB-CST495-Group-1/CookieMeUp/master/images/cookieMeUp.png)


## Considerations

* What is your product pitch?
    * Difficulty finding/selling Girl Scout cookies when in season? We have the solution for you, CookieMeUp is your one stop app where you can locate, add and sell Girl Scout cookies.
* Who are the key stakeholders for this app?
     * Girl Scout troops and Girl Scout cookie lovers will be using this app. Girl Scout troops will be using this app to add locations of where they are selling their cookies. Girl Scout cookie lovers will be using this app to view, search and add selling locations.
* What are the core flows?
     * All of the users will have the same functionality and they will all be able to see the same screens across our application. The screens include: login screen, create account, map, list of stands, and the add cookie stand screen.

* What will your final demo look like?
    * At the end of our project our demo will show:
        1. How the login works
        2. How the user can create a new profile
        3. How the user will be able to add a pinpoint with a location with a cookie stand picture
        4. How the user can filter the cookie stands in map view or list view
        5. How the user can view the cookie stands without login in

* What mobile features do you leverage?
    * Our app will leverage on the camera and the maps location.

* What are your technical concerns?
    * Something we are concerned about it how to access a users current location through the app.


## Milestones
Project timeline for when major **CookieMeUp** app functionalities are due to be completed.


**March 28, 2018**
- [x] Necessary models are implemented in Parse
- [x] User sees app icon in home screen and styled launch screen
- [x] User can login and logout of app
- [x] Implement map api


**April 4, 2018**
- [x] App can access camera and photos on device
- [x] User can create a profile
- [x] User created profile saved to Parse access
- [x] User can upload a photo or change photo on profile
- [x] Login and account creation only possible if all fields are filled

**April 11, 2018**
- [x] User can add cookie location to map
- [x] Pins on map display cookie locations
- [x] App can access camera and photos on device
- [x] Google map api implemented as there were problems with previous map UI


**April 18, 2018**
- [x] User can view a list view of cookie locations
- [x] Table view cookie locations have important information displayed
- [x] User can add a photo to cookie location
- [x] Add persistent user functionality


**April 25, 2018**
- [x] Create presentation "script" to follow and practice
- [x] Update app design for a professional app demo
- [x] Practice presentation

## Parse Tables and Columns
**User Table**

![User Table Image](https://raw.githubusercontent.com/CSUMB-CST495-Group-1/CookieMeUp/master/images/userTable.png)


**Cookie Location Table**

![Cookie Location Table Image](https://raw.githubusercontent.com/CSUMB-CST495-Group-1/CookieMeUp/master/images/cookieLocationTable.png)


## Video Walkthrough

This walkthrough will show the progression of our project development.

### Here's a walkthrough of implemented milestones set #1:

<img src='https://github.com/CSUMB-CST495-Group-1/CookieMeUp/blob/master/cookieMeUp.gif?raw=true' title='Video Walkthrough' width='' alt='Video Walkthrough' />

***

### Here's a walkthrough of implemented milestones set #2:

<img src='https://raw.githubusercontent.com/CSUMB-CST495-Group-1/CookieMeUp/master/images/CookieMeUp_Demo2.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

*** 

### Here's a walkthrough of implemented milestones set #3:

<img src='https://i.imgur.com/vzMGW3N.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

***

### Here's a walkthrough of implemented milestones set #4:

<img src='https://raw.githubusercontent.com/CSUMB-CST495-Group-1/CookieMeUp/master/images/milestone4.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

*** 

### Here's a walkthrough of Cookie Me Up Final Demo

<img src='https://github.com/CSUMB-CST495-Group-1/CookieMeUp/blob/master/images/CookieMeUpDemo.gif?raw=true' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library


## Notes



## License

Copyright 2018 CSUMB

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
