# policy-number-challenge

## (P)roblem
Kin has just recently purchased an ingenious machine to assist in reading policy report documents. The machine scans the paper documents for policy numbers, and produces a file with a number of entries with each look like this:

```
   _  _     _  _  _  _  _ 
 | _| _||_||_ |_   ||_||_|
 ||_  _|  | _||_|  ||_| _|

 ```

Each entry is 4 lines long, and each line has 27 characters. The first 3 lines of each entry contain a policy number written using pipes and underscores, and the fourth line is blank. Each policy should have 9 digits, all of which should be in the range 0-9. A normal file contains around 500 entries.

Your first task is to write a program that can take this file and parse it into actual numbers.

***
## (E)xamples

Input:
```
    _  _     _  _  _  _  _ 
  | _| _||_||_ |_   ||_||_|
  ||_  _|  | _||_|  ||_| _|

 _  _  _  _  _  _  _  _  _ 
|_||_||_||_||_||_||_||_||_|
 _| _| _| _| _| _| _| _| _|
                        

```

Output:

[123456789, 999999999]

***
## (D)ata Structures

```
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
```

I used a Hash to be able to look up values easily to avoid writing several if statements.

***
## (A)lgorithm

* Get 4 lines of input
* Build up first digit
    * get characters 0-2 from the first line
    * Add them to characters 0-2 from the second line
    * Then add both to characters 0-2 from third line
    * This makes up a digit
    * Convert digit into an integer and add to an array
* Repeat process to the end of the lines --->
* Add the array of digits to another array that will house all policy numbers
* Repeat process for the next 4 lines and so on until all lines in file are processed
* Take array of all policy numbers (array of arrays) and map through them to join them together(turns them into a string) and then turn them back into an integer

***
## (C)ode

```
module PolicyOcr

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

    File.foreach(policy_file).each_slice(4) do |four_lines|

      lines = four_lines.first(3)
      length_of_line = lines[0].length
      
      starting_char = 0
      ending_char = 2
      
      digits_in_three_lines = []
      
      until ending_char > length_of_line
        full_digit = ""
        lines.each{|l| 
          part_of_digit = l[starting_char..ending_char]
          full_digit = full_digit + part_of_digit
        }

        starting_char += 3
        ending_char += 3

        digits_in_three_lines.push(NUMBER_HASH[full_digit])
      end

      all_policy_numbers.push(digits_in_three_lines)

    end
    all_policy_numbers.map(&:join).map(&:to_i)
  end
end
```


