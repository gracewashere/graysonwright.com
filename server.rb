require "sinatra/reloader"
require "bourbon"
require "neat"
require "front_matter_parser"
require_relative "lib/legacy/blog"

set views: File.expand_path("../source", __FILE__)

get "/" do
  path = File.expand_path("../source/index.md", __FILE__)
  parsed = FrontMatterParser.parse_file(path)
  markdown parsed.content, layout_engine: :erb, layout: :"layouts/layout"
end

get "/stylesheets/all.css" do
  scss :"stylesheets/all"
end

get "/javascripts/all.js" do
end

get "/sketches.html" do
  erb :sketches, layout: :"layouts/layout"
end

get %r{(/sketches/.+\.jpg)} do |file|
  send_file "source" + file
end

get %r{/sketches/(\d{4})/(\d{2})/(\d{2})/(.+.html)$} do |year, month, day, title|
  template = "sketches/#{year}-#{month}-#{day}-#{title}"

  file = template + ".markdown"
  path = File.expand_path("../source/#{file}/", __FILE__)
  parsed = FrontMatterParser.parse_file(path, comment: "")
  @page = parsed

  markdown parsed.content, layout_engine: :erb, layout: :"layouts/sketch_layout"
end

def current_page
  if @page
    parsed = @page
    Struct.new(:data).new(
      Struct.new(:title, :cover).new(parsed.front_matter["title"], "/sketches/" + parsed.front_matter["cover"])
    )
  else
    Struct.new(:data).new(
      Struct.new(:title, :cover).new("Grayson Wright", "")
    )
  end
end

def stylesheet_link_tag(*stylesheets)
  stylesheets.map do |stylesheet|
    "<link href=\"/stylesheets/#{stylesheet}.css\" rel=\"stylesheet\" type=\"text/css\">"
  end.join("\n")
end

def javascript_include_tag(*scripts)
  scripts.map do |script|
    "<script src=\"/javascripts/#{script}.js\" type=\"text/javascript\"></script>"
  end.join("\n")
end

def page_classes
  :index
end

def partial(partial_name)
  erb "_#{partial_name}".to_sym
end

def gravatar_image(email)
  hash = Digest::MD5.hexdigest(email.chomp.downcase)
  "<img src=\"http://www.gravatar.com/avatar/#{hash}?s=300\"/>"
end

def blog(name)
  Blog.new(name, __FILE__)
end
