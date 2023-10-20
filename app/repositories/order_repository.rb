require 'csv'
require_relative '../models/order'
# require 'pry-byebug'

class OrderRepository
  def initialize(csv_file, meal_repository, customer_repository, employee_repository)
    @csv_file = csv_file
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @orders = [] # in-memory
    @next_id = 1

    load_csv if File.exist?(@csv_file)
  end

  def create(order)
    order.id = @next_id
    @orders << order
    @next_id += 1

    save_csv
  end

  def undelivered_orders
    @orders.reject { |order| order.delivered? }
  end

  def my_pending_orders(rider)
    undelivered_orders.select { |order| order.employee == rider }
  end

  def deliver_order(order)
    order.deliver!

    save_csv
  end

  private

  def save_csv
    CSV.open(@csv_file, 'wb') do |csv|
      csv << %w[id delivered meal_id customer_id employee_id]
      @orders.each do |order|
        csv << [order.id, order.delivered, order.meal.id, order.customer.id, order.employee.id]
      end
    end
  end

  def load_csv
    CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |row|
      order_id = row[:id].to_i
      delivered = row[:delivered] == 'true'
      meal = @meal_repository.find(row[:meal_id].to_i)
      customer = @customer_repository.find(row[:customer_id].to_i)
      employee = @employee_repository.find(row[:employee_id].to_i)
      order = Order.new(id: order_id, delivered: delivered, meal: meal, customer: customer, employee: employee)
      @orders << order
    end
    @next_id = @orders.last.id + 1 unless @orders.empty?
  end
end
