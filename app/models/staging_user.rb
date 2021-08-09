# frozen_string_literal: true

class StagingUser < ApplicationRecord
  def self.dump(file)
    values = []

    columns = %i[user_id first_name last_name preferred_name dob mobile_phone email category
                 date_joined_organisation status season organisation]

    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(5)
    (6..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]

      user = [
        row['Member ID'],
        row['First Name'],
        row['Last Name'],
        row['Preferred Name'],
        row['Date of Birth'],
        (row['Mobile Phone'].split('\'')[1] if row['Mobile Phone'].present?),
        row['Email Address 1'],
        row['Sub-Membership Category'],
        (row['Date Joined'] || DateTime.iso8601('1900-01-01')),
        row['Status'],
        row['Season'],
        row['Organisation Display Name']
      ]

      values << user
    end

    StagingUser.import columns, values, validate: true
  end

  def self.transfer
    staged_users = StagingUser.all

    staged_users.each do |staged_user|
      user = User.find_or_initialize_by(id: staged_user.user_id)

      user.id = staged_user.user_id
      user.first_name = staged_user.first_name
      user.last_name = staged_user.last_name
      user.preferred_name = staged_user.preferred_name
      user.dob = staged_user.dob
      user.mobile_phone = staged_user.mobile_phone
      user.email = staged_user.email
      user.category = staged_user.category
      user.date_joined_organisation = staged_user.date_joined_organisation
      user.status = staged_user.status
      user.season = staged_user.season
      user.organisation = staged_user.organisation
      user.ics = Digest::SHA512.hexdigest(('a'..'z').to_a.sample(64).join) if user.ics.blank?

      user.save
    end

    # StagingUser.delete_all
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when '.csv' then Roo::CSV.new(file.path)
    when '.xls' then Roo::Excel.new(file.path)
    when '.xlsx' then Roo::Excelx.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end
end
