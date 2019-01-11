#!/usr/bin/env ruby
require 'digest/md5'
require './paint.rb'


class ColorUtilities


  # It gets the initial string from the user
  def self.get_full_name
    # Asks the name to the user
    print "Please type your full name:"

    # Stores the name in a variable
    full_name = gets.chomp

    # Stores the unique hexadecimal color in a variable by calling the static "get_hex_color_from_string" function
    unique_hex_color = get_hex_color_from_string(full_name)

    # Ir works with any kind of color format
    printf "Your unique color associated to your name is this: #{unique_hex_color} and it looks like this: " + Paint[full_name, unique_hex_color] + "\n"
  end


  # It gets a unique hexadecimal color from a provided string
  def self.get_hex_color_from_string(full_name)
    unique_hex_color = "#" + Digest::MD5.hexdigest(full_name)[0..5]

    # Returns the hex color in true color format (#xxxxxx)
    return unique_hex_color
  end


end

