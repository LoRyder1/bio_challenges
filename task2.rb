#-------NOTES---------

# FASTA format is a text-based format for representing either nucleotide sequences or peptide sequences, in which nucleotides or amino acids are represented using single-letter codes.
	
# 	FORMAT
# 	begins with a single-line description, followed by lines of sequence data.
# 	description line is distinguished from the sequence data by a greater than ">" symbol in the first column
# 	the word following the ">" symbol is the identifier fo the sequence, and the rest of the line is the description. 
# 	there shoud be no space between the ">" and the first letter of the identifier.
# 	the sequence ends if another line starting with a ">" appears; this indicates the start of another sequence



#-------- Coding Task -----------

# 2)	Given a FASTA file with DNA sequences, find 10 most frequent sequences and return the sequence and their counts in the file.

class Frequency
	def initialize(file)
		@file = File.open(file)
	end

	def parse
		array = []
		@file.each_with_index do |line, index|
			array <<  line.strip if index.odd?
		end
		array
	end

	def occurrence
		freq = Hash.new(0)
		parse.each do |sequence|
			freq.store(sequence, freq[sequence]+1)
		end
		freq
	end

	def sort_display_top10
		top10 = Hash[occurrence.sort_by{|k,v| v}.reverse[0..9]]
		top10.each do |seq,freq|
			puts "#{seq}: #{freq}"  
		end
	end
end

file = "sample_files/fasta/sample.fasta"
fasta = Frequency.new(file)
# p fasta.parse
# p fasta.occurrence
# fasta.sort_display_top10



if ARGV.any?

	file = "sample_files/fasta/sample.fasta"
	fasta = Frequency.new(file)

	if ARGV[0] == "display"

		print "\e[2J"
		puts "TOP TEN SEQUENCES"
		puts "++++++++++++++++++"
		fasta.sort_display_top10
	end
end


