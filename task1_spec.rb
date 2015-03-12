require_relative "task1"

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
		it "should finde 2 fastq files" do 
			list.find_fastq_files
			count = list.files.count
			expect(count).to eq(2)
		end 

	end
end