students = [
  {name: "Dr. Hannibal Lecter", cohort: :november},
  {name: "Darth Vader", cohort: :november},
  {name: "Nurse Ratched", cohort: :november},
  {name: "Michael Corleone", cohort: :november},
  {name: "Alex DeLarge", cohort: :november},
  {name: "The Wicked Witch of the West", cohort: :november},
  {name: "Terminator", cohort: :november},
  {name: "Freddy Krueger", cohort: :november},
  {name: "The Joker", cohort: :november},
  {name: "Joffrey Baratheon", cohort: :november},
  {name: "Norman Bates", cohort: :november}
]

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

def print_header
  puts "The students of Villians Academy".center(50)
  puts "-----------------".center(50)
end

def print(students)
  cohorts = students.map { |student| student[:cohort] }.uniq
  cohorts.each do |cohort|
    puts "Students in the #{cohort} cohort:"
    students.select { |student| student[:cohort] == cohort }.each_with_index do |student, index|
      puts "#{index + 1}. #{student[:name]}"
    end
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students".center(50)
end

students = input_students

print_header
print(students)
print_footer(students)