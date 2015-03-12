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
	list.find_fastq_files
	list.get_percents

	describe '#'



end









