require "spec_helper"

describe "Sinatra App" do
  it "should respond to GET" do
    get "/"

    expect(last_response).to be_ok
  end

  it "has a title" do
    get "/"

    expect(page).to have_title("Grayson Wright")
  end

  it "has a description" do
    get "/"

    expect(page).to match("I'm a developer and designer")
  end

  it "has a link to sketches" do
    get "/"

    expect(page).to have_link("Sketches", "/sketches.html")
  end
end
