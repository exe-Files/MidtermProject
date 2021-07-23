# Bucket List Application

### Mid-term Team Project for Skill Distillery

### Team members and roles:

-   <a href="https://www.linkedin.com/in/stevenlaupan/"> Steven Laupaun (Developer, DBA) </a>
-   <a href="https://www.linkedin.com/in/gabriel-avila-2a4a7113a/"> Gabriel Avila (Developer)  </a>
-   <a href="https://www.linkedin.com/in/michael-lagassey/"> Mick Lagassey (Developer, Repo Owner) </a>
-   <a href="https://www.linkedin.com/in/bfiles/"> Brandon Files (Developer, Scrum Master) </a>

### Overview

To build upon what we've learned so far from the Java/SpringMVC/JPA materials, we were tasked with creating a full stack java web application as a team.
By working together on a daily basis, we learned how to contribute, plan, and communicate as part of a group.
The premise of this project is a bucket-list website that allows users to create and share different ideas for tasks that they would like to accomplish before they "kick the bucket". The website allows a user to search through a central hub of user generated ideas and leave comments, answer polls, and even add other user's ideas to their own personal list or create their own that they can then share. By linking the website to a MySql database, the webpages are able to dynamically update in realtime as the user interacts with them.

### Technologies and Methodologies Used
<a href="https://www.java.com" target="_blank"> <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/java/java-original.svg" alt="java" width="40" height="40"/> </a>
<a href="https://spring.io/" target="_blank"> <img src="https://www.vectorlogo.zone/logos/springio/springio-icon.svg" alt="spring" width="40" height="40"/> </a>
<a href="https://www.mysql.com/" target="_blank"> <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/mysql/mysql-original-wordmark.svg" alt="mysql" width="40" height="40"/> </a>
<a href="https://getbootstrap.com" target="_blank"> <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/bootstrap/bootstrap-plain-wordmark.svg" alt="bootstrap" width="40" height="40"/> </a>
<a href="https://www.w3.org/html/" target="_blank"> <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/html5/html5-original-wordmark.svg" alt="html5" width="40" height="40"/> </a>
<a href="https://www.w3schools.com/css/" target="_blank"> <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/css3/css3-original-wordmark.svg" alt="css3" width="40" height="40"/> </a>
<a href="https://git-scm.com/" target="_blank"> <img src="https://www.vectorlogo.zone/logos/git-scm/git-scm-icon.svg" alt="git" width="40" height="40"/> </a>
<a href="https://aws.amazon.com" target="_blank"> <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/amazonwebservices/amazonwebservices-original-wordmark.svg" alt="aws" width="40" height="40"/> </a>

-   Java
-   JPA
-   Spring MVC
-   Gradle
-   Bootstrap
-   MySQL
-   HTML/CSS
-   AWS ec2
-   JUnit

### Development Techniques Utilized

-   Pair programming
-   Agile
-   Git collaboration

<Link to deployed application>

#### How to login, username/password, etc.

A user can register for a new account and use it to navigate the website or use credentials from prior.
The admin page can be accessed with a username and password, which grants the ability to edit and remove bucket items, comments, polls, and even individual users.

#### How it works, what the user can do
The user is presented with a login screen when they first visit the website.
They can choose to register for a new account or to use the credentials of an account they created previously.
From there, they will be brought to their personal homepage which consists of bucket-list items that they have saved or created.
The user can choose to view the details of those items, as well as edit, delete, leave comments, ratings, notes and other resources that they see fit, allowing more personalization for their idea.
In the navigation bar, there is an option to explore, which brings the user to a gallery of other bucket-list ideas that they can view, vote on, comment on, or even add to their own personal bucket-list.
If logged into an admin account, you are also able to use the navigation bar to access an admin dashboard. The admin dashboard allows moderators to edit user accounts, delete comments, polls, and

### Description of overall project structure

<screenshot1.png> <screenshot2.png>
<ERDiagram.png>

### Lessons Learned

###### Steven L:

###### Mick L:
Working with the Google Maps API I learned that there's more than one way to put yourself on the map, or rather, the map on your site. The simplest solution is often the way to go but in our case it was the second simplest, embedding and using our controller to modify the query string in the URL, that worked the best. We also managed to serendipitously find a way to upload actual photos to our MySQL database by using the image preview function (which was our original plan, just to showcase a future function that wasn't fully implemented) of a <a href="https://bootstrapious.com/p/bootstrap-image-upload">ready-built</a> solution and redirecting the output URL to a hidden field in the form using JavaScript. Overall though, I'd say working with a team of curious and intelligent folks was the best learning experience. I look forward to doing it again!

###### Gabriel A
* Learned to better understand protocol errors for debugging
* Gained more experience in bootstrap
* Gained a better understanding for how to use different input types on html forms
* Learned a few creative solutions to feature issues from my teammates 
###### Brandon F:

#### Stretch Goals
During our planning phase and thoughout our stint building out the site, we had multiple stretch goals we wanted to accomplish within the given timeframe, such as a map feature, image upload, a friends-list feature, a word cloud search, geocaching, main attractions nearby, and various other user additions and restrictions, as well as bug fixes.
Although some of those features would be nice to have, we understood that given the timeframe of this project, we would have to focus on only a few of those ideas if we were able to meet all the requirements that were set from the start. At a later date, we would love to come back and work on adding more functionality to the site.
