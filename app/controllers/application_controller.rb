class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # Index Route
  get "/recipes" do
    @recipes = Recipe.all

    erb :index
  end

  # New Route
  get "/recipes/new" do
    erb :new
  end

  # Create Route
  post "/recipes" do
    @recipe = Recipe.create(params)

    redirect "/recipes/#{Recipe.last.id}"
  end

  #Edit Route
  get "/recipes/:id/edit" do
    @recipe = Recipe.find(params[:id])

    erb :edit
  end

  #Show Route
  get "/recipes/:id" do
    @recipe = Recipe.find(params[:id])

    erb :show
  end

  # Update Route
  patch "/recipes/:id" do
    @recipe = Recipe.find(params[:id])
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save

    redirect "/recipes/#{@recipe.id}"
  end

  # Delete Route
  delete "/recipes/:id/delete" do
    @recipe = Recipe.find(params[:id])
    @recipe.destroy

    redirect "/recipes"
  end

end
