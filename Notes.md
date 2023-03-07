## Notes for Week 4 - Student Directory Excercises

**1. We're using the each() method to iterate over an array of students. How can you modify the program to print a number before the name of each student, e.g. "1. Dr. Hannibal Lecter"? Hint: look into each_with_index()**

```ruby
def print(students) 
  students.each_with_index do |student, index|  #changed from each to each_with_index, added index to pipe
    puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)" #added index + 1 before student name
  end
end
```
**2. Modify your program to only print the students whose name begins with a specific letter.**

<u>One solution:<u>

```ruby
def print(students)
  students.each_with_index do |student, index|
    if student[:name][0] == "D" #added this if statement within the code
      puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
end
```
<u>Second solution:</u>

```ruby
d_students = students.select { |student| student[:name].start_with?("D") } #pro of this solution is it doesn't change the print(students) method 
print(d_students) #change print(students) to this
```

**3. Modify your program to only print the students whose name is shorter than 12 characters.**

```ruby
def print(students)
  students.each do |student|
    if student[:name].length < 12 #added this if statement to filter names with less than 12 characters
      puts "#{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
end
```

**4. Rewrite the each() method that prints all students using while or until control flow methods (Loops).**

```ruby
def print(students)
  i = 0 #Initialize a counter variable i to 0.
  while i < students.length #Begins a while loop that will continue as long as i is less than the length of the students array. Can change while to until to get the same result
    student = students[i] #Assigns the i-th element of the students array to the student variable.
    puts "#{student[:name]} (#{student[:cohort]} cohort)" #Prints a formatted string that includes the student's name and cohort to the console.
    i += 1 #Increments the i variable by 1 to move to the next element in the students array.
  end
end
```

**Our code only works with the student name and cohort. Add more information: hobbies, country of birth, height, etc.**

<u>First modify the hash array to include more information:<u>

```ruby
students = [
  {name: "Dr. Hannibal Lecter", cohort: :november, hobbies: "cooking", country: "Lithuania", height: "6'0''"},
  {name: "Darth Vader", cohort: :november, hobbies: "lightsaber fighting", country: "Tatooine", height: "6'7''"},
  {name: "Nurse Ratched", cohort: :november, hobbies: "medication administration", country: "USA", height: "5'7''"},
  {name: "Michael Corleone", cohort: :november, hobbies: "business management", country: "Italy", height: "5'10''"},
  {name: "Alex DeLarge", cohort: :november, hobbies: "singing in the rain", country: "UK", height: "6'0''"},
  {name: "The Wicked Witch of the West", cohort: :november, hobbies: "flying on broomstick", country: "Oz", height: "5'11''"},
  {name: "Terminator", cohort: :november, hobbies: "time traveling", country: "USA", height: "6'2''"},
  {name: "Freddy Krueger", cohort: :november, hobbies: "haunting dreams", country: "USA", height: "5'11''"},
  {name: "The Joker", cohort: :november, hobbies: "clowning around", country: "USA", height: "6'1''"},
  {name: "Joffrey Baratheon", cohort: :november, hobbies: "cruelty", country: "Westeros", height: "5'7''"},
  {name: "Norman Bates", cohort: :november, hobbies: "taxidermy", country: "USA", height: "5'9''"}
]
```

<u>Then modify the print method to include the additional info:<u>

```ruby
def print(students)
  i = 0
  while i < students.length
    student = students[i]
    puts "#{student[:name]} (#{student[:cohort]} cohort) - Hobbies: #{student[:hobbies]}, Country: #{student[:country]}, Height: #{student[:height]}"
    i += 1
  end
end
```

**Research how the method center() of the String class works. Use it in your code to make the output beautifully aligned.**

```ruby
The center() method is a built-in method of the String class in Ruby. It allows you to center a string within a certain width by padding it with spaces on both sides.

For example, the following code will center the string "hello" within a width of 20 characters:
puts "hello".center(20) =                   hello  

You can adjust the width and add additional characters for padding. For example, the following code will center the string "hello" within a width of 30 characters and pad it with dashes:
puts "hello".center(30, '-')  = -----------hello------------

So for the code I did this:

def print_header
  puts "The students of Villains Academy".center(50)
  puts "-----------------".center(50)
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students".center(50)
end
```

**In the input_students method the cohort value is hard-coded. How can you ask for both the name and the cohort? What if one of the values is empty? Can you supply a default value? The input will be given to you as a string? How will you convert it to a symbol? What if the user makes a typo?**

Draft one without error handling: 

