class StepFourteen
  def greet
    puts "Hello, this file reads and prints it's own sourcecode, like so:\n\n"
  end
end

ObjectFourteen = StepFourteen.new
ObjectFourteen.greet

puts File.read(__FILE__)
