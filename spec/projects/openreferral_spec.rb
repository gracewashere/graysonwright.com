require "spec_helper"

describe "OpenReferral page" do
  it "should respond to GET" do
    get "/projects/openreferral"

    expect(last_response).to be_ok
  end

  describe "contents" do
    before { get "/projects/openreferral" }
    subject { page }

    pending { should have_title("OpenReferral | Grayson Wright") }
    it { should have_tag("h1", "San Francisco OpenReferral") }

    it { should match("Every Wednesday night") }

    it { should have_link("Sketches", "/sketches") }
    it { should have_link("Projects", "/projects") }
  end
end
