# chr3	refFlat	exon	134196546	134197558	.	-	.	gene_id "ANAPC13"; transcript_id "NM_001242374"; exon_number "3"; exon_id "NM_001242374.1"; gene_name "ANAPC13";	

# chr12	20704380

#------- Notes ----------- 

# GTF - gene transfer format 
# Structure of GFF - seq name, source, feature, start, end, score, strand, frame, [attributes][comments]

# an annotation is metadata(e.g. a comment, explanation, presentational markup)
# DNA annotation or genome annotation is the process of identifying the locations of genes and all of the coding regions in a genome and determining what those genes do. 

#------- Pseudocode --------------

# 1. create a class that will do all the lookup and accept two files: a)coord_file and b)gtf_file
# 2. parse files one by one, each a) is an instance of the Coord class, and each b) is an instance of Gtf class
# 3. next get a range of annotations that match chromosomes with coordinates
# 4. for each coordinate match with the correct gtf annotation by using include method = nested each loop
# 5. if there is a match update coordinate with gene name from gtf file
# 6. create a new file and put in coord info with matched gene name


#---------- Coding TASK -----------

# 3)	Given a chromosome and coordinates, write a program for looking up its annotation.  Keep in mind you'll be doing this annotation millions of times.
# 	-	Input: 
# 		o	Tab-delimited file: Chr<tab>Position
# 		o	GTF formatted file with genome annotations.
# 	-	Output: 
# 		o	Annotated file of gene name that input position overlaps.
# 	-	Hint: Most of the sequence reads come from a small portion of the genome. Try to use this information to improve performance, if possible.


#------------ Code ------------------


class AnnotationLookup
	attr_reader :parsed_coords, :parsed_gtf
	def initialize(coord_file, gtf_file)
		@coord_file = File.open(coord_file)
		@gtf_file = File.open(gtf_file)
		@parsed_coords = []
		@parsed_gtf = []
	end

	def parse_files
		parse_coord_file
		parse_gtf_file
	end

	def parse_coord_file
		@coord_file.each do |line|
			coord = line.split("\t")
			parsed_coords	<< Coord.new(coord)
		end
	end

	def parse_gtf_file
		@gtf_file.each do |line|
			gtf = line.split("\t")
			parsed_gtf << Gtf.new(gtf)
		end
	end

	def coord_range
		range = []
		parsed_coords.each { |coordinate| range << coordinate.chr }
		range.uniq
	end

	def gtf_range
		range = []
		uniq_chr = coord_range
		parsed_gtf.each do |gtf|
			range << gtf if uniq_chr.include?(gtf.chr) == true
		end
		range
	end

	def get_annot
		range = gtf_range
		parsed_coords.each do |coordinate|
			target = coordinate.coord
			range.each do |gtf|
				s = gtf.start
				e = gtf.edge
				if (s..e).include?(target) == true
			 		coordinate.add_annot(gtf.gene_name)
			 	end	
			end
		end
	end

	def annotate
		get_annot
		File.new("annotation.txt",  "w+")
		File.open("annotation.txt", 'w') do |file| 
			parsed_coords.each { |c| file << "#{c.chr} #{c.coord} #{c.gene_name}\n" }
		end
		system("open", "annotation.txt")
	end

end

class Coord
	attr_reader :chr, :coord, :gene_name
	def initialize(coordinate)
		@chr = coordinate[0]
		@coord = coordinate[1].strip.to_i
		@gene_name = nil
	end

	def add_annot(gtf_gene_name)
		@gene_name = gtf_gene_name
	end
end

class Gtf
	attr_reader :chr, :start, :edge, :gene_name
	def initialize(gtf)
		@chr = gtf[0]
		@start = gtf[3].to_i
		@edge = gtf[4].to_i
		@gene_name = parse_attributes(gtf[8])["gene_name"]
	end

	def parse_attributes(string)
		parsed = string.gsub!(/[^\w|\.]/,',').split(",")
		parsed.delete("")
		Hash[parsed.each_slice(2).to_a]
	end

end

# file_gtf = test.gtf uses only 100,000 annotations out of 800,000+

if ARGV[0] == nil
	puts "to annotate ENTER: 'ruby task3.rb annotate'"
else
	file_coord = "sample_files/annotate/coordinates_to_annotate.txt"
	# file_gtf = "sample_files/gtf/hg19_annotations.gtf"
	file_gtf = "sample_files/gtf/test.gtf"
	lookup = AnnotationLookup.new(file_coord, file_gtf)
	if ARGV[0] == "annotate"
		lookup.parse_files
		lookup.annotate
	else
		puts "ENTER: 'ruby task3.rb annotate' "
	end
end




# file_coord = "sample_files/annotate/coordinates_to_annotate.txt"
# # file_gtf = "sample_files/gtf/hg19_annotations.gtf"
# file_gtf = "sample_files/gtf/test.gtf"
# lookup = AnnotationLookup.new(file_coord, file_gtf)

# # p lookup

# lookup.parse_coord_file
# # p lookup.parsed_coords

# lookup.parse_gtf_file

# lookup.get_annot
# p lookup.parsed_coords

# lookup.annotate

# p lookup.coord_range
# p lookup.gtf_range

# p lookup.parsed_gtf


# takes 4min 21 sec for just parsing when you include the hash of attributes
# only 1min 24 sec without extra fields for parsing

# difference when looking up chromosome with range is 782320 vs 832927

# 100,000 records takes 2 min
# 50,000 records takes 1 min 
# 800,000 should take 16 min 




