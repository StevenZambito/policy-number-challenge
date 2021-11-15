module PolicyOcr

  # Creates hash in order to convert pipes, underscores, & spaces to numbers
  # Keys are what the number would look like in string form (referencing sample.txt)
  NUMBER_HASH = {
    " _ | ||_|" => 0,
  
    "     |  |" => 1,
  
    " _  _||_ " => 2,
  
    " _  _| _|" => 3,
  
    "   |_|  |" => 4,
  
    " _ |_  _|" => 5,
  
    " _ |_ |_|" => 6,
  
    " _   |  |" => 7,
  
    " _ |_||_|" => 8,
  
    " _ |_| _|" => 9
  }

  def self.create_policy_number(policy_file)
    all_policy_numbers = []

    # Iterates through the file 4 lines at a time
    File.foreach(policy_file).each_slice(4) do |four_lines|

      # Grabs the first 3 lines in the current slice (discarding empty 4th line)
      lines = four_lines.first(3)
      # Gets length of line to know how many characters total are in each number
      length_of_line = lines[0].length
      
      starting_char = 0
      ending_char = 2
      
      digits_in_three_lines = []
      
      # Iterates through each line in the current slice and grabbing 3 characters at a time
      until ending_char > length_of_line
        full_digit = ""
        lines.each{|l| 
          # Grabs characters from starting_char to ending_char (3 at a time)
          part_of_digit = l[starting_char..ending_char]
          full_digit = full_digit + part_of_digit
        }

        # Increments starting and ending chars to continue along each line
        starting_char += 3
        ending_char += 3

        # Retrieves the value of the string from the NUMBER_HASH and adds to digits_in_three_lines array
        digits_in_three_lines.push(NUMBER_HASH[full_digit])
      end
      
      # Adds the digits_in_three_lines array to all_policy_numbers
      all_policy_numbers.push(digits_in_three_lines)

    end
    all_policy_numbers.map(&:join).map(&:to_i)
  end
end
