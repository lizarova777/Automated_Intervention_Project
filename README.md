# Automated Intervention

## Project Objective:
 
The purpose of this project is to develop a process that uses data to create a product for an automated intervention in order to improve student performance and their learning experience in a course. 

## Datasets:

The datasets in this repository come from a seven week educational data science course. You have access to data from two iterations of this course, one in 2014 and one in 2015. The course content is disaggregated, EG - Students choose the order in which they wish to tackle each unit. Students complete one unit each week for six weeks, in the seventh week all students must sit the same final exam.

* scores.csv 

This dataset contains the unit choices, time spent on each unit in minutes and scores for each unit     students recieved. It also contains final exam scores. All scores are represented at a proportion of the overall possible score (0 - 1).

* tweets.csv

Permission was received from the students in this course to collect their tweets during the course. This data set contains those tweets, the week in which they were tweeted and if the tweet was a reply to another student in the class.**   

** These are real Tweets from the wild, collected by the [Sentiment140](http://help.sentiment140.com/home) team at Stanford. I have attempted to clean them of anything offensive but may have missed something so be aware if you plan on reading the text.

## Product:
This product consists of a social network analysis based on students' tweets, several visualizations to represent overall class performance and are stored in a ZIP file, an auto-generated email intervention to students with below-passing grade, and several interactive visualizations for each student, which are presented in form of a dashboard, the link of which can be found below. 

### 2014 vs. 2015 Class Social Networks

![socialnetworks](https://github.com/lizarova777/Automated_Intervention_Project/blob/master/2014_vs._2015_Class_Social_Networks.png)

### Visualizations:

![visualuizations](https://github.com/lizarova777/Automated_Intervention_Project/blob/master/Visualizations.png)

### Dashboard Link:

[dashboard link](https://lizarova777.shinyapps.io/Student_Scores/)
