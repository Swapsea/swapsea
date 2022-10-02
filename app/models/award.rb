# frozen_string_literal: true

class Award < ApplicationRecord
  belongs_to :user

  scope :with_user, ->(user_id) { where(user_id:).includes(:user) }

  validates :award_number, uniqueness: true

  def self.upload(file)
    values = []

    columns = %i[award_number award_name user_id award_date proficiency_date expiry_date
                 originating_organisation]

    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(5)
    (6..spreadsheet.last_row).each do |i|
      row = [header, spreadsheet.row(i)].transpose.to_h
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

    Award.import columns, values, validate: true, on_duplicate_key_ignore: true
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
