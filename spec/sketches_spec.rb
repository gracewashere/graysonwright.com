require "spec_helper"

describe "Sketches index" do
  it "should respond to GET" do
    get "/sketches"

    expect(last_response).to be_ok
  end

  describe "contents" do
    before { get "/sketches" }
    subject { page }

    pending { should have_title("Sketches | Grayson Wright") }
    it { should have_link("Golden Gate", "/sketches/2014/09/28/golden-gate.html") }
    it { should have_link("Projects", "/projects") }
  end
end
