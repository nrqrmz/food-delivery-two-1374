# TODO: implement the router of your app.

class Router
  def initialize(meals_controller, customers_controller, sessions_controller, orders_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @sessions_controller = sessions_controller
    @orders_controller = orders_controller
    @running = true
  end

  def run
    print_welcome
    while @running
      @current_user = @sessions_controller.login
      while @current_user
        if @current_user.manager?
          route_manager
        else
          route_rider
        end
      end
    end
  end

  private

  def print_welcome
    puts '-' * 30
    puts "Welcome to Food Delivery [2.0]"
    puts '-' * 30
  end

  def manager_menu
    puts ''
    puts 'What do you want to do?'
    puts '1 - List all meals'
    puts '2 - Add a new meal'
    puts '3 - List all customers'
    puts '4 - Add a new customer'
    puts '5 - List all orders'
    puts '6 - Add a new order'
    puts '7 - Logout'
    puts '8 - Quit'
    print '> '
    gets.chomp.to_i
  end

  def rider_menu
    puts ''
    puts 'What do you want to do?'
    puts '1 - List all my undelivered orders'
    puts '2 - Mark an order as delivered'
    puts '3 - Logout'
    puts '4 - Quit'
    print '> '
    gets.chomp.to_i
  end

  def dispatch_manager(action)
    case action
    when 1 then @meals_controller.list
    when 2 then @meals_controller.add
    when 3 then @customers_controller.list
    when 4 then @customers_controller.add
    when 5 then @orders_controller.list_undelivered_orders
    when 6 then @orders_controller.add
    when 7 then logout
    when 8 then stop
    else
      puts 'Please type a valid option'
    end
  end

  def dispatch_rider(action)
    case action
    when 1 then @orders_controller.list_my_orders(@current_user)
    when 2 then @orders_controller.mark_as_delivered(@current_user)
    when 3 then logout
    when 4 then stop
    else
      puts 'Please type a valid option'
    end
  end

  def route_manager
    action = manager_menu
    print `clear`
    dispatch_manager(action)
  end

  def route_rider
    action = rider_menu
    print `clear`
    dispatch_rider(action)
  end

  def logout
    @current_user = nil
  end

  def stop
    logout
    @running = false
  end
end
