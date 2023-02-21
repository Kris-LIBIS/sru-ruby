# frozen_string_literal: true

require "sru"
require "vcr"

RSpec.describe "SRU Client" do
  it "should not raise an exception", vcr: "content_negotiation" do
    client = SRU::Client.new("http://www.nla.gov.au/apps/srw/search/peopleaustralia")
    expect { client.search_retrieve "pa.surname any twain" }.not_to raise_error
  end
end
