# chr3	refFlat	exon	134196546	134197558	.	-	.	gene_id "ANAPC13"; transcript_id "NM_001242374"; exon_number "3"; exon_id "NM_001242374.1"; gene_name "ANAPC13";	

# chr12	20704380

#------- Notes ----------- 

# GTF - gene transfer format 
# Structure of GFF - seq name, source, feature, start, end, score, strand, frame, [attributes][comments]

# an annotation is metadata(e.g. a comment, explanation, presentational markup)
# DNA annotation or genome annotation is the process of identifying the locations of genes and all of the coding regions in a genome and determing what those genes do. 



#---------- Coding TASK -----------

# 3)	Given a chromosome and coordinates, write a program for looking up its annotation.  Keep in mind you'll be doing this annotation millions of times.
# 	-	Input: 
# 		o	Tab-delimited file: Chr<tab>Position
# 		o	GTF formatted file with genome annotations.
# 	-	Output: 
# 		o	Annotated file of gene name that input position overlaps.
# 	-	Hint: Most of the sequence reads come from a small portion of the genome. Try to use this information to improve performance, if possible.

# "sample_files/gtf/hg19_annotations.gtf"

class AnnotationLookup
	attr_reader :parsed_coords, :parsed_gtf
	def initialize(coord_file, gtf_file)
		@coord_file = File.open(coord_file)
		@gtf_file = File.open(gtf_file)
		@parsed_coords = []
		@parsed_gtf = []
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

end

class Coord
	def initialize(coordinate)
		@chr = coordinate[0]
		@coord = coordinate[1].strip
		@coordinate = coordinate
	end
end

class Gtf
	def initialize(gtf)
		@chr = gtf[0]
		@region = gtf[2]
		@start = gtf[3]
		@end = gtf[4]
		@strand = gtf[6]
		@attributes = parse_attributes(gtf[8])
		@gtf = gtf
	end

	def parse_attributes(string)
		parsed = string.gsub!(/[^\w|\.]/,',').split(",")
		parsed.delete("")
		Hash[parsed.each_slice(2).to_a]
	end
end


file_coord = "sample_files/annotate/coordinates_to_annotate.txt"
# file_gtf = "sample_files/gtf/hg19_annotations.gtf"
file_gtf = "sample_files/gtf/test.gtf"
lookup = AnnotationLookup.new(file_coord, file_gtf)

# p lookup

lookup.parse_coord_file

# p lookup.parsed_coords

lookup.parse_gtf_file

p lookup.parsed_gtf

# something = "gene_id \"ZC3H6\"; transcript_id \"NM_198581\"; exon_number \"5\"; exon_id \"NM_198581.6\"; gene_name \"ZC3H6\";"
# drama = something.gsub!(/[^\w|\.]/,',').split(",")

# p something.split(";")
# drama.delete("")

# p drama

# hash = Hash[drama.each_slice(2).to_a]
# p hash
# p hash["gene_id"]







