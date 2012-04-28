require 'haml'
require 'sinatra'

get '/' do
  @scores = { 1 => 3, 2 => 4, 3 => 3, 4 => 3, 5 => 1, 6 => 2, 7 => 3, 8 => 3, 9 => 5, 10 => 3, 11 => 2, 12 => 2, 13 => 1, 14 => 8, 15 => 3, 16 => 5, 17 => 4, 18 => 3 }
  @name = "Tim"
  haml :scorecard
end