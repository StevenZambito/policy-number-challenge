
module PolicyOcr
  file = File.open("../spec/fixtures/sample.txt")
  file_data = file.read

  lines = File.foreach("../spec/fixtures/sample.txt").first(3)

  numberHash = {
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

  counter = 0
  counteragain = 2

  until counteragain > 27
    full_digit = ""
    lines.each{|l| 

      part_of_digit = l[counter..counteragain]

      full_digit = full_digit + part_of_digit
    }
    counter+=3
    counteragain+=3

    puts numberHash[full_digit]
    
  end

end
