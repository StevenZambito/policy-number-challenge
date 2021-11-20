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
          000000000, 111111111, 222222222, 333333333, 
          444444444, 555555555, 666666666, 777777777, 
          888888888, 999999999, 123456789      
        ]
          expect(PolicyOcr.create_policy_number('spec/fixtures/sample.txt')).to eq(expected_policy_numbers)
      end

      it "outputs an array of integers" do
        result = PolicyOcr.create_policy_number('spec/fixtures/sample.txt')
        expect(result.all?{|num| num.is_a? Integer}).to be true
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
          123456, 12345678923, 123456789237     
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
end
