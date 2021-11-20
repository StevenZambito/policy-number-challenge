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
      
      chars = map_characters(lines)
      digits_in_three_lines = chars.map { |c| (NUMBER_HASH[c] || "?") }
      
      # Adds the digits_in_three_lines array to all_policy_numbers
      all_policy_numbers.push(digits_in_three_lines)

    end
    all_policy_numbers.map(&:join)
  end

  def self.map_characters(lines)
    length_of_line = lines[0].length
    digits_in_three_lines = []

    starting_char = 0
    ending_char = 2
   
    until ending_char > length_of_line
      full_digit = ""
      lines.each{|l| 
        # Grabs characters from starting_char to ending_char (3 at a time)
        part_of_digit = l[starting_char..ending_char]
        full_digit = full_digit + part_of_digit
      }
      starting_char += 3
      ending_char += 3
      digits_in_three_lines.push(full_digit)
    end
    digits_in_three_lines
  end

  def self.calc_checksum(num)
    if num.include? "?"
      return "#{num} ILL" + "\n"
    end

    total = 0
    num.reverse.split("").each_with_index{|num, index| total+=(index + 1) * num.to_i}
    remainder = total % 11

    if remainder == 0
      "#{num}" + "\n"
    else
      "#{num} ERR" + "\n"
    end
  end

  def self.policies_to_file(policy_file, converted_policy_file)
    all_policy_nums = create_policy_number(policy_file)
    File.write(converted_policy_file, all_policy_nums.map{|num| calc_checksum(num)}.join)
  end

  policies_to_file('spec/fixtures/sample.txt', 'policy_numbers.txt')
end
