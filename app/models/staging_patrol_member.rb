class StagingPatrolMember < ApplicationRecord

	def self.dump(file)

		values = []

		columns = [:user_id, :patrol_name, :default_position, :organisation]

		spreadsheet = open_spreadsheet(file)
		header = spreadsheet.row(5)
		(6..spreadsheet.last_row).each do |i|
			row = Hash[[header, spreadsheet.row(i)].transpose]

			patrol_member = [
				row["Member ID"],
				row["Team Name"],
				row["Team Position"],
				row["Organisation Display Name"]
			]

			values << patrol_member

		end

		StagingPatrolMember.import columns, values, :validate => true

	end

	def self.transfer

		staged_patrol_members = StagingPatrolMember.all

		success_count = 0
		fail_count = 0
		total_count = staged_patrol_members.count

		PatrolMember.transaction do

			staged_patrol_members.each do |staged_patrol_member|

				if Patrol.find_by(name: staged_patrol_member.patrol_name, organisation: staged_patrol_member.organisation)

					patrol_member = PatrolMember.find_or_initialize_by(user_id: staged_patrol_member.user_id)

					user = User.find_by_id(staged_patrol_member.user_id)

					if user.present?
						user.patrol_name = staged_patrol_member.patrol_name
						user.default_position = staged_patrol_member.default_position
						if user.default_position == 'Award Member'
							user.default_position = 'Member'
						end
						user.save!
					end

					patrol_member.user_id = staged_patrol_member.user_id
					patrol_member.patrol_name = staged_patrol_member.patrol_name
					patrol_member.default_position = staged_patrol_member.default_position
					patrol_member.organisation = staged_patrol_member.organisation

					if patrol_member.default_position == 'Award Member'
						patrol_member.default_position = 'Member'
					end

					patrol_member.save

				end

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
