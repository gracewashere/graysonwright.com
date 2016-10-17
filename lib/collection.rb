class Collection
  def initialize(name, root)
    @name = name
    @root = root
  end

  def pages
    markdown_files.map do |entry|
      file = path + "/" + entry

      url = dated_url(entry) || normal_url(entry)

      Struct.new(:url, :data).new(url, data_from_file(file))
    end.reverse
  end

  private

  attr_reader :name, :root

  def markdown_files
    entries.select { |filename| filename =~ /\.markdown$/ }
  end

  # Returns nil if the filename does not contain a date.
  def dated_url(entry)
    match = entry.match(/(\d{4}-\d{2}-\d{2})-(.+.html).markdown$/)

    if match
      "/" + [name, match[1].gsub("-", "/"), match[2]].join("/")
    end
  end

  def normal_url(entry)
    "/" + [name, entry.match(/(.+).markdown$/)[1]].join("/")
  end

  def entries
    Dir.entries(path) - [".", "..", ".DS_Store"]
  end

  def path
    File.expand_path("../source/#{name}/", root)
  end

  def data_from_file(file)
    FrontMatterParser.
      parse_file(file, comment: "").
      front_matter.
      map { |k, v| [k.to_sym, v] }.
      to_h
  end
end
