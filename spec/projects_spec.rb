require "spec_helper"

describe "Projects index" do
  it "should respond to GET" do
    get "/projects"

    expect(last_response).to be_ok
  end

  describe "contents" do
    before { get "/projects" }
    subject { page }

    it { should have_title("Projects | Grayson Wright") }
    it { should have_tag("h1", "Projects") }

    it { should have_tag("h2", "Administrate") }
    it { should have_tag("h2", "Carbon Cash") }
    it { should have_tag("h2", "San Francisco OpenReferral") }

    it { should have_link("Details", "/projects/administrate") }
    it { should have_link("Details", "/projects/carbon_cash") }
    it { should have_link("Visit Site", "http://carboncash.co/") }
    it { should have_link("Details", "/projects/openreferral") }

    it { should have_link("Sketches", "/sketches") }
    it { should have_link("Projects", "/projects") }
  end
end
