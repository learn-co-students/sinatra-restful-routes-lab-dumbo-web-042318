class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  #index
  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  #new
  get '/recipes/new' do
    erb :new
  end

  #show
  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    erb :show
  end

  #create
  post '/recipes' do
    recipe = Recipe.create(params)

    redirect "/recipes/#{recipe.id}"
  end

  #edit
  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])
    erb :edit
  end

  #update
  patch '/recipes/:id' do
    recipe = Recipe.find(params[:id])
    copy = params.dup
    copy.delete("_method")
    copy.delete("id")
    recipe.update(params)

    redirect "/recipes/#{recipe.id}"
  end

  #delete
  delete '/recipes/:id/delete' do
    @recipe = Recipe.find(params[:id])
    @recipe.destroy

    redirect "/recipes"
  end
end
