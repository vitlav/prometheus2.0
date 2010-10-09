namespace :sisyphus do
  namespace :update do
    desc "Update *.src.rpm from Sisyphus to database"
    task :srpms => :environment do
      require 'rpm'
      puts Time.now.to_s + ": update *.src.rpm from Sisyphus to database"      
      path = "/ALT/Sisyphus/files/SRPMS/*.src.rpm"
      branch = Branch.first :conditions => { :name => 'Sisyphus', :vendor => 'ALT Linux' }
      Dir.glob(path).each do |file|
        begin
          rpm = RPM::Package::open(file)
          if !$redis.exists branch.name + ":" + rpm.name
            Srpm.import_srpm(branch.vendor, branch.name, file)            
          else
            curr = $redis.get branch.name + ":" + rpm.name
            if curr != (rpm.version.v.to_s + "-" + rpm.version.r.to_s) and curr != (rpm[1003].to_s + ":" + rpm.version.v.to_s + "-" + rpm.version.r.to_s)
              Srpm.update_srpm(branch.vendor, branch.name, file)
            end  
          end
        rescue RuntimeError
          puts "Bad src.rpm -- " + file
        end
      end
      puts Time.now.to_s + ": end"
    end

    desc "Update *.i586.rpm/*.x86_64.rpm/*.noarch.rpm from Sisyphus to database"
    task :binary => :environment do
      require 'rpm'
      puts Time.now.to_s + ": update *.i586.rpm/*.x86_64.rpm/*.noarch.rpm from Sisyphus to database"
      path_array = ["/ALT/Sisyphus/files/i586/RPMS/*.i586.rpm",
                    "/ALT/Sisyphus/files/x86_64/RPMS/*.x86_64.rpm",
                    "/ALT/Sisyphus/files/noarch/RPMS/*.noarch.rpm"]
      branch = Branch.first :conditions => { :name => 'Sisyphus', :vendor => 'ALT Linux' }
      path_array.each do |path|
        Dir.glob(path).each do |file|
          begin
            rpm = RPM::Package::open(file)
            if !$redis.exists branch.name + ":" + rpm.sourcepackage + ":" + rpm.arch + ":" + rpm.name
              Package.import_rpm(branch.vendor, branch.name, file)
            end            
          rescue RuntimeError
            puts "Bad src.rpm -- " + file
          end
        end
      end
      puts Time.now.to_s + ": end"
    end

#    desc "Update *.i586.rpm from Sisyphus to database"
#    task :i586 => :environment do
#      require 'rpm'
#      puts Time.now.to_s + ": update *.i586.rpm from Sisyphus to database"
#      ActiveRecord::Base.transaction do
#        ActiveRecord::Base.connection.execute("DELETE FROM packages WHERE arch = 'i586' AND branch = 'Sisyphus' AND vendor = 'ALT Linux'")
#        Package.import_packages_i586 'ALT Linux', 'Sisyphus', "/ALT/Sisyphus/files/i586/RPMS/*.i586.rpm"
#      end
#      puts Time.now.to_s + ": end"
#    end

#    desc "Update *.noarch.rpm from Sisyphus to database"
#    task :noarch => :environment do
#      require 'rpm'
#      puts Time.now.to_s + ": update *.noarch.rpm from Sisyphus to database"
#      ActiveRecord::Base.transaction do
#        ActiveRecord::Base.connection.execute("DELETE FROM packages WHERE arch = 'noarch' AND branch = 'Sisyphus' AND vendor = 'ALT Linux'")
#        Package.import_packages_noarch 'ALT Linux', 'Sisyphus', "/ALT/Sisyphus/files/noarch/RPMS/*.noarch.rpm"
#      end
#      puts Time.now.to_s + ": end"
#    end

#    desc "Update *.x86_64.rpm from Sisyphus to database"
#    task :x86_64 => :environment do
#      require 'rpm'
#      puts Time.now.to_s + ": update *.x86_64.rpm from Sisyphus to database"
#      ActiveRecord::Base.transaction do
#        ActiveRecord::Base.connection.execute("DELETE FROM packages WHERE arch = 'x86_64' AND branch = 'Sisyphus' AND vendor = 'ALT Linux'")
#        Package.import_packages_x86_64 'ALT Linux', 'Sisyphus', "/ALT/Sisyphus/files/x86_64/RPMS/*.x86_64.rpm"
#      end
#      puts Time.now.to_s + ": end"
#    end

#    desc "Update maintainers list from Sisyphus to database"
#    task :maintainers => :environment do
#      require 'rpm'
#      puts Time.now.to_s + ": update maintainers list from Sisyphus to database"
#      ActiveRecord::Base.transaction do
#        Maintainer.delete_all
#        Maintainer.update_maintainer_list 'ALT Linux', 'Sisyphus', "/ALT/Sisyphus/files/SRPMS/*.src.rpm"
#      end
#      puts Time.now.to_s + ": end"
#    end
  end
end