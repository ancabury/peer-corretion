## PEER CORRECTION

This is a platform where the users perform peer correction on the papers they upload. It aims to simplify the way a teacher manages assignments. The students have the option to upload/download papers and grade papers from other students. When logging in the user immediately knows if he has corrections to perform. He can access the list of all the papers, but can see only he's grades.

The teacher is responsible with assigning students to correct some paper. He can see all papers which where uploaded with their grade. When accessing the users page he sees a users score, which is calculated based on the grades a user has on the papers he uploaded. Only the proffessor can delete a paper.

### Project requirements
- rvm
- ruby 2.2.1
- rails 4.2.4
- postgresql

### Installation Steps
1. Clone project
2. Install gems: `bundle install`
3. Install postgresql `sudo apt-get install postgresql postgresql-contrib`
  *create a new user with username and password (optional)
4. Configure project db
  Make a new file: `config/database.yml` following the example in `config/database.yml.example` using the username and  password created before
5. Configure project secret tokens
    Make a new file: `config/secrets.yml` following the example in `config/secrets.yml.example` using the `rake secret` command generate two secret tokens
6. Create and migrate the database
  `rake db:create
    rake db:migrate`

