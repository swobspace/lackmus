namespace :lackmus do
  namespace :signatures do

    # usage: rake 'signatures:import[sid-msg.map]'
    desc "import signatures from sid-msg.map"
    task :import, [:file] => :environment do |t, args|
      file = args[:file] || raise("*** please specify import file ***")
      puts "Import file is: #{file}"

      File.open(file, 'r') do |f|
	f.each_line do |line|
	  entries = line.strip.split(" || ")
	  sid = entries.shift
	  msg = entries.shift
	  next if msg =~ / DELETED /
	  puts "import #{sid}: #{msg}"
	  Signature.find_or_create_by!(signature_id: sid) do |sig|
	    sig.signature_info = msg
	    sig.references     = entries
	    sig.action         = 'normal'
	  end
	end
      end
    end

    # usage: rake 'signatures:updateref[sid-msg.map]'
    desc "update signatures with references from sid-msg.map"
    task :updateref, [:file] => :environment do |t, args|
      file = args[:file] || raise("*** please specify sid-msg.map ***")
      puts "Import file is: #{file}"

      File.open(file, 'r') do |f|
	f.each_line do |line|
	  entries = line.strip.split(" || ")
	  sid = entries.shift
	  msg = entries.shift
	  next if msg =~ / DELETED /
	  Signature.where(signature_id: sid).each do |sig|
	    if sig.references.blank? and entries.present?
	      if sig.update_attributes(references: entries)
		puts "signature #{sid} updated"
	      else
		puts "update signature #{sid} failed"
	      end
	    end
	  end
	end
      end
    end

  end
end
