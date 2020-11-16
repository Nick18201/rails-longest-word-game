class GamesController < ApplicationController
  def new
    # stuff
    range = ('A'..'Z').to_a
    @letters = Array.new(10) { range.sample }
  end

  def include?(word, letters)
    # raise
    word.all? do |letter|
      word.count(letter) <= letters.count(letter)
    end
  end

  def in_dictionnary?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    word_serialized = open(url).read
    word_parsed = JSON.parse(word_serialized)
    word_parsed['found']
  end

  def score
    word = params[:word]
    @letters = params[:letters]
    @word = word.upcase.split('')
    if include?(@word, @letters) == false
      @answer = "Not in the grid"
    elsif in_dictionnary?(word) == false
      @answer = "Not an English word"
    else
      @answer = "Well done"
    end
  end
end
