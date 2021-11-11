module PolicyOcr

  number_hash = {
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

  all_policy_numbers = []

  File.foreach("../spec/fixtures/sample.txt").each_slice(4) do |four_lines|

    lines = four_lines.first(3)
    length_of_line = lines[0].length
    
    starting_char = 0
    ending_char = 2
    
    digits_in_four_lines = []
    
    until ending_char > length_of_line
      full_digit = ""
      lines.each{|l| 
        part_of_digit = l[starting_char..ending_char]

        full_digit = full_digit + part_of_digit
      }
      starting_char += 3
      ending_char += 3
      digits_in_four_lines.push(number_hash[full_digit])
    end

    all_policy_numbers.push(digits_in_four_lines)

  end
  print all_policy_numbers
end


