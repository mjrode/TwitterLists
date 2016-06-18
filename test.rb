friends = ["kendricklamar",
 "SkySportsFL",
 "jasoncummings86",
 "deleteme",
 "WSJ",
 "washingtonpost",
 "nytimes",
 "tenderlove",
 "WIRED",
 "carson_blah",
 "niedzielskiadam",
 "JakubJatczak",
 "pokorson",
 "rails",
 "GoRails",
 "SportsCenter"]
remote_friends = ["WSJ",
 "washingtonpost",
 "nytimes",
 "tenderlove",
 "WIRED",
 "carson_blah",
 "jasoncummings86",
 "niedzielskiadam",
 "JakubJatczak",
 "pokorson",
 "jasoncummings86",
 "niedzielskiadam",
 "tenderlove",
 "rails",
 "WSJ",
 "GoRails",
 "SportsCenter",
 "tenderlove",
 "WSJ",
 "washingtonpost",
 "WIRED",
 "nytimes",
 "jasoncummings86",
 "pokorson",
 "GoRails"]


friends.each do |friend| 
  unless remote_friends.include?(friend)
    puts "#{friend} was removed"
  end
end

