require_relative "../task2"

describe Frequency do 
	before { @file = "sample_files/fasta/sample.fasta" }
	let(:fasta) { Frequency.new(@file) }
	before { fasta.get_freq }

	describe '#get_freq' do 
		it "is defined" do 
			expect(Frequency.method_defined?(:get_freq)).to be true
		end
	end

	describe 'parse' do 

		it "parses file by odd line and puts in array" do 
			expect(fasta.parsed).to be_instance_of(Array)
		end
		it "only accepts strings of sequences" do
			expect(fasta.parsed.sample).to be_instance_of(String)
		end
		it "only accpets character from A-Z" do
			expect(/[^A-Z]/.match(fasta.parsed.sample)).to equal nil
		end
	end

	describe '#get_occurence' do
		before { @hash = fasta.freq } 

		it "gets the frequencies of the sequences in the file" do
			expect(fasta.freq).to be_instance_of(Hash)
		end
		it "in freq hash key is a string" do
			expect(@hash.keys.sample).to be_instance_of(String)
		end
		it "in freq hash value is a number" do 
			expect(@hash.values.sample).to be_instance_of(Fixnum)
		end
	end

	describe '#sort_top10_freq' do

		it "gathers top 10 frequencies from freq hash" do 
			expect(fasta.top10.count).to equal 10
		end
		it "sorts the frequency hash" do 
			expect(fasta.top10.values.first).to be > (fasta.top10.values[1])
		end
	end

end



