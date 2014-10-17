map "/" do
  run Rack::File.new("public/index.html")
end
map "/style.css" do
  run Rack::File.new("public/style.css")
end
map "/face.png" do
  run Rack::File.new("public/face.png")
end
