require_relative "../task1"

describe ListFastQ do 
	let(:list) { ListFastQ.new }

	describe '#find_fastq_files' do 
		it "is defined" do 
			expect(ListFastQ.method_defined?(:find_fastq_files)).to be true
		end
		it "finds fastq files and place them in an array" do 
			list.find_fastq_files
			expect(list.files).to be_instance_of(Array)
		end
		it "should find 2 fastq files" do 
			list.find_fastq_files
			count = list.files.count
			expect(count).to eq(2)
		end 
		it "every file in files should be an instance of class FileFastQ" do 
			list.find_fastq_files
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

	
	describe '#get_percent' do 
		it "is defined" do 
			expect(FileFastQ.method_defined?(:get_percent)).to be true
		end
		it "parses fastq file" do 
			expect(list.files[0].file_by_line).to be_instance_of(Array)
		end
		it "after parses file_by_line should not be empty" do 
			expect(list.files[0].file_by_line).to_not be_empty
		end
		it "parse_fastq should be defined" do
			expect(FileFastQ.method_defined?(:parse_fastq)).to be true
		end
		it "after parsing all sequences array should not be empty" do
			expect(list.files[0].all_seqs).to_not be_empty
		end
		it "after parsing expecting percent greater than 30 to be empty" do
			expect(list.files[0].seqs_larger_30).to_not be_empty
		end
		it "expect seqs_larger_30 be less than all seqs" do 
			expect(list.files[0].seqs_larger_30.count).to be < (list.files[0].all_seqs.count)
		end
	end

	describe '#percent' do 
		it "expects 2 arguments" do
    	method(:percent).arity.should eq 2
  	end
	end

end









