require "tty-spinner"
require_relative "../modules/utils"

class Hangman
    include Utils

    attr_accessor :end
    attr_accessor :tries
    attr_accessor :right_choices
    attr_reader :word

    def initialize(tries = 3)
        @end = false
        @tries = tries
        @word = load_word
        @right_choices = []
    end

    def load(time = 2)
        system('clear')
        spinner = TTY::Spinner.new("[:spinner] Loading ...", format: :pulse_2)
        spinner.auto_spin
        sleep time
        spinner.stop("Done!")
    end

    def play
        load()
        until self.end
            render()

            print "Choice a character: "
            char = gets.chomp

            choice = choice_character(char)

            unless choice[:right]
                one_less_attempt()
            else
                set_right_choice(choice[:char])
            end

            verify(choice[:right])
        end
    end

    def choice_character(char)
        index = self.word.index(char)
        {index: index, char: char, right: index != nil}
    end

    def render
        system('clear')
        hashes = ("_ " * self.word.size).split(' ')

        self.right_choices.each do |char|
            hashes[self.word.index(char)] = char
        end

        puts "The word is -> #{hashes.join()}"
        puts ''
    end

    def set_right_choice(char)
        self.right_choices.push(char)
    end

    def one_less_attempt
        puts "Tries: #{self.tries}"
        if self.tries <= 0
            end_up("So sorry! try more one.")
        end
        self.tries -= 1
    end

    def verify(right_choice)
        if self.tries == 0
            puts "You Lose!"
            sleep 1
        elsif self.tries != 0 && !right_choice
            puts "Try again!"
            sleep 2
        end

        if self.word == self.right_choices.join()
            system('clear')
            puts "Congratulations! You WIN."
            self.end = true
        end
    end

    def end_up(text = "The End!")
        puts "So sorry! try more one."
        return self.end = true
    end
end
