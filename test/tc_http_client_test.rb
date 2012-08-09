class TCHTTPClientTests < Test::Unit::TestCase
  def test_content_negotiation
    VCR.use_cassette('content_negotiation') do
      client = SRU::Client.new(
        'http://www.nla.gov.au/apps/srw/search/peopleaustralia')
      assert_nothing_raised { client.search_retrieve 'pa.surname any twain' }
    end
  end
end