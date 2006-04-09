#!/usr/bin/env ruby

$LOAD_PATH.unshift 'lib'
require 'test/unit'
require 'sru'

class ClientTests < Test::Unit::TestCase

  def test_explain
    client = SRU::Client.new 'http://z3950.loc.gov:7090/voyager'
    explain = client.explain
    assert_equal SRU::ExplainResponse, explain.class
    assert_equal '1.1', explain.version
  end

  def test_search_retrieve
    client = SRU::Client.new 'http://z3950.loc.gov:7090/voyager'
    results = client.search_retrieve 'twain', :maximumRecords => 5
    assert_equal 5, results.entries.size
    assert results.number_of_records > 2000
    assert_equal REXML::Element, results.entries[0].class
    assert_equal 'record', results.entries[0].name

    results = client.search_retrieve 'fidkidkdiejfl'
    assert_equal 0, results.entries.size
  end

end


