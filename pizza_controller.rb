require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative( './models/pizza_order' )
also_reload( './models/*' )

# This is the index route
get '/pizza-orders' do
  @pizzas = PizzaOrder.all()
  erb(:index)
end

# New order
get '/pizza-orders/new' do
  erb(:new)
end

# Show single order
get '/pizza-orders/:id' do
  id = params[:id].to_i
  @pizza_order = PizzaOrder.find(id)
  erb(:show)
end

post '/pizza-orders' do
  @new_order = PizzaOrder.new(params)
  @new_order.save()
  erb(:create)
end

post '/pizza-orders/:id/delete' do
  killpizza = PizzaOrder.find(params[:id])
  killpizza.delete()
  erb(:deleted)
end

post '/pizza-orders/:id/update' do
  @change_pizza = PizzaOrder.find(params[:id])
  erb(:update)
end

post '/pizza-orders/:id/change' do
  updated_pizza = PizzaOrder.new(params)
  updated_pizza.update()
  @pizzas = PizzaOrder.all()
  erb(:index)
end
