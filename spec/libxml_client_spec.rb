# frozen_string_literal: true

require "sru"
require "vcr"

RSpec.describe "SRU Client with libxml parser" do
  it "retrieves explain", vcr: "explain" do
    client = SRU::Client.new "http://z3950.loc.gov:7090/voyager", parser: "libxml"
    explain = client.explain
    expect(explain.class).to be == SRU::ExplainResponse
    expect(explain.version).to be == "1.1"
    expect(explain.host).to be == "localhost"
    expect(explain.port).to be == 7090
    expect(explain.database).to be == "voyager"
    expect(explain.to_s).to be == "host=localhost port=7090 database=voyager version=1.1"
  end

  it "searches and retrieves", vcr: "search_retrieve_none" do
    client = SRU::Client.new "http://z3950.loc.gov:7090/voyager", parser: "libxml"
    results = client.search_retrieve "twain", maximumRecords: 5
    expect(results.entries.size).to be == 5
    expect(results.number_of_records).to be > 2000
    expect(results.entries[0].class).to be == LibXML::XML::Node
    expect(results.entries[0].name).to be == "recordData"

    # hopefully there isn't a document that matches this :)
    results = client.search_retrieve "fidkidkdiejfl"
    expect(results.entries.size).to be == 0
  end

  it "retrieves max records", vcr: "search_retrieve_max" do
    client = SRU::Client.new "http://z3950.loc.gov:7090/voyager", parser: "libxml"
    results = client.search_retrieve "twain"
    expect(results.entries.size).to be == 10
  end
end
