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
    "3": "Save the list to students.csv",
    "4": "Load the list from students.csv",
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
  file = File.open(@default_file, "w")
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_data(filename = @default_file)
  file = File.open(filename,"r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(",")
    append_students_array(name, cohort)
  end
  file.close
end

def check_file_given
  return !ARGV.first.nil?
end

def check_file_exists(filename)
  return File.exists?(filename)
end

def startup_load
  if check_file_given
    if check_file_exists(ARGV.first)
      load_data(ARGV.first)
      puts "Loaded #{@students.count} students from #{ARGV.first}"
    else
      puts "Sorry, #{ARGV.first} doesn't exist"
    end
  else
    load_data
    puts "Loaded #{@students.count} students from default file: #{@default_file}"
  end
end

def process(selection)
  case selection
  when "1"
    input_students
    puts "[input sucessful]"
  when "2" then show_students
  when "3" then
    save_data
    puts "[data saved]"
  when "4" then load_data
  when "9" then
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
