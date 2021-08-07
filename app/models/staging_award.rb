class StagingAward < ApplicationRecord

	scope :current, -> { where('expiry_date > ? OR award_name = ?', DateTime.now, 'Silver Medallion Beach Management') }

	def self.dump(file)

		values = []

		columns = [:award_number, :award_name, :user_id, :award_date, :proficiency_date, :expiry_date, :originating_organisation]

		spreadsheet = open_spreadsheet(file)
		header = spreadsheet.row(5)
		(6..spreadsheet.last_row).each do |i|
			row = Hash[[header, spreadsheet.row(i)].transpose]
			if row["Award Number"].present?

				award = [
					(row["Award Number"].gsub /'/, ''),
					row["Award Name"],
					row["Member ID"],
					row["Award Date"],
					row["Proficiency Date"],
					row["Award Expiry Date"],
					row["Award Originating Organisation"]
				]

				values << award
			end
		end

		StagingAward.import columns, values, :validate => true

	end

	def self.transfer

		staged_awards = StagingAward.current

		values = []

		columns = [:award_number, :award_name, :user_id, :award_date, :proficiency_date, :expiry_date, :originating_organisation]

			staged_awards.each do |staged_award|

				award = [
					staged_award.award_number, 
					staged_award.award_name,
					staged_award.user_id,
					staged_award.award_date,
					staged_award.proficiency_date,
					staged_award.expiry_date,
					staged_award.originating_organisation,
				]

				values << award

			end

		if Award.import columns, values, :validate => true, on_duplicate_key_ignore: true
			StagingAward.delete_all
		end

	end

	def self.open_spreadsheet(file)
		case File.extname(file.original_filename)
		when ".txt" then Roo::CSV.new(file.path)
		when ".csv" then Roo::CSV.new(file.path)
		when ".xls" then Roo::Excel.new(file.path)
		when ".xlsx" then Roo::Excelx.new(file.path)
		else raise "Unknown file type: #{file.original_filename}"
		end
	end

end
