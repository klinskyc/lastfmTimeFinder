# encoding: UTF-8
#!/usr/bin/env ruby

require 'lastfm'

lastfm = Lastfm.new('cdc2114d22f790fe4a6bb6c6d99ef3b7', 'a60f0f3839fc3f386b72d2dbdcc3310e')
token = lastfm.auth.get_token

# open 'http://www.last.fm/api/auth/?api_key=xxxxxxxxxxx&token=xxxxxxxx' and grant the application

recent_tracks = lastfm.library.get_tracks(user:'cklinsky68',limit:'1')
totalTracks = recent_tracks[0][0].to_i
page = 1
allTracks = []
while totalTracks > 0
  allTracks = allTracks.concat(lastfm.library.get_tracks(user:'cklinsky68',limit:'2500',page:page)[1])
  page++
  totalTracks+=-2500;
end
totalDuration = 0
allTracks.each do |i|
  totalDuration+=((i["duration"].to_i/1000)*i["playcount"].to_i)
end
print((totalDuration/60/60).to_s + " hours, " + (totalDuration/60%60).to_s + " minutes")
