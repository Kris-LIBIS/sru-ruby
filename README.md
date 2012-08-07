sru
===

sru is a Ruby library for talking to servers that support the Search & Retrieve
by URL (SRU) protocol. SRU is essentially a lightweight api for performing
information retrieval over HTTP. <http://www.loc.gov/standards/sru/>

Typically SRU clients perform a 'searchRetrieve' operation on a 
repository and get back different flavored XML metadata for the hits. In
addition SRU clients can perform an 'explain' operation which asks the SRU
server to describe itself, and its capabilities. The final operation is 'scan'
which allows a client to walk an index of terms used in the target.

Usage
-----

```ruby
require 'sru'

# create the client using a base address for the SRU service
client = SRU::Client.new 'http://sru.example.com'

# fetch a SRU::ExplainResponse object from the server
explain = client.explain

# issue a search and get back a SRU::SearchRetrieveResponse object 
# which serves as an iterator 
records = client.search_retrieve 'rosetta stone', {:maximumRecords => 5}
records.each {|record| puts record}

# issue a scan request and print out each term
client.scan('king tut', {:maximumTerms => 12}).each {|term| puts term}
```

Installation
------------

You should be able to install the gem:

    gem install sru

More information about the project:

    http://github.com/edsu/sru-ruby

License
-------

* [cc0](http://creativecommons.org/about/cc0)

