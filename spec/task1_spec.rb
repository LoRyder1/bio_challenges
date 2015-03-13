require_relative "../task1"

describe ListFastQ do 
	let(:list) { ListFastQ.new }
	before { list.find_fastq_files }

	describe '#find_fastq_files' do 
		it "is defined" do 
			expect(ListFastQ.method_defined?(:find_fastq_files)).to be true
		end
		it "finds fastq files and place them in an array" do 
			expect(list.files).to be_instance_of(Array)
		end
		it "should find 2 fastq files" do 
			count = list.files.count
			expect(count).to eq(2)
		end 
		it "every file in files should be an instance of class FileFastQ" do 
			file = list.files[0]
			expect(file).to be_instance_of(FileFastQ)
		end
	end

	describe '#get_percents' do
		it "is defined" do 
			expect(ListFastQ.method_defined?(:get_percents)).to be true
		end
	end

	describe '#display' do
		it "is defined" do 
			expect(ListFastQ.method_defined?(:display)).to be true
		end
	end
end

describe FileFastQ do 
	let(:list) { ListFastQ.new }
	before { list.find_fastq_files }
	before { list.get_percents }
	before { @file = list.files[0]}

	describe '#get_percent' do 
		it "is defined" do 
			expect(FileFastQ.method_defined?(:get_percent)).to be true
		end
		it "parses fastq file" do 
			expect(@file.file_by_line).to be_instance_of(Array)
		end
		it "after parses file_by_line should not be empty" do 
			expect(@file.file_by_line).to_not be_empty
		end
	end

	describe '#parse_fastq' do
		it "parse_fastq should be defined" do
			expect(FileFastQ.method_defined?(:parse_fastq)).to be true
		end
		it "after parsing all sequences array should not be empty" do
			expect(@file.all_seqs).to_not be_empty
		end
		it "after parsing expecting percent greater than 30 to be empty" do
			expect(@file.seqs_larger_30).to_not be_empty
		end
		it "expect seqs_larger_30 be less than all seqs" do 
			expect(@file.seqs_larger_30.count).to be < (list.files[0].all_seqs.count)
		end
	end

	describe '#percent' do 
		it "expects percent method to exist" do
			expect(FileFastQ.method_defined?(:percent)).to be true
  	end
  	it "should return the percent from two numbers" do
  		expect(@file.percent(10,40)).to equal 25.0
  	end
	end

end









