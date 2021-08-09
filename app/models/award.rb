# frozen_string_literal: true

class Award < ApplicationRecord
  belongs_to :user

  # Allow duplicate award numbers if same member belongs to two clubs simultaneously.
  # self.primary_key = 'award_number'

  validates :award_number, uniqueness: true

  def self.upload(file)
    # Award.joins(:user).where("users.organisation" => club).readonly(false).delete_all

    # allowed_attributes = [
    # 	"Member ID",
    # 	"Award Name",
    # 	"Award Number",
    # 	"Award Date",
    # 	"Proficiency Date",
    # 	"Award Expiry Date",
    # 	"Award Allocation Date",
    # 	"Proficiency Allocation Date",
    # 	"Award Originating Organisation"
    # ]

    values = []

    columns = %i[award_number award_name user_id award_date proficiency_date expiry_date
                 originating_organisation]

    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(5)
    (6..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      next if row['Award Number'].blank?

      # award = find_by_award_number(row["Award Number"]) || new
      # award.user_id = row["Member ID"]
      # award.award_name = row["Award Name"]
      # award.award_number = row["Award Number"].delete! ?'
      # award.award_date = row["Award Date"]
      # award.proficiency_date = row["Proficiency Date"]
      # award.expiry_date = row["Expiry Date"]
      # award.award_allocation_date = row["Award Allocation Date"]
      # award.proficiency_allocation_date = row["Proficiency Allocation Date"]
      # award.originating_organisation = row["Originating Organisation"]
      # award.save!

      award = [
        row['Award Number'].gsub(/'/, ''),
        row['Award Name'],
        row['Member ID'],
        row['Award Date'],
        row['Proficiency Date'],
        row['Award Expiry Date'],
        row['Award Originating Organisation']
      ]

      values << award
    end

    Award.import columns, values, validate: true
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when '.txt' then Roo::CSV.new(file.path)
    when '.csv' then Roo::CSV.new(file.path)
    when '.xls' then Roo::Excel.new(file.path)
    when '.xlsx' then Roo::Excelx.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end
end
