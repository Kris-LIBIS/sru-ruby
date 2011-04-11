class TCHTTPClientTests < Test::Unit::TestCase
  def test_content_negotiation
    client = SRU::Client.new 'http://viaf.org/viaf/search'
    assert_nothing_raised do
      results = client.search_retrieve 'local.names any twain'
    end
  end  
end