
module PolicyOcr
  file = File.open("../spec/fixtures/sample.txt")
  file_data = file.read
  puts file_data
end
