class SessionsView
  def ask_user_for(something)
    puts "Please type your #{something}"
    print '> '
    gets.chomp
  end

  def wrong_credentials
    puts ''
    puts 'Wrong credentials, please try again...'
    puts ''
  end

  def display(employees)
    employees.each_with_index do |employee, index|
      puts "#{index + 1}. #{employee.username}"
    end
  end
end
