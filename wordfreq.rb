class Wordfreq
  STOP_WORDS = %w[a an and are as at be by for from
                  has he i in is it its of on that the to
                  were will with].freeze

  def initialize(filename)
    @file = File.read(filename)
                .gsub(/\W/, ' ')
                .downcase
                .split(' ')
                .reject { |x| STOP_WORDS.include? x }
  end

  def frequencies
    words = {}
    @file.each do |e|
      words[e.to_s] = @file.count(e)
    end
    words
  end

  def frequency(word)
    if frequencies[word].nil?
      0
    else
      frequencies[word]
    end
  end

  def top_words(number) # 3
    frequencies.sort { |a, b| [b[1], a[0]] <=> [a[1], b[0]] }[0..(number - 1)]
  end

  def print_report # 4
    top_words(10).each do |x, y|
      puts "#{x} |".rjust(9) + " #{y} ".ljust(4) + '*' * @file.count(x)
    end
  end
  end

if $PROGRAM_NAME == __FILE__
  filename = ARGV[0]
  if filename
    full_filename = File.absolute_path(filename)
    if File.exist?(full_filename)
      wf = Wordfreq.new(full_filename)
      wf.print_report
    else
      puts "#{filename} does not exist!"
    end
  else
    puts 'Please give a filename as an argument.'
  end
end
