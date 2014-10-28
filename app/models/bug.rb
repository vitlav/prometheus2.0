require 'csv'

class Bug < ActiveRecord::Base
  def self.import(url)
    ActiveRecord::Base.transaction do
      Bug.delete_all
      # altlinux uses their own ca and self sign
      data = `curl --cacert altlinux.ca --silent "#{ url }"`
      csv = CSV.parse(data)

      # parse csv with headers
      index = 0
      csv.each do |row|
        index += 1
        next if index == 1
        bug = Bug.new
        bug.bug_id = row[0]
        bug.bug_status = row[1]
        if row[2]
          bug.resolution = row[2]
        else
          # TODO: change '' to nil and make for this migration
          bug.resolution = ''
        end
        bug.bug_severity = row[3]
        bug.product = row[4]
        bug.component = row[5]
        bug.assigned_to = row[6]
        bug.reporter = row[7]
        bug.short_desc = row[8]
        bug.save!
      end
    end
  end
end
