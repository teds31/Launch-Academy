require "sinatra"
require "pg"
require_relative "./app/models/article"
require 'pry'

set :bind, '0.0.0.0'  # bind to all interfaces
set :views, File.join(File.dirname(__FILE__), "app", "views")

configure :development do
  set :db_config, { dbname: "news_aggregator_development" }
end

configure :test do
  set :db_config, { dbname: "news_aggregator_test" }
end

def db_connection
  begin
    connection = PG.connect(Sinatra::Application.db_config)
    yield(connection)
  ensure
    connection.close
  end
end

# Put your News Aggregator server.rb route code here

get '/' do
  redirect "/articles"
end

get "/articles" do
  @articles = db_connection { |conn| conn.exec("SELECT title, description, url FROM articles") }
  erb :index
end

get '/articles/new' do
  erb :new
end

post "/articles" do
  @title = params[:title]
  @description = params[:description]
  @url = params[:url]
  db_connection do |conn|
    conn.exec_params("INSERT INTO articles (title, description, url) VALUES ($1, $2, $3)",
    [@title, @description, @url])
  end
  redirect "/articles"
end
