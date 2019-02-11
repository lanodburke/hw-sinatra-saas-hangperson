class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :word, :guesses, :wrong_guesses
  
  def initialize(word)
    @word, @guesses, @wrong_guesses = word, '', ''
  end
  
  def guess(letter)
    raise ArgumentError if !letter || letter.empty? || !letter.match(/[A-Za-z]/)

    letter.downcase!

    return false if @guesses.index(letter) || @wrong_guesses.index(letter)

    if word.index(letter)
      @guesses << letter
    else
      @wrong_guesses << letter
    end 
  end
  
  def word_with_guesses
    displayed = ''
    @word.each_char do |letter|
      if @guesses.index(letter)
        displayed << letter
      else
        displayed << '-'
      end
    end
    displayed
  end
  
  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
