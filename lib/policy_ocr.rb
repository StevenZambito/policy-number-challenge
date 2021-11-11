
module PolicyOcr
  file = File.open("../spec/fixtures/sample.txt")
  file_data = file.read

  lines = File.foreach("../spec/fixtures/sample.txt").first(4)



  zero = " _ \n| |\n|_|"
  two = " _ \n _|\n|_ "
  three = " _ \n _|\n _|"
  four = "|_|\n  |"
  five = " _ \n|_ \n _|"
  six = " _ \n|_ \n|_|"
  seven = " _ \n  |\n  |"
  eight = " _ \n|_|\n|_|"
  nine = " _ \n|_|\n _|"

end
