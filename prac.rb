#------- NOTES---------

# FASTA format is a text-based format for representing either nucleotide sequences or peptide sequences, in which nucleotides or amino acids are represented using single-letter codes.
	
# 	FORMAT
# 	begins with a single-line description, followed by lines of sequence data.
# 	description line is distinguished from the sequence data by a greater than ">" symbol in the first column
# 	the word following the ">" symbol is the identifier fo the sequence, and the rest of the line is the description. 
# 	there shoud be no space between the ">" and the first letter of the identifier.
# 	the sequence ends if another line starting with a ">" appears; this indicates the start of another sequence

#------ Pseudocode---------------

# 1. create a new instance of the Frequency class
# 2. parse fasta file by grabbing odd lines because those are the sequences and store in array
# 3. get occurrences or frequencies of each sequence in the array and store in hash
# 4. sort array and get top 10 frequencies 


#-------- Coding Task -----------

# 2)	Given a FASTA file with DNA sequences, find 10 most frequent sequences and return the sequence and their counts in the file.

class Frequency
	attr_reader :file, :parsed, :freq, :top10
	def initialize(filepath)
		@file = File.open(filepath)
		@parsed = []
		@freq = Hash.new(0)
		@top10 = nil
	end

	def get_freq
		parse
		get_occurrence
		sort_top10_freq
	end

	def display
		print "\e[2J"
		puts "TOP TEN SEQUENCES\n+-----------------+"
		top10.each { |seq,freq| puts "#{seq}: #{freq}" }
	end

	private

	def parse
		file.each_with_index do |line, index|
			parsed << line.strip if index.odd?
		end
	end

	def get_occurrence
		parsed.each { |seq| freq.store(seq, freq[seq]+1) }
	end

	def sort_top10_freq
		@top10 = Hash[freq.sort_by{|k,v| v}.reverse[0..9]]
	end


end

file = "sample_files/fasta/sample.fasta"
fasta = Frequency.new(file)
# p fasta.get_freq
# p fasta.get_occurrence



# p "hellot".capitalize.downcase



class Test
	def spartan
		self + "hello"
	end
	def athens
		"boom"
	end
end



test1 = Test.new

# p test1.athens
# p test1.spartan
class Foo
 def public_m
  private_m # <=
 end

 def self.static_m
   puts "static"
 end

 def self.static2_m
   puts "static 2"
 end
 def test
 		puts "#{self}"
 end

 private 
 def private_m
  puts 'Hello'
 end
end

Foo.new.public_m
Foo.static_m
Foo.static2_m
du = Foo.new
du.test

