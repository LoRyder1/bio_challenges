
#----------- NOTES--------

# FASTQ - a text based format for storing both a biological sequence(nucleotide seq) and its corresponding quality score. The sequence letter and quality score are each encoded with a single ASCII character for brevity. 

# FASTQ 
# 	Line 1 - begins with a '@' character and is followed by a sequence identifier and an optional description. 
# 	Line 2 - the raw sequence letters
# 	Line 3 - begins with a '+' character and is optionally followed by the same sequence identifier
# 	Line 4 - encodes the quality values for the sequence in Line 2, and must contain the same number of symbols as letters in the sequence. 

# * The chacter '!' represents the lowest quality while '~' is the highest


#-------- Coding Task -----------

# 1)  Recursively find all FASTQ files in a directory and report each file name and the percent of sequences in that file that are greater than 30 nucleotides long.

# Psuedocode 



class FileFastQ
 	attr_reader :file_by_line, :all_seqs, :seqs_larger_30, :percent_greater_30, :file
	def initialize(file_loc)
		@file = File.open(file_loc)
		@file_by_line = []
		@all_seqs = []
		@seqs_larger_30 = []
		@percent_greater_30 = nil
	end


 	def display_percents
 		file = File.basename(@file)
 		<<-TEXT

		++++++++++++++++++++++++++++

    		#{file}: #{@percent_greater_30}%

    TEXT
  end


	def parse_fastq
		@file.each do |line|
			@file_by_line << line
		end
		all_sequences
		greater_than_30
		percent
	end

	def all_sequences
		@file_by_line.each_with_index do |line, index|
			@all_seqs << line.strip if (index-1)%4 == 0
		end
	end

	def greater_than_30
		@all_seqs.each do |seq|
			@seqs_larger_30 << seq if seq.size > 30
		end
	end

	def percent
		num_all_seq = @all_seqs.count
		num_larger_30 = @seqs_larger_30.count
		percent = num_larger_30.to_f/num_all_seq.to_f*100
		@percent_greater_30 = percent.round(2)
	end

end

class ListFastQ
	attr_reader :files
	def initialize
		@files = []
	end

	def find_fastq_files
		fastq_files = File.join("**", "read*", "**", "*.fastq")
		Dir.glob(fastq_files).each do |file|
			@files << FileFastQ.new(file)
		end
		parse
	end

	def parse
		@files.each do |file|
			file.parse_fastq
		end
	end

	def display
		puts "		Percent of Sequences greater than 30 nucleotides "
		files.map {|x| x.display_percents }
	end
end


# ex = ListFastQ.new
# ex.find_fastq_files
# files = ex.files
# p files
# object = files[0]
# p object.parse_fastq
# p ex.files[0].parse_fastq.file_by_line
# files.parse_fastq
# p file.file_by_line
# file.all_sequences
# p file.all_seq
# file.greater_than_30
# p file.seqs_larger_30
# file.percent
# p file.percent_greater_30


if ARGV.any?
	list = ListFastQ.new
	list.find_fastq_files

	if ARGV[0] == "display"

		print "\e[2J"
		puts list.display
	end
end










