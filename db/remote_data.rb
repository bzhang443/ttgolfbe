class RemoteClub < ActiveRecord::Base
  establish_connection 'dev-remote'
  set_table_name 'clubs'
end

class RemoteCourse < ActiveRecord::Base
  establish_connection 'dev-remote'
  set_table_name 'courses'
end

def sync_short_name
  Club.all.each {|c|
    puts "#{c.name}..."
    r = RemoteClub.find(c.id)
    c.short_name = r.short_name
    c.save
  }
end

# load 'remote_data.rb'