
require_relative '../../config/environment'

require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    @articles = Article.all
    erb :index
  end

  get '/articles/new' do 
    erb :new
  end

  get '/articles' do 
    @articles = Article.all
    erb :index
  end

  post '/articles' do 
    @article = Article.create(title: params[:title], content: params[:content])
    # binding.pry
    redirect "/articles/#{@article.id}"
  end
  
  get '/articles/:id' do 
    id = params[:id]
    @article = Article.find(id)
    erb :show
  end

  get '/articles/:id/edit' do 
    @article = Article.find(params[:id])
    erb :edit
  end

  patch '/articles/:id' do 
    @article = Article.find(params[:id])
    # binding.pry
    @article.update(title: params[:title], content: params[:content])
    redirect "/articles/#{@article.id}"
  end

  delete '/articles/:id' do 
    Article.find(params[:id]).destroy
    redirect '/articles'
  end

end
