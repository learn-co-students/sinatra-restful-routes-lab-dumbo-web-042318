require 'pry'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # Show all page
  get '/recipes' do
    @recipes = Recipe.all 
   
    erb :index
  end

  #Create new page
  get '/recipes/new' do

    erb :new
  end

  post '/recipes' do
    @recipe = Recipe.create(params["recipe"])
    
    redirect '/recipes'
  end

  #Show a current page
  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
 
    erb :show
  end

  #Update a current page
  get '/recipes/:id/edit' do 
    @recipe = Recipe.find(params[:id])
    
    erb :edit
  end

  patch '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    @recipe.update(params[:recipe])

    redirect "/recipes/#{@recipe.id}"
  end

  #Delete a page
  delete '/recipes/:id/delete' do 
    @recipe = Recipe.find(params[:id])
    @recipe.destroy 

    redirect '/recipes'
  end
end