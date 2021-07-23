# Bucket List Application

### Mid-term Team Project for Skill Distillery

### Team members and roles:

-   <a href="https://www.linkedin.com/in/stevenlaupan/"> Steven Laupan (Developer, DBA) </a>
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
The website can be accessed <a href="http://18.189.91.96:8080/BuckIt/">here</a>
A user can register for a new account and use it to navigate the website or use credentials from prior.
The admin page can be accessed with a username and password, which grants the ability to edit and remove bucket items, comments, polls, and even individual users.

#### How it works, what the user can do
The user is presented with a login screen when they first visit the website.
They can choose to register for a new account or to use the credentials of an account they created previously.
From there, they will be brought to their personal homepage which consists of bucket-list items that they have saved or created.
The user can choose to view the details of those items, as well as edit, delete, leave comments, ratings, notes and other resources that they see fit, allowing more personalization for their idea.
In the navigation bar, there is an option to explore, which brings the user to a gallery of other bucket-list ideas that they can view, vote on, comment on, or even add to their own personal bucket-list.
If logged into an admin account, you are also able to use the navigation bar to access an admin dashboard. The admin dashboard allows moderators to edit user accounts, delete comments, polls, and even deactivate user accounts.

### Overall project structure
<img src="https://user-images.githubusercontent.com/23006320/126818019-01bd3339-42f3-4706-858f-7e647b49c16e.png">

### Lessons Learned

###### Steven L:

Working as a team was what I found to be the greatest learning experience on this project.
To this point, all of my coding experience has been of an individual effort or with a partner. This makes
thought processes and conveyance of ideas relatively simple. However, working as a group of four
introduces a new level of planning, organization, and communication required to accomplish a task.
I believe this project really made the saying that "Code is read more often than written" hit home.
I felt that our team worked extremely well together and when one person was stuck, others were there to lend insight, ideas, and troubleshooting tactics. Every member had ideas that were unique and some of those ideas really pushed us to implement features we might have though would not have been possible in our short timeframe. Taking on some of these tasks and features as a team, combined with the opportunity to work on code in all areas of the project, really taught me some useful coding techniques and opened my eyes to the fact that there are always multiple methods to accomplish one task or feature. Overall, this project was a fantastic learning experience and growth opportunity for me and I have our team to thank for that.

###### Mick L:
Working with the Google Maps API I learned that there's more than one way to put yourself on the map, or rather, the map on your site. The simplest solution is often the way to go but in our case it was the second simplest, embedding and using our controller to modify the query string in the URL, that worked the best. We also managed to serendipitously find a way to upload actual photos to our MySQL database by using the image preview function (which was our original plan, just to showcase a future function that wasn't fully implemented) of a <a href="https://bootstrapious.com/p/bootstrap-image-upload">ready-built</a> solution and redirecting the output URL to a hidden field in the form using JavaScript. Overall though, I'd say working with a team of curious and intelligent folks was the best learning experience. I look forward to doing it again!

###### Gabriel A
Working with this team has been a great experience. I've learned how to better identify and fix issues based on the protocol errors that were thrown. The planning phase and communication within this team was excellent where we were quickly able to find a solution to any issues we encountered. This sprint gave each of us more opportunities to develop our front-end skills, and this was a great experience to see how we can bounce ideas off each other and work together to implement them. Connecting html forms with controllers and adding different model attributes as a creative solution to an issue we encountered was interesting to witness and rewarding and understand we came to that solution. Before this I haven't played with bootstrap enough to feel comfortable with it, but I feel more confident in applying bootstrap to future projects. I applaud this team and am grateful for having the chance to work with them, look forward to working with you all again!

###### Brandon F:
Greatness is found in the agency of others, and this time was no exception. Working on this team has been an incredible experience. I'm grateful for having been placed on a team of insightful and driven individuals like this one. From the planning phase, to wireframing, dividing roles and tasks, and the actual implementation all the way through the end, we collaborated seemlessly towards a final product. By taking the time to propose new ideas to eachother, and helping one another form those thoughts into actual code, we were able to get far more done together than any of us could have done individually. This was my first major coding project working within a group setting, and it really stands as a testament of how important proper planning and communication is throughout the process. I've struggled in the past with asking for help when getting stuck, but I've learned that I can rely on others when I need a hand for the things that I don't know or understand. I really enjoyed my time working in this sprint, and I look forward to many more to come.

#### Stretch Goals
During our planning phase and throughout our stint building out the site, we had multiple stretch goals we wanted to accomplish within the given timeframe, such as a map feature, image upload, a friends-list feature, a word cloud search, geocaching, main attractions nearby, and various other user additions and restrictions, as well as bug fixes.
Although some of those features would be nice to have, we understood that given the timeframe of this project, we would have to focus on only a few of those ideas if we were able to meet all the requirements that were set from the start. At a later date, we would love to come back and work on adding more functionality to the site.
