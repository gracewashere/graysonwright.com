class Blog
  def initialize(name, root)
    @name = name
    @root = root
  end

  def articles
    path = File.expand_path("../source/#{@name}/", @root)

    (
      Dir.entries(path) -
      [".", "..", ".DS_Store"]
    ).select do |filename|
      filename =~ /\.markdown$/
    end.map do |entry|
      file = path + "/" + entry

      parsed = FrontMatterParser.parse_file(file, comment: "")

      match = entry.match(/(\d{4}-\d{2}-\d{2})-(.+.html).markdown$/)
      url = "/" + [@name, match[1].gsub("-", "/"), match[2]].join("/")

      Struct.new(:url, :data, :title).new(
        url,
        {
          cover: parsed.front_matter["cover"],
        },
        parsed.front_matter["title"],
      )
    end.reverse
  end
end
