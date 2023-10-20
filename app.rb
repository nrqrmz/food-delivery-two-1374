# TODO: require relevant files to bootstrap the app.
# Then you can test your program with:
#   ruby app.rb

require_relative './router'
require_relative 'app/controllers/meals_controller'
require_relative 'app/repositories/meal_repository'

require_relative 'app/controllers/customers_controller'
require_relative 'app/repositories/customer_repository'

require_relative 'app/controllers/sessions_controller'
require_relative 'app/repositories/employee_repository'

require_relative 'app/controllers/orders_controller'
require_relative 'app/repositories/order_repository'

meal_repository = MealRepository.new(File.join(__dir__, 'data/meals.csv'))
meals_controller = MealsController.new(meal_repository)

customer_repository = CustomerRepository.new(File.join(__dir__, 'data/customers.csv'))
customers_controller = CustomersController.new(customer_repository)

employee_repository = EmployeeRepository.new(File.join(__dir__, 'data/employees.csv'))
sessions_controller = SessionsController.new(employee_repository)

order_repository = OrderRepository.new(File.join(__dir__, 'data/orders.csv'), meal_repository, customer_repository, employee_repository)
orders_controller = OrdersController.new(meal_repository, customer_repository, employee_repository, order_repository)

router = Router.new(meals_controller, customers_controller, sessions_controller, orders_controller)
router.run
