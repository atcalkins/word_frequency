class Wordfreq
  STOP_WORDS = ['a', 'an', 'and', 'are', 'as', 'at', 'be', 'by', 'for', 'from',
    'has', 'he', 'i', 'in', 'is', 'it', 'its', 'of', 'on', 'that', 'the', 'to',
    'were', 'will', 'with']

  def initialize(filename)
    @file = File.read(filename)
    .gsub(/\W/, ' ')
    .downcase
    .split(" ")
    .reject{|x| STOP_WORDS.include? x}
  end

  def frequency(word)
    frequencies[word]
  end


  def frequencies
    words = Hash.new
    @file.each do |e|
      words["#{e}"] = @file.count(e)
    end
    words
  end

  def top_words(number)
    frequencies.sort { |a, b| [b[1], a[0]] <=> [a[1], b[0]] }[0..(number - 1)]
  end

  def print_report
    
  end
end

if __FILE__ == $0
  filename = ARGV[0]
  if filename
    full_filename = File.absolute_path(filename)
    if File.exists?(full_filename)
      wf = Wordfreq.new(full_filename)
      wf.print_report
    else
      puts "#{filename} does not exist!"
    end
  else
    puts "Please give a filename as an argument."
  end
end
