class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  ##index page
  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end
  
  ##new - contains form to create
  get '/recipes/new' do
    erb :new
  end 

  ##create
  post '/recipes' do
    @recipe = Recipe.create(params)
    redirect "/recipes/#{@recipe.id}"
  end

  ##show
  get '/recipes/:id' do
    @recipe = Recipe.find(params["id"])
    erb :show
  end 


  ##edit - contains form to edit
  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params["id"])
    erb :edit
  end 

  ##update
  patch '/recipes/:id' do
    @recipe = Recipe.find(params["id"])
    @recipe.update(new_copy_recipe)
    redirect "/recipes/#{@recipe.id}"
  end 

  ##delete
  delete '/recipes/:id/delete' do
    @recipe = Recipe.find(params["id"])
    @recipe.destroy
    redirect '/recipes'
  end 

  private
  def new_copy_recipe
    params_copy = params.dup
    params_copy.delete "id"
    params_copy.delete "_method"
    params_copy
  end 

end