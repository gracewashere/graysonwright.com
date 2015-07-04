require "spec_helper"

describe "Sinatra App" do
  it "should respond to GET" do
    get "/"

    expect(last_response).to be_ok
  end

  describe "contents" do
    before { get "/" }
    subject { page }

    it { should have_title("Grayson Wright") }
    it { should match("I'm a developer and designer") }
    it { should have_link("Sketches", "/sketches.html") }
  end
end
