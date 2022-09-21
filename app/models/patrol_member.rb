# frozen_string_literal: true

class PatrolMember < ApplicationRecord
  belongs_to :user
  belongs_to :patrol

  def rosters
    Roster.all.where(patrol_name:)
  end

  def self.upload(file)
    # PatrolMember.delete_all #destory all data in table before import

    allowed_attributes = [
      'Member ID',
      'Team Name',
      'Team Position',
      'Organisation Display Name'
    ]

    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(5)
    (6..spreadsheet.last_row).each do |i|
      row = [header, spreadsheet.row(i)].transpose.to_h
      next unless Patrol.find_by(name: row['Team Name'], organisation: row['Organisation Display Name'])

      patrol_member = find_by(user_id: row['Member ID']) || new
      user = User.find_by(id: row['Member ID'])
      if user.present?
        user.default_position = row['Team Position']
        user.default_position = 'Member' if user.default_position == 'Award Member'
        user.save
      end
      patrol_member.user_id = row['Member ID']
      patrol_member.patrol_name = row['Team Name']
      patrol_member.default_position = row['Team Position']
      patrol_member.organisation = row['Organisation Display Name']

      # modify default position nameing for palm beach
      patrol_member.default_position = 'Member' if patrol_member.default_position == 'Award Member'

      patrol_member.save
    end
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
