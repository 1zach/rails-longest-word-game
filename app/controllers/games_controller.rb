require 'open-uri'

class GamesController < ApplicationController

    def new
        @letters = ('a'..'z').to_a
        @randomLetters = @letters.sample(10)
    end

    def score
        @guess = params[:longest]
        @guess = @guess.split('')
        @randomLetters = params[:randomLetters]
        @randomLetters = @randomLetters.split('')
        @guess.each do |letter| 
            if @randomLetters.include?(letter)
                uri = URI.open("https://wagon-dictionary.herokuapp.com/#{@guess.join}")
                json = JSON.parse(uri.read)
                if json["found"]
                    @checkValid = "#{@guess.join.capitalize}"
                else
                    @checkNotWord = "#{@guess.join.capitalize}"
                end
            else
                @checkInvalid = "'#{@randomLetters.join}' does not contain #{@guess.join}"
                break
            end
        end
    end
end
