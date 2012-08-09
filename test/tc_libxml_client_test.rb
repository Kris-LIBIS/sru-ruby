require File.join(File.dirname(__FILE__), 'helper')

class TcLibxmlClientTests < Test::Unit::TestCase

  def test_explain
    VCR.use_cassette('explain') do
      client = SRU::Client.new 'http://z3950.loc.gov:7090/voyager', :parser=>'libxml'
      explain = client.explain
      assert_equal SRU::ExplainResponse, explain.class
      assert_equal '1.1', explain.version
      assert_equal 'localhost', explain.host
      assert_equal 7090, explain.port
      assert_equal 'voyager', explain.database
      assert_equal 'host=localhost port=7090 database=voyager version=1.1',
        explain.to_s
    end
  end

  def test_search_retrieve
    VCR.use_cassette('search_retrieve_none') do
      client = SRU::Client.new 'http://z3950.loc.gov:7090/voyager', :parser=>'libxml'
      results = client.search_retrieve 'twain', :maximumRecords => 5
      assert_equal 5, results.entries.size
      assert results.number_of_records > 2000
      assert_equal LibXML::XML::Node, results.entries[0].class
      assert_equal 'recordData', results.entries[0].name

      # hopefully there isn't a document that matches this :)
      results = client.search_retrieve 'fidkidkdiejfl'
      assert_equal 0, results.entries.size
    end
  end

  def test_default_maximum_records
    VCR.use_cassette('search_retrieve_max') do
      client = SRU::Client.new 'http://z3950.loc.gov:7090/voyager', :parser=>'libxml'
      results = client.search_retrieve 'twain'
      assert_equal 10, results.entries.size
    end
  end
end


