CMPT 276 Summer 2017

SFU Course Scheduler
 
Problem Description
 
At present day, each SFU student is met with a frustrating and tedious process every semester of class selection. 
Currently, this can require multiple hours of carefully browsing offered classes on outdated and poorly designed 
websites and then manually checking desired classes for time, campus, and exam conflicts. 
 
Often times, small details are overlooked resulting in students finding out far too late to do anything about it
that their intended schedule will not work. In talking to other students this issue appears to be a common and 
very frustrating one, with much of the dissatisfaction being directed towards the University itself. Students 
may have their degree delayed due to unforeseen problems with their schedules. 
 
This process is particularly difficult for new or transfer students, and outright impossible for parents to assist
with. In addition, it presents itself as a frequent problem for the SFU advisors. Almost every single SFU student 
has experienced problems with this process at some level.
 
Project Proposal
 
Our web application, SFU Course Scheduler (Gitlab: https://csil-git1.cs.surrey.sfu.ca/nfador/SFU-Course-Scheduler)
is a Ruby on Rails based web application that greatly enhances the experience of semester schedule building. It 
checks for conflicts relating to time, exam, and campus based on a much easier to access course database which we
will populate through the SFU Courses API ( www.sfu.ca/outlines/help/api.html ).
 
The main feature of our app will be facilitating course selection based on dynamic schedule production featuring
automatic conflict checking. In addition, offered courses will be presented in a much better way.
 
Time permitting, features that we’d be interested in adding are account creation to allow the storage of 
previously taken classes, prerequisite checking, the ability to automatically process transcript PDFS for 
previously taken classes, class and professor ratings, social sharing of schedules to allow coordination between
friends,  and suggestion of classes outside of designated majors that are useful to students.
