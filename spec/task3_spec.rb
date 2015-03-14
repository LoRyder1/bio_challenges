require_relative "../task3"

describe AnnotationLookup do 

	before { 	@file_coord = "sample_files/annotate/coordinates_to_annotate.txt" }
	before { 	@file_gtf = "sample_files/gtf/hg19_annotations.gtf" }

	let(:lookup) { AnnotationLookup.new(@file_coord, @file_gtf) }
	before { lookup.parse_files }

	describe '#parse_files' do 
		it "is defined" do 
			expect(AnnotationLookup.method_defined?(:parse_files)).to be true
		end
	end

	describe '#parse_coord_file' do 
		it "after parsing file parse coord file is not empty" do
			expect(lookup.parsed_coords).to_not be_empty
		end
		it "each element in array is Coord instance" do 
			expect(lookup.parsed_coords.sample).to be_instance_of(Coord)
		end
		it "Coord instance is made up of chr variable" do
			expect(lookup.parsed_coords.sample.chr).to include("chr")
		end
		it "Coord instance is also made up of coord variable" do
			expect(lookup.parsed_coords.sample.coord).to be_instance_of(Fixnum)
		end
	end
	describe '#parse_gtf_file' do 
		before { @gtf = lookup.parsed_gtf }
		it "after parsing file parsed gtf is not empty" do 
			expect(@gtf).to_not be_empty
		end
		it "each element in array is GTF instance" do
			expect(@gtf.sample).to be_instance_of(Gtf)
		end
		it "Gtf instance is made up of chr variable" do 
			expect(@gtf.sample.chr).to include("chr")
		end
		it "Gtf instance includes start coord" do 
			expect(@gtf.sample.start).to be_instance_of(Fixnum)
		end
		it "Gtf instance includes edge coord" do 
			expect(@gtf.sample.edge).to be_instance_of(Fixnum)
		end
		it "Gtf instance includes gene name" do 
			expect(@gtf.sample.gene_name).to be_instance_of(String)
		end
	end

	describe '#annotate' do
		before { lookup.annotate }
		it "annotate method should exist" do 
			expect(AnnotationLookup.method_defined?(:annotate)).to be true
		end
		it "get annot method should exist" do 
			expect(AnnotationLookup.method_defined?(:get_annot)).to be true
		end
		it "annotate adds gene name to coord file" do
			genes = []
			lookup.parsed_coords.each { |c| genes << c.gene_name }
			expect(genes.any?).to be true
		end
		it "should create filename" do 
			expect(File.exists? "annotation.txt").to be true
		end

	end
end
