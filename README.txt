------How to run the code------

1. This program uses Ruby version 2.4.0
2. Install related gems using the command 'bundle install'.
3. Change the directory into lib using 'cd lib/'.
4. To run the program just type the command 'ruby main.rb' in the terminal.
5. To run the automated tests at once, use the command 'bundle exec rspec spec'.

-------Algorithm Steps------

1. Get a random position in the matrix and check if its empty or else call the function recuresively.
2. If the selected position is free then check if the ship fits starting from that position (Depending on the direction).
3. If the ship doesn't fit in step 2 then get all the empty slots along the row. If space available on the row then place or else get empty slots along the column.
4. If step 3 fails then recursively call the function.
