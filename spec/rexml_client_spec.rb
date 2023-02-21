# frozen_string_literal: true

require "sru"
require "vcr"

RSpec.describe "SRU Client with REXML parser" do
  it "retrieves explain", vcr: "explain" do
    client = SRU::Client.new "http://z3950.loc.gov:7090/voyager",
      parser: "rexml"
    explain = client.explain
    expect(SRU::ExplainResponse).to be == explain.class
    expect("1.1").to be == explain.version
    expect("localhost").to be == explain.host
    expect(7090).to be == explain.port
    expect("voyager").to be == explain.database
    expect("host=localhost port=7090 database=voyager version=1.1").to be == explain.to_s
  end

  it "searches and retrieves", vcr: "search_retrieve_none" do
    client = SRU::Client.new "http://z3950.loc.gov:7090/voyager",
      parser: "rexml"
    results = client.search_retrieve "twain", maximumRecords: 5
    expect(5).to be == results.entries.size
    expect(results.number_of_records).to be > 2000
    expect(REXML::Element).to be == results.entries[0].class
    expect("recordData").to be == results.entries[0].name

    # hopefully there isn't a document that matches this :)
    results = client.search_retrieve "fidkidkdiejfl"
    expect(0).to be == results.entries.size
  end

  it "retrieves max records", vcr: "search_retrieve_max" do
    client = SRU::Client.new "http://z3950.loc.gov:7090/voyager",
      parser: "rexml"
    results = client.search_retrieve "twain"
    expect(10).to be == results.entries.size
  end
end
