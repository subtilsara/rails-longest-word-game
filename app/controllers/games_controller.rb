require "json"
require "open-uri"

class GamesController < ApplicationController

  def new
    @letters = ("a".."z").to_a.sample(10)
    @letters.join('')
  end

  def score
    @type_word = params[:type_word]
    letter = params [:letter]
    grid = params [:letters]
    user_input = @type_word.chars.all? do |letter|
      grid.count(letter) >= @type_word.count(letter)
    end
    if !user_input
      @answer ="This Letter is not included"
    elsif !realword?(@type_word)
      @answer =  "this is not an English word"
    end
  end

  def realword?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    uri = open(url)
    hash = JSON.parse(uri.read)
    hash['found']
  end
end
