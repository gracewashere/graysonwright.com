require "sinatra"
require "sinatra/reloader"
require "bourbon"
require "neat"
require "front_matter_parser"
require_relative "lib/collection"

set :bind, "0.0.0.0"

set views: File.expand_path("../source", __FILE__)

get "/" do
  markdown File.read("source/index.md"), layout_engine: :erb, layout: :"layouts/layout"
end

get "/stylesheets/all.css" do
  scss :"stylesheets/all"
end

get "/javascripts/all.js" do
end

get "/sketches" do
  @page_title ||= "Sketches"
  erb :sketches, layout: :"layouts/layout"
end

get "/projects" do
  @page_title ||= "Projects"
  erb :projects, layout: :"layouts/layout"
end

get %r{(/sketches/.+\.jpg)} do |file|
  send_file "source" + file
end

get "/projects/:name" do
  file = "projects/#{params[:name]}.markdown"
  path = File.expand_path("../source/#{file}/", __FILE__)
  parsed = FrontMatterParser.parse_file(path, comment: "")
  @page_data = parsed.front_matter

  erb(:"layouts/layout", layout: false) do
    markdown parsed.content, layout_engine: :erb, layout: :"layouts/project_layout"
  end
end

get %r{/sketches/(\d{4})/(\d{2})/(\d{2})/(.+.html)$} do |year, month, day, title|
  file = "sketches/#{year}-#{month}-#{day}-#{title}.markdown"
  path = File.expand_path("../source/#{file}/", __FILE__)
  parsed = FrontMatterParser.parse_file(path, comment: "")
  @page_data = parsed.front_matter

  erb(:"layouts/layout", layout: false) do
    markdown parsed.content, layout_engine: :erb, layout: :"layouts/sketch_layout"
  end
end

def current_page
  title = "Grayson Wright"

  if @page_title
    title = "#{@page_title} | #{title}"
  end

  @page_data || { "title" => title, "cover" => "" }
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

def collection(name)
  Collection.new(name, __FILE__)
end
