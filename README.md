# MovieRama
## Technologies used
Ruby version 2.7 \
Rails version 5.2.3 \
Postgresql version 14.5

## Installation steps
* Clone the repository 
```git clone https://github.com/NikosKalogeropoulos/MovieRama.git```
* cd into the project
* Run ```bundle install``` to install the dependencies needed
* Run ```bundle exec rails db:setup``` to set up the new database from the project
* Start the server ```rails s```
* Make sure the the postgres database server is up and running
* Go to the root url ```localhost:3000/movies```
* To seed some default data I've created ```rails db:seed``` (you can see the data in seeds.rb file)
* To Log In with an existing user 
```Username: User1, Password: 123456```
\


The app has the basic functionality as described in the assignment. It has been implemented using the Rails mvc framework and
using the html.erb technology for the views.The likes/hates have been implemented using one table (reactions) with many to many relationships between movies and user. It has a column with a string value that accepts only the strings 'LIKE', 'HATE', that is being validated by the Reaction controller. Also new routes and actions (inside the movies controller) have been implemented to support the reaction functionality.
\
The filters are being implemented using url parameters in the Movies controller and they are not being persisted between requests
\
\
Logging in with a user gives an extra functionality of adding movies as well as being able to react to a movie entry. This is being implemented with a before_action function in the MoviesController and not only by the view.
\
\
All the forms use an authenticity token to prevent csrf attacks.
\
\
The routes used can be found in the ```routes.rb``` file
