require "spec_helper"

describe "Carbon Cash page" do
  it "should respond to GET" do
    get "/projects/carbon_cash"

    expect(last_response).to be_ok
  end

  describe "contents" do
    before { get "/projects/carbon_cash" }
    subject { page }

    it { should have_title("Carbon Cash | Grayson Wright") }
    it { should have_tag("h1", "Carbon Cash") }

    it { should match("Carbon Cash is an environmental startup") }
    it { should have_link("Visit Site", "http://carboncash.co/") }

    it { should have_link("Sketches", "/sketches") }
    it { should have_link("Projects", "/projects") }
  end
end
