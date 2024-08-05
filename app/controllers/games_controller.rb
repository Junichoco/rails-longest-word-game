require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = (0...15).map { ('a'..'z').to_a[rand(26)] }
  end

  def score
    @result = "You win"

    # if params[:input]
    url = "https://dictionary.lewagon.com/#{params[:input]}"
    serialized_user = URI.open(url).read
    user = JSON.parse(serialized_user)

    if user["found"] == false
      @result = "Not an English word"
    else
      params[:input].chars.uniq.each do |char|
        if params[:input].count(char.downcase) > params[:letters].count(char.downcase)
          @result = "Not in the grid"
        end
      end
    end
  end
end
