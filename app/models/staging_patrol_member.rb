# frozen_string_literal: true

class StagingPatrolMember < ApplicationRecord
  def self.dump(file)
    values = []

    columns = %i[user_id patrol_name default_position organisation]

    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(5)
    (6..spreadsheet.last_row).each do |i|
      row = [header, spreadsheet.row(i)].transpose.to_h

      patrol_member = [
        row['Member ID'],
        row['Team Name'],
        row['Team Position'],
        row['Organisation Display Name']
      ]

      values << patrol_member
    end

    StagingPatrolMember.import columns, values, validate: true
  end

  def self.transfer
    staged_patrol_members = StagingPatrolMember.all
    PatrolMember.transaction do
      staged_patrol_members.each do |staged_patrol_member|
        club_id = Club.find_by(name: staged_patrol_member.organisation).id
        patrol = Patrol.find_by(club_id:, name: staged_patrol_member.patrol_name)
        next unless patrol

        patrol_member = PatrolMember.find_or_initialize_by(user_id: staged_patrol_member.user_id)
        patrol_member.user_id = staged_patrol_member.user_id
        patrol_member.patrol_id = patrol.id
        patrol_member.default_position = staged_patrol_member.default_position
        patrol_member.default_position = 'Member' if patrol_member.default_position == 'Award Member'
        patrol_member.save
      end
    end

    StagingPatrolMember.delete_all
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
