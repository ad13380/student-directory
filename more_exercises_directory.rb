require 'csv'

@students = []
@default_file = "students.csv"

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  name = STDIN.gets.chomp
  while !name.empty? do
    append_students_array(name)
    puts "Now we have #{@students.count} students"
    name = STDIN.gets.chomp
  end
end

def append_students_array(name, cohort = "november")
  @students << {name: name, cohort: cohort.to_sym}
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_student_list
  @students.each { |student| puts "#{student[:name]} (#{student[:cohort]} cohort)" }
end

def print_footer
  puts "Overall, we have #{@students.count} great students"
end

def print_menu
  options = {
    "1": "Input the students",
    "2": "Show the students",
    "3": "Save list of students",
    "4": "Load list of students",
    "9": "Exit"
  }
  puts "-------------"
  options.each { |item_number,item| puts "#{item_number}. #{item}" }
end

def show_students
  print_header
  print_student_list
  print_footer
end

def save_data
  filename = filename_prompt("save to:")
  CSV.open(filename, "wb") do |line|
    @students.each { |student| line << [student[:name], student[:cohort]] }
  end
end

def check_file_exists(filename)
  if File.exists?(filename)
    return true
  else
    puts "Sorry, #{filename} doesn't exist"
    return false
  end
end

def load_data(filename)
  if check_file_exists(filename)
    CSV.foreach(filename) do |line|
      if line != ""
        name, cohort = line
        append_students_array(name, cohort)
      end
    end
    puts "[loaded #{CSV.read(filename).count} students from #{filename}]"
  end
end

def check_file_given
  return !ARGV.first.nil?
end

def startup_load
  if check_file_given
    load_data(ARGV.first)
  else
    load_data(@default_file)
  end
end

def filename_prompt(action)
  puts "Please enter the name of the file you wish to #{action}"
  return STDIN.gets.chomp
end

def process(selection)
  case selection
  when "1"
    input_students
    puts "[input sucessful]"
  when "2" then show_students
  when "3"
    save_data
    puts "[data saved]"
  when "4" then load_data(filename_prompt("load from:"))
  when "9"
    puts "[program ended]"
    exit
  else
    puts "I don't know what you meant, try again"
  end
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

startup_load
interactive_menu
