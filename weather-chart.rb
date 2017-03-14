require 'paint'
require 'terminal-table'

system 'clear'

class Progress
  def initialize(qobject)
    @progress = 1
    @end = qobject.questions.length
  end

  attr_accessor :progress

  def showprogress
    puts "Day: #{@progress} / #{@end}"
    @progress = @progress + 1
  end
end

class Questions
  def initialize(questions)
    @qn = 0
    @questions = questions
    @questionarray = Array.new
  end

  attr_accessor :questions, :questionarray

  def ask_q(progressbar)
    rows = []
    @no = 0
    questions.length.times do
      progressbar.showprogress
      puts "What was the temperature on #{@questions[@no]}?"
      temp = gets.chomp.to_i

      if temp >= 30
        rows << [@questions[@no], Paint[temp, :red], Paint[((temp*9/5)+32), :red]]
      else
        rows << [@questions[@no], temp, ((temp*9/5)+32)]
      end

      @no = @no + 1
      system("clear")
    end

    table = Terminal::Table.new :headings => ['Day', 'Celcius', 'Fahrenheit'], :rows => rows
    puts "Below is your temperature table:"
    puts table
  end
end

days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]

questions = Questions.new(days)
progress = Progress.new(questions)

questions.ask_q(progress)
