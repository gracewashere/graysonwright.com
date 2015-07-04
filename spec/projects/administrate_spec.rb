require "spec_helper"

describe "Administrate page" do
  it "should respond to GET" do
    get "/projects/administrate"

    expect(last_response).to be_ok
  end

  describe "contents" do
    before { get "/projects/administrate" }
    subject { page }

    it { should have_title("Administrate | Grayson Wright") }
    it { should have_tag("h1", "Administrate") }

    it { should match("I've been the lead developer on Administrate") }

    it { should have_link("Sketches", "/sketches") }
    it { should have_link("Projects", "/projects") }
  end
end
