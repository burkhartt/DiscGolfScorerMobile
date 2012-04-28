require 'haml'
require 'sinatra'

enable :sessions

get '/' do
  @scores = {}
  until @scores.length == 18
    index = @scores.length + 1

    if session[@scores.length + 1].nil?
      @scores[index] = 0
    else
      @scores[index] = session[index]
    end
  end

  @total = @scores.values.inject(:+)
  @name = "Tim"
  haml :scorecard
end

get '/hole/:hole_number/score' do
  @hole_number = params[:hole_number]
  @score = session[@hole_number]
  haml :score
end

get '/reset' do
  session.clear
  redirect '/'
end

post '/hole/:hole_number/score' do
  @score = Integer params[:score]
  @hole_number = params[:hole_number]
  session[@hole_number] = @score
  redirect '/'
end

def integer?(object)
  true if Integer(object) rescue false
end