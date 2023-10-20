class OrdersView
  def ask_user_for_index
    puts 'Index?'
    print '> '
    gets.chomp.to_i - 1
  end

  def display(orders)
    orders.each_with_index do |order, index|
      puts "#{index + 1}. #{order.employee.username} is delivering #{order.meal.name} to #{order.customer.name}"
    end
  end
end
