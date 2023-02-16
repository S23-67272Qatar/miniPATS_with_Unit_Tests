67272_PATS_v3
==

This is a basic Rails app that was built as a class demonstration in the Spring of 2023.  This version has basic models and some business logic already implemented.

The class is Application Design & Development (67-272) and is for students in Information Systems at Carnegie Mellon University in Qatar. We share this code so that (a) it is readily accessible to students.

This project does require the use of several gems to work properly. Check the Gemfile to see which gems are used. This project also assumes the user is running Ruby 3.6.1 since that is what is used in the course.


Setup
--
This version of the project requires only a sqlite3 database.  After cloning this repo, install all gems with the `bundle install` on the command line.  

To set up the database and populate it with realistic sample records, run on the command line `rails db:populate`.  The populate script will remove any old databases, create new development and test databases, run all the migrations to set up the structure and add in the triggers, and then create 20 owners with over 40 pets and over 100 visits. (Every run will generate a different set of data.)

Check the code we wrote together in class available under app/models. 

Open the rails console and try the different queries we covered in class.