require 'open-uri'

class GamesController < ApplicationController
  def new
    letters = ('A'..'Z').to_a
    @sampled_new = []
    10.times do |_|
      @sampled_new << letters.sample
    end
    @sampled_new
  end

  def score
    @word = params[:guess]
    word_split = @word.split('')
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    serialize_dictionary = URI.open(url).read
    dictionary = JSON.parse(serialize_dictionary)
    # check if word belongs to the hash inside of what we parses
    check = true
    param_split = params[:array].split(" ")
    word_split.each do |letter|
      unless param_split.include?(letter)
        check = false
      end
    end
    if dictionary["found"] == true && check == true
      @result = "CONGRATS! #{@word} is a word found in #{params[:array]}"
    else
      @result = "SORRY"
    end
  end
end
