# frozen_string_literal: true

module AdventureNamer
  # The processing and generating engine.
  class Generator
    attr_reader :length, :start_pairs, :follow_letters

    # Creates a new builder, based upon a sample name file.
    #
    # @param data_file [String] The name of the file with sample names. Each
    #   file must contain a list of names, one word per line.
    def initialize(data_file)
      initialize_vars

      File.open(data_file, 'r') do |file|
        chars = chars_from_file file
        chars.push(chars[0], chars[1])

        (chars.length - 2).times do |i|
          build_start chars, i
          build_follow chars, i
        end
      end
    end

    # Builds a random name.
    #
    # @param seed [String] The base word for the name. Do not use this parameter
    #   unless you want to remove some of the randomization of the method.
    # @return [String] One random name based upon the sample name list.
    def generate(seed = nil)
      word = check_word(seed)

      last_pair = word[-2, 2]
      letter = @follow_letters[last_pair.to_s].slice(
        rand(@follow_letters[last_pair.to_s].length),
        1
      )

      grow_word(word, letter)
    end

    private

    def chars_from_file(file)
      file.read.chomp.downcase.gsub(/\s/, ' ').chars.to_a
    end

    def initialize_vars
      @start_pairs = []
      @follow_letters = Hash.new('')
      @length = {
        min: 5,
        max: 12
      }
    end

    def build_start(chars, iter)
      @start_pairs.push(chars[iter + 1, 2].join) if chars[iter] =~ /\s|\,|\.|\;/
    end

    def build_follow(chars, iter)
      k = chars[iter, 2].join
      @follow_letters[k] = @follow_letters[chars[iter, 2].join]
      @follow_letters[k] += chars[iter + 2, 1].join
    end

    def check_word(seed)
      if seed.nil?
        @start_pairs[rand start_pairs.length]
      else
        seed
      end
    end

    def grow_word(word, letter)
      ret = if (word.length <= @length[:min].to_i) || (rand(101) <= 30)
              if word.length >= @length[:max]
                word
              else
                generate(word + letter)
              end
            else
              word
            end

      ret.capitalize.gsub(/\s/, '')
    end
  end
end
