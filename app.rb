require 'haml'
require 'sinatra'

enable :sessions

get '/' do
  @scores = {}
  until @scores.length == 18
    if session[@scores.length + 1].nil?
      @scores[@scores.length + 1] = 0
    else
      @scores[@scores.length + 1] = session[@scores.length + 1]
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
  if integer? params[:score]
    @score = Integer params[:score]
    @hole_number = params[:hole_number]
    session[@hole_number] = @score
    redirect '/'
  else
    @error = "That is not a number"
    haml :score
  end
end

def integer?(object)
  true if Integer(object) rescue false
end