```ruby
def input_students
  puts "Please enter the name and cohort of each student, separated by a comma."
  puts "To finish, just hit return twice."
  students = []
  input = gets.chomp
  while !input.empty?
    input_array = input.split(',')
    name = input_array[0].strip
    cohort = input_array[1].nil? ? :november : input_array[1].strip.to_sym
    students << {name: name, cohort: cohort}
    puts "Now we have #{students.count} students"
    input = gets.chomp
  end
  students
end
```

In this modified method, we ask the user to enter the name and cohort of each student separated by a comma. We then split the input string on the comma to get the name and cohort values, and use the strip method to remove any leading or trailing whitespace. If no cohort is provided, we set a default value of :november. We convert the cohort value to a symbol using the to_sym method.

Final with error handling: 

```ruby
def input_students
  puts "Please enter the name and cohort of each student, separated by a comma"
  puts "To finish, just hit return twice"
  students = []
  loop do
    input = gets.chomp
    break if input.empty?
    name, cohort = input.split(",").map(&:strip)
    cohort = cohort.to_sym
    if cohort.empty?
      cohort = :november
    end
    while true
      case cohort
      when :january, :february, :march, :april, :may, :june, :july, :august, :september, :october, :november, :december
        students << { name: name, cohort: cohort }
        puts "Now we have #{students.count} student#{students.count == 1 ? '' : 's'}"
        break
      else
        puts "Invalid cohort. Please enter a valid cohort."
        cohort = gets.chomp.to_sym
      end
    end
  end
  students
end
```

If the cohort value is empty, it sets it to a default value of :november.

The method then uses a case statement to check if the cohort value is valid. If it is, it adds the student to the students array and prints a message indicating how many students have been added. If the cohort value is not valid, it prompts the user to enter a valid cohort value and continues until a valid value is entered.

**Once you complete the previous exercise, change the way the users are displayed: print them grouped by cohorts. To do this, you'll need to get a list of all existing cohorts (the map() method may be useful but it's not the only option), iterate over it and only print the students from that cohort.**

```ruby 
def print(students)
  cohorts = students.map { |student| student[:cohort] }.uniq
  cohorts.each do |cohort|
    puts "Students in the #{cohort} cohort:"
    students.select { |student| student[:cohort] == cohort }.each_with_index do |student, index|
      puts "#{index + 1}. #{student[:name]}"
    end
  end
end
```

First, we get a list of all the unique cohorts using map and uniq.
We iterate over each cohort and print the header with the cohort name.
We select only the students in the current cohort using select.
We print each student's name using each_with_index, with the index starting from 1.

**Right now if we have only one student, the user will see a message "Now we have 1 students", whereas it should be "Now we have 1 student". How can you fix it so that it uses the singular form when appropriate and plural form otherwise?**

Addded a conditional statement to check whether the count is equal to 1, and adjust the output accordingly. Here's an updated version of the input_students method with this modification:

```ruby
def input_students
  puts "Please enter the name and cohort of each student, separated by a comma"
  puts "To finish, just hit return twice"
  students = []
  loop do
    input = gets.chomp
    break if input.empty?
    name, cohort = input.split(",").map(&:strip)
    cohort = cohort.to_sym
    if cohort.empty?
      cohort = :november
    end
    while true
      case cohort
      when :january, :february, :march, :april, :may, :june, :july, :august, :september, :october, :november, :december
        students << { name: name, cohort: cohort }
        puts "Now we have #{students.count} #{students.count == 1 ? 'student' : 'students'}"
        break
      else
        puts "Invalid cohort. Please enter a valid cohort."
        cohort = gets.chomp.to_sym
      end
    end
  end
  students
end
```

**We've been using the chomp() method to get rid of the last return character. Find another method among those provided by the String class that could be used for the same purpose (although it will require passing some arguments).**

You could replace chomp with chop but that removes the final character.  Usually used when you know there's a unwanted last character like a comma.

You could used the strip method which seems to do the same but doesn't require passing arguments

The solution the question is looking for seems to be the slice method which is convuluted for this scenario but can see it useful in others.

```ruby
def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  students = []
  name = gets
  while name != "\n" do # ensures the last string entered is included in the results and ends the loop when blank new line is entered
    students << { name: name.slice(0..-2), cohort: :november }
    puts "Now we have #{students.count} students"
    name = gets
  end
  students
end
```

**What happens if the user doesn't enter any students? It will try to print an empty list. How can you use an if statement (Control Flow) to only print the list if there is at least one student in there?**

```ruby
def print(students)
  if students.any?
    students.each do |student|
      puts "#{student[:name]} (#{student[:cohort]} cohort)"
    end
  else
    puts "There are no students in the list"
  end
end
```

Here print method, the any? method is used to check whether the students array is not empty. If the array is not empty, the list of students will be printed using the each method. Otherwise, a message will be printed to indicate that there are no students in the list.