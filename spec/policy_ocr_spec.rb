require_relative '../lib/policy_ocr'

describe PolicyOcr do
  it "loads" do
    expect(PolicyOcr).to be_a Module
  end

  it 'loads the sample.txt' do
    expect(fixture('sample').lines.count).to eq(44)
  end

  describe "create_policy_number" do
    context "'sample.txt' as input" do
      it "creates policy numbers from sample file" do
        expected_policy_numbers = 
        [
          "000000000", "111111111", "222222222", "333333333", 
          "444444444", "555555555", "666666666", "777777777", 
          "888888888", "999999999", "123456789"      
        ]
          expect(PolicyOcr.create_policy_number('spec/fixtures/sample.txt')).to eq(expected_policy_numbers)
      end

      it "outputs an array of integers" do
        result = PolicyOcr.create_policy_number('spec/fixtures/sample.txt')
        expect(result.all?{|num| num.is_a? String}).to be true
      end

      it "expected number of elements total (1 policy number per 4 lines)" do
        expect(PolicyOcr.create_policy_number('spec/fixtures/sample.txt').length).to eq(11)
      end
    end

    context "'varied_length_sample.txt'" do
      it "makes policy numbers for longer and shorter lines (more and less characters)" do
        result = PolicyOcr.create_policy_number('spec/fixtures/varied_length_sample.txt')
        expect(result[0].to_s.length).to eq(6)
        expect(result[1].to_s.length).to eq(11)
        expect(result[2].to_s.length).to eq(12)
      end
      it "creates policy numbers from sample file" do
        expected_policy_numbers = 
        [
          "123456", "12345678923", "123456789237"     
        ]
          expect(PolicyOcr.create_policy_number('spec/fixtures/varied_length_sample.txt')).to eq(expected_policy_numbers)
      end
    end
  end

  describe '#map_characters' do
    let(:mapped_characters) { [" _ | ||_|", " _  _| _|", " _ |_  _|"] }

    it "takes 3 lines and maps to array of 1st 3 characters of each line" do
      expect(PolicyOcr.map_characters([' _  _  _ ', '| | _||_ ', '|_| _| _|'])).to eq(mapped_characters)
    end
  end

  describe '#calc_checksum' do
    it "returns valid(num), invalid(num + ERR), or illegible(num + ILL) for a given policy number" do
      expect(PolicyOcr.calc_checksum("12345")).to eq("12345 ERR" + "\n")
      expect(PolicyOcr.calc_checksum("123456789")).to eq("123456789" + "\n")
      expect(PolicyOcr.calc_checksum("123?56789")).to eq("123?56789 ILL" + "\n")
    end
  end

  describe '#policies_to_file' do
    it "outputs policy numbers into a new file" do
      PolicyOcr.policies_to_file('spec/fixtures/sample.txt', 'policy_numbers.txt')
      created_file = File.open('policy_numbers.txt')
      expect(File.file?('policy_numbers.txt')).to be true
    end

    it "Outputs accurate policy numbers to file" do
      expected_policy_numbers = 
      [
        "000000000", "111111111 ERR", "222222222 ERR", "333333333 ERR", 
        "444444444 ERR", "555555555 ERR", "666666666 ERR", "777777777 ERR", 
        "888888888 ERR", "999999999 ERR", "123456789"      
      ]
      file_lines = File.readlines('policy_numbers.txt', chomp: true)
      expect(file_lines).to eq(expected_policy_numbers)
    end
  end
end
