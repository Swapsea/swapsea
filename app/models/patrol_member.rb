class PatrolMember < ActiveRecord::Base

  belongs_to :user
	belongs_to :patrol, primary_key: "name", foreign_key: "patrol_name"

  def rosters
    Roster.all.where(:patrol_name => patrol_name)
  end

	def self.upload(file)
		#PatrolMember.delete_all #destory all data in table before import
  		
    allowed_attributes = [ 
		    "Member ID", 
        "Team Name",
        "Team Position",
        "Organisation Display Name"
		]

		spreadsheet = open_spreadsheet(file)
		header = spreadsheet.row(5)
		(6..spreadsheet.last_row).each do |i|
    	row = Hash[[header, spreadsheet.row(i)].transpose]
      if Patrol.find_by(:name => row["Team Name"], :organisation => row["Organisation Display Name"])
     
        patrol_member = find_by(:user_id => row["Member ID"]) || new
        user = User.find_by(:id => row["Member ID"])
        if user.present?
          user.patrol_name = row["Team Name"]
          user.default_position = row["Team Position"]
          if user.default_position == 'Award Member'
            user.default_position = 'Member'
          end
          user.save
        end
    		patrol_member.user_id = row["Member ID"]
    		patrol_member.patrol_name = row["Team Name"]
  			patrol_member.default_position = row["Team Position"]
        patrol_member.organisation = row["Organisation Display Name"]

        # modify default position nameing for palm beach
        if patrol_member.default_position == 'Award Member'
          patrol_member.default_position = 'Member'
        end

  			patrol_member.save
  		end
		end
      
	end

	def self.open_spreadsheet(file)
  		case File.extname(file.original_filename)
  			when ".csv" then Roo::CSV.new(file.path)
  			when ".xls" then Roo::Excel.new(file.path)
  			when ".xlsx" then Roo::Excelx.new(file.path)
  			else raise "Unknown file type: #{file.original_filename}"
  		end
	end

end