require_relative '../views/meals_view'
require_relative '../views/customers_view'
require_relative '../views/sessions_view'
require_relative '../views/orders_view'

class OrdersController
  def initialize(meal_repository, customer_repository, employee_repository, order_repository)
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @order_repository = order_repository
    @meals_view = MealsView.new
    @sessions_view = SessionsView.new
    @customers_view = CustomersView.new
    @orders_view = OrdersView.new
  end

  def add
    meal = select_meal
    customer = select_customer
    employee = select_employee
    order = Order.new(meal: meal, customer: customer, employee: employee)
    @order_repository.create(order)
  end

  def list_undelivered_orders
    orders = @order_repository.undelivered_orders
    @orders_view.display(orders)
  end

  def list_my_orders(rider)
    orders = @order_repository.my_pending_orders(rider)
    @orders_view.display(orders)
  end

  def mark_as_delivered(rider)
    orders = @order_repository.my_pending_orders(rider)
    list_my_orders(rider)
    index = @orders_view.ask_user_for_index
    order = orders[index]
    @order_repository.deliver_order(order)
  end

  private

  def select_meal
    meals = @meal_repository.all
    @meals_view.display(meals)
    index = @orders_view.ask_user_for_index
    meals[index]
  end

  def select_customer
    customers = @customer_repository.all
    @customers_view.display(customers)
    index = @orders_view.ask_user_for_index
    customers[index]
  end

  def select_employee
    employees = @employee_repository.all_riders
    @sessions_view.display(employees)
    index = @orders_view.ask_user_for_index
    employees[index]
  end
end
