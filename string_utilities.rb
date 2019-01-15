#!/usr/bin/env ruby
require 'digest/md5'
require './paint.rb'

# Math class is included in the Ruby Core
include Math


class StringUtilities


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

  # It obtaiins a string from the user to test the random rgb color generation
  def self.test_random_color
    # Asks the name to the user
    print "Please type any string:"

    # Stores the name in a variable
    full_name = gets.chomp

    # Stores the unique hexadecimal color in a variable by calling the static "generates_random_rgb_red_hue_color" function
    rgb_random_color = generates_random_rgb_red_hue_color

    # Ir works with any kind of color format
    printf "Your random red palette color is: #{rgb_random_color} and it looks like this: " + Paint[full_name, rgb_random_color] + "\n"
  end

  # It obtains the Patient id from the User (testing the "get_rgb_palette_color_from_id" function)
  def self.test_color_by_id
    # Asks the Patient id to the user
    print "Please type the Patient id:"

    # Stores the Patient id in a variable
    patient_id = gets.chomp

    # Asks for the name to the user (only for testing purposes)
    print "Please type your name:"

    # Stores the user's name in a variable
    user_name = gets.chomp

    # Gets the RGB color by the id
    # rgb_palette_color = get_rgb_palette_color_from_id(patient_id)

    # Converts the RGB color to hex color
    # hex_palette_color = rgb_to_hex(rgb_palette_color)

    # Gets directly the hex color from the patient id
    hex_palette_color = rgb_to_hex(get_rgb_palette_color_from_id(patient_id))

    # Ir works with rgb and hex color formats
    # printf "Hello #{user_name} with id = #{patient_id}. Your palette color is: #{rgb_palette_color} and it looks like this: " + Paint["000000", rgb_palette_color] + "\n"
    printf "Hello #{user_name} with id = #{patient_id}. Your palette color is: #{hex_palette_color} and it looks like this: " + Paint["000000", hex_palette_color.to_s] + "\n"
  end


  # ---------------------------------------------------- * * * Specific Functionalities * * * ---------------------------------------------------------------------


  # It generates a unique hexadecimal color from a provided string
  def self.get_hex_color_from_string(full_name)
    unique_hex_color = "#" + Digest::MD5.hexdigest(full_name)[0..5]

    # Returns the hex color in true color format (#xxxxxx)
    return unique_hex_color
  end

  # It generates a random RGB red palette color
  def self.generates_random_rgb_red_hue_color
    # The hue value of the red palette (30 degrees)
    h = 0;

    # Saturation level dark (random)
    s = Random.rand(50...100);

    # Value dark (random)
    v = Random.rand(50...100);

    # Converts the HSV random red hue color to rgb color
    rgb_random_color = hsv_to_rgb(h, s, v);

    return rgb_random_color
  end

  # It generates an rgb color, in a specific palette, from a provided Patient id
  def self.get_rgb_palette_color_from_id(patient_id)
    # Obtains the saturation and the value depending of the provided id
    sat_and_val_array = assign_sat_and_val_from_id(patient_id)

    # Gets the rightmost digit from the Patient id
    rightmost_digit = patient_id.to_i % 10

    # Depending of the righmost digit is the hue value to use for the rgb color...
    case rightmost_digit
    when 1
      # rgb_palette_color = hsv_to_rgb(0, saturation, value)
      rgb_palette_color = hsv_to_rgb(0, sat_and_val_array[0], sat_and_val_array[1])
    when 2
      # rgb_palette_color = hsv_to_rgb(30, saturation, value)
      rgb_palette_color = hsv_to_rgb(30, sat_and_val_array[0], sat_and_val_array[1])
    when 3
      # rgb_palette_color = hsv_to_rgb(60, saturation, value)
      rgb_palette_color = hsv_to_rgb(60, sat_and_val_array[0], sat_and_val_array[1])
    when 4
      # rgb_palette_color = hsv_to_rgb(120, saturation, value)
      rgb_palette_color = hsv_to_rgb(120, sat_and_val_array[0], sat_and_val_array[1])
    when 5
      # rgb_palette_color = hsv_to_rgb(150, saturation, value)
      rgb_palette_color = hsv_to_rgb(150, sat_and_val_array[0], sat_and_val_array[1])
    when 6
      # rgb_palette_color = hsv_to_rgb(180, saturation, value)
      rgb_palette_color = hsv_to_rgb(180, sat_and_val_array[0], sat_and_val_array[1])
    when 7
      # rgb_palette_color = hsv_to_rgb(210, saturation, value)
      rgb_palette_color = hsv_to_rgb(210, sat_and_val_array[0], sat_and_val_array[1])
    when 8
      # rgb_palette_color = hsv_to_rgb(240, saturation, value)
      rgb_palette_color = hsv_to_rgb(240, sat_and_val_array[0], sat_and_val_array[1])
    when 9
      # rgb_palette_color = hsv_to_rgb(270, saturation, value)
      rgb_palette_color = hsv_to_rgb(270, sat_and_val_array[0], sat_and_val_array[1])
    when 0
      # rgb_palette_color = hsv_to_rgb(330, saturation, value)
      rgb_palette_color = hsv_to_rgb(330, sat_and_val_array[0], sat_and_val_array[1])
    end

    return rgb_palette_color
  end


  def self.assign_sat_and_val_from_id(patient_id)
    # sat takes values from 50 until 100
    # val takes values from 50 until 99
    #
    # Smaller than 2 500 (very usual)
    if (patient_id.to_i < 2500)

      sat = (patient_id.to_i / 50) + 50
      val = (patient_id.to_i % 50) + 50

    else # Not smaller than 2500 (several cases)

      # Equal to 2 500
      if (patient_id.to_i == 2500)

        sat = 100
        val = 100

      else # Bigger than 2500

        if (patient_id.to_i % 2500 == 0) # Multiplum of 2500 (Ex: 5 000, 7 500. 10 000, etc, etc)

          sat = 100
          val = 100

        else # Bigger than 2 500 AND not multiple of 2 500 (usual)

          return assign_sat_and_val_from_id(patient_id.to_i / 2500)

        end

      end

    end

    # Returns the saturation and value
    return sat, val

  end


  # ---------------------------------------------------- * * * Common Functionalities * * * ----------------------------------------------------------------------


  # It converts an HSV color into a RGB color
  def self.hsv_to_rgb(h, s, v)
    h, s, v = h.to_f / 360, s.to_f / 100, v.to_f / 100
    h_i = (h * 6).to_i
    f = h * 6 - h_i
    p = v * (1 - s)
    q = v * (1 - f * s)
    t = v * (1 - (1 - f) * s)
    r, g, b = v, t, p if h_i == 0
    r, g, b = q, v, p if h_i == 1
    r, g, b = p, v, t if h_i == 2
    r, g, b = p, q, v if h_i == 3
    r, g, b = t, p, v if h_i == 4
    r, g, b = v, p, q if h_i == 5
    [(r * 255).to_i.abs, (g * 255).to_i.abs, (b * 255).to_i.abs]
  end

  # It converts an RGB color into a hexadecimal/hex6 (aka hex) color
  def self.rgb_to_hex(rgb_palette_color)
    return "#" + rgb_palette_color[0].to_s(16) + rgb_palette_color[1].to_s(16) + rgb_palette_color[2].to_s(16)
  end


end

