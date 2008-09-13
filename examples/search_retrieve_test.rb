#Example search_retrieve request.
require 'rubygems'
require 'sru'

#An iterator for search results which allows you to do stuff like:

client = SRU::Client.new 'http://z3950.loc.gov:7090/voyager',:parser=>'libxml'
for record in client.search_retrieve('"title=building digital libraries"')
   puts record
end

puts "\n\n"
puts "finished"

