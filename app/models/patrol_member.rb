# frozen_string_literal: true

class PatrolMember < ApplicationRecord
  belongs_to :user
  belongs_to :patrol

  scope :with_user, ->(user_id) { where(user_id:).includes(:user, :patrol) }
  scope :with_patrol, ->(patrol_id) { where(patrol_id:).includes(:patrol, :user) }
  scope :with_club, ->(club_id) { joins(:patrol).where(patrols: { club_id: }).includes(:patrol, :user) }

  def rosters
    Roster.all.where(patrol_name:)
  end

  def self.upload(file)
    allowed_attributes = [
      'Member ID',
      'Team Name',
      'Team Position',
      'Organisation Display Name'
    ]

    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(5)
    club = nil
    (6..spreadsheet.last_row).each do |i|
      row = [header, spreadsheet.row(i)].transpose.to_h

      club ||= Club.find_by!(name: row['Organisation Display Name'])

      # Skip patrols that aren't setup in Swapsea, but crash if there are none
      patrols = Patrol.where(club_id: club.id)
      patrol = patrols.find_by(name: row['Team Name'])
      next unless patrol

      patrol_member = find_or_initialize_by(user_id: row['Member ID'])
      patrol_member.patrol_id = patrol.id
      patrol_member.default_position = row['Team Position']
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
