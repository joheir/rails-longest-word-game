require 'json'
require 'open-uri'
class GamesController < ApplicationController
  def new
    size = rand(5..10)
    @letters = Array.new(size) { ('A'..'Z').to_a.sample }
  end

  def score
    word = params[:word]
    if valid_word?(word)
      if english_word?(word)
        @display = "Congratulations, #{word} is a valid english word!"
      else
        @display = "Sorry, but #{word} does not seem to be an english word"
      end
    else
      @display = "Sorry, but #{word} can not be built out of #{params[:grid]}"
    end
  end

  def valid_word?(word)
    letters = params[:grid].split
    word.upcase.split("").all? { |letter| word.upcase.split("").count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    results = JSON.parse(URI.open(url).read)
    results['found']
  end
end
