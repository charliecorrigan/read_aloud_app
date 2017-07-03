# README

This is a web app to log volunteer and staff stats from Read Aloud events. Staff can also manage volunteer accounts and event records.  We used:
- Rails 5.1.1
- PostgreSQL
- Ruby 2.3.1

## To Try the project yourself:
In Terminal
- Make a directory to hold the directories of this project.
- Clone this repo into that directory
- `cd read_aloud_app`
- Run `bundle`
- Finally, run `rake db:{create,migrate,seed} to setup and seed your database with a few fake accounts

### RSpec test suite and Checking Coverage with SimpleCov

Start by running our test suite.

  * Enter `rspec` on the command line to run the test suite.
  * Next, enter `open coverage/index.html` on the command line to see test coverage.
  * For a little more joy in your testing, run `rspec spec -f NyanCatMusicFormatter` on the command line instead of `rspec`

### Running the server locally

  * To start up the server from within the project, run `rails s`.
  * Then, visit `http://localhost:3000/login` in your browser
  * Login using one of the provided test accounts:
      - Volunteer: 
        * username: hgranger
        * password: password
      - Staff: 
        * username: mmcgonagall
        * password: password
      - Admin: 
        * username: hogwarts4life
        * password: lemondrop

### Recording Event Statistics
  * Once you have logged in using any account type, select `Read` from the menu
  * Select the desired classroom from the dropdown
  * Select the date of the event from the dropdown calendar
  * Enter the number of children present at the event
  * Enter the number of adults present at the event
  * Select `Submit`
  
### Viewing Event Log
  * Select `History` from the menu
  * To see more event details or to edit or delete an event, select an event from the Event Log

### Viewing and Editing User Profile
  * Once you have logged in using a staff or admin account, select `Profile` from the menu
  * Select `Edit Profile` to edit user info
  * To add a new classroom to a user account:
    - Select the school from the dropdown menu
    - Select `submit`
    - Select the desired school from the dropdown
    - Select `Select Classroom`

### Managing Data
  * Once you have logged in using a staff or admin account, select `Manage` from the menu
  * Select `View All Users` to see a list of user accounts
  * Staff are able to create, edit, and delete volunteer accounts. Admin are able to create, edit, and delete all types of user accounts
  * Select `View All Events` to see a list of all event records created by all users. Staff and admin can edit and delete all event records
  * Select `View All Schools` to see a list of all schools and links to edit and delete schools: 
  * To add a new classroom to a school:
    - Select the school from the list of all schools
    - Select `Add Classroom` button located at the bottom of the school view page
    - Enter desired classroom info
    - Select `Create Classroom`
    

