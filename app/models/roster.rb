# frozen_string_literal: true
class Roster < ActiveRecord::Base

  belongs_to :patrol, primary_key: 'name', foreign_key: 'patrol_name'
  has_many :requests
  has_many :swaps
  has_many :offers

  include PgSearch::Model
  pg_search_scope :search, against: [:patrol_name, :organisation],
   using: {tsearch: {dictionary: 'english'}}

  def self.text_search(query)
    if query.present?
      search(query)
    else
      scoped
    end
  end

  def current
    patrol.users - removed + added
  end

  def members
    patrol.users
  end

  def remaining_members
    patrol.users - removed
  end

  def generate_secret
    self.secret = Digest::SHA256.hexdigest(('a'..'z').to_a.shuffle[0,10].join)
    end

  def swap_meets_requirements(req, sub)
    bbm = qualifications[:bbm].to_i - req.qualifications[:bbm].to_i + sub.qualifications[:bbm].to_i
    irbd = qualifications[:irbd].to_i - req.qualifications[:irbd].to_i + sub.qualifications[:irbd].to_i
    irbc = qualifications[:irbc].to_i - req.qualifications[:irbc].to_i + sub.qualifications[:irbc].to_i
    artc = qualifications[:artc].to_i - req.qualifications[:artc].to_i + sub.qualifications[:artc].to_i
    bronze = qualifications[:bronze].to_i - req.qualifications[:bronze].to_i + sub.qualifications[:bronze] .to_i
    src = qualifications[:src].to_i - req.qualifications[:src].to_i + sub.qualifications[:src].to_i
    if !(bbm >= patrol.need_bbm) || !(irbd >= patrol.need_irbd) || !(irbc >= patrol.need_irbc) || !(artc >= patrol.need_artc) || !(bronze >= patrol.need_bronze) || !(src >= patrol.need_src)
      {
      result: false,
      bbm: bbm,
      irbd: irbd,
      irbc: irbc,
      artc: artc,
      bronze: bronze,
      src: src
      }
    else
      {
      result: true,
      bbm: bbm,
      irbd: irbd,
      irbc: irbc,
      artc: artc,
      bronze: bronze,
      src: src
      }
    end
  end

  def roster_awards_without_req(req)
    a_bbm = bbm.to_i - req.qualifications[:bbm].to_i
    a_irbd = irbd.to_i - req.qualifications[:irbd].to_i
    a_irbc = irbc.to_i - req.qualifications[:irbc].to_i
    a_artc = artc.to_i - req.qualifications[:artc].to_i
    a_bronze = bronze.to_i - req.qualifications[:bronze].to_i
    a_src = src.to_i - req.qualifications[:src].to_i
    if !(a_bbm >= patrol.need_bbm) || !(a_irbd >= patrol.need_irbd) || !(a_irbc >= patrol.need_irbc) || !(a_artc >= patrol.need_artc) || !(a_bronze >= patrol.need_bronze) || !(a_src >= patrol.need_src)
      {
      result: false,
      bbm: a_bbm,
      irbd: a_irbd,
      irbc: a_irbc,
      artc: a_artc,
      bronze: a_bronze,
      src: a_src
      }
    else
      {
      result: true,
      bbm: a_bbm,
      irbd: a_irbd,
      irbc: a_irbc,
      artc: a_artc,
      bronze: a_bronze,
      src: a_src
      }
    end
  end

  def roster_meets_requirements(req)
    bbm = qualifications[:bbm].to_i - req.qualifications[:bbm].to_i
    irbd = qualifications[:irbd].to_i - req.qualifications[:irbd].to_i
    irbc = qualifications[:irbc].to_i - req.qualifications[:irbc].to_i
    artc = qualifications[:artc].to_i - req.qualifications[:artc].to_i
    bronze = qualifications[:bronze].to_i - req.qualifications[:bronze].to_i
    src = qualifications[:src].to_i - req.qualifications[:src].to_i
    if !(bbm >= patrol.need_bbm) || !(irbd >= patrol.need_irbd) || !(irbc >= patrol.need_irbc) || !(artc >= patrol.need_artc) || !(bronze >= patrol.need_bronze) || !(src >= patrol.need_src)
      {
      result: false,
      bbm: bbm,
      irbd: irbd,
      irbc: irbc,
      artc: artc,
      bronze: bronze,
      src: src
      }
    else
      {
      result: true,
      bbm: bbm,
      irbd: irbd,
      irbc: irbc,
      artc: artc,
      bronze: bronze,
      src: src
      }
    end
  end

  def meets_requirements
    bbm = qualifications[:bbm].to_i
    irbd = qualifications[:irbd].to_i
    irbc = qualifications[:irbc].to_i
    artc = qualifications[:artc].to_i
    bronze = qualifications[:bronze].to_i
    src = qualifications[:src].to_i
    if !(bbm >= patrol.need_bbm) || !(irbd >= patrol.need_irbd) || !(irbc >= patrol.need_irbc) || !(artc >= patrol.need_artc) || !(bronze >= patrol.need_bronze) || !(src >= patrol.need_src)
      {
      result: false,
      bbm: bbm,
      irbd: irbd,
      irbc: irbc,
      artc: artc,
      bronze: bronze,
      src: src
      }
    else
      {
      result: true,
      bbm: bbm,
      irbd: irbd,
      irbc: irbc,
      artc: artc,
      bronze: bronze,
      src: src
      }
    end

  end

  def awards
    awards = Array.new
    current.map do |user|
      awards << user.awards
    end
    awards.flatten
  end

  def awards_count
    self.bronze = awards.count { |n| n.award_name == 'Bronze Medallion' }
    self.bbm = awards.count { |n| n.award_name == 'Silver Medallion Beach Management' }
    self.artc = awards.count { |n| (n.award_name == 'Advanced Resuscitation Techniques Certificate') || (n.award_name == 'Advanced Resuscitation Techniques [AID]') || (n.award_name == 'Advanced Resuscitation Techniques Refresher') || (n.award_name == 'Advanced Resuscitation Certificate') || (n.award_name == 'Advanced Resuscitation Certificate Instructor') }
    self.irbd = awards.count { |n| n.award_name == 'Silver Medallion IRB Driver' }
    self.irbc = awards.count { |n| n.award_name == 'IRB Crew Certificate' }
    self.src = awards.count { |n| (n.award_name == 'Surf Rescue Certificate') || (n.award_name == 'Surf Rescue Certificate (CPR Endorsed)') }
    self.firstaid = awards.count { |n| n.award_name == 'Senior First Aid Certificate (PUA)' }
    self.spinal = awards.count { |n| n.award_name == 'Spinal Management' }
    self.save
  end

  def qualifications
    bronze = awards.count { |n| n.award_name == 'Bronze Medallion' }
    bbm = awards.count { |n| n.award_name == 'Silver Medallion Beach Management' }
    artc = awards.count { |n| (n.award_name == 'Advanced Resuscitation Techniques Certificate') || (n.award_name == 'Advanced Resuscitation Techniques [AID]') || (n.award_name == 'Advanced Resuscitation Techniques Refresher') || (n.award_name == 'Advanced Resuscitation Certificate') || (n.award_name == 'Advanced Resuscitation Certificate Instructor') }
    irbd = awards.count { |n| n.award_name == 'Silver Medallion IRB Driver' }
    irbc = awards.count { |n| n.award_name == 'IRB Crew Certificate' }
    src = awards.count { |n| (n.award_name == 'Surf Rescue Certificate') || (n.award_name == 'Surf Rescue Certificate (CPR Endorsed)') }
    {
      bronze: bronze,
      bbm: bbm,
      artc: artc,
      irbd: irbd,
      irbc: irbc,
      src: src
    }
  end

  def added
    added = Array.new
    ids = swaps.select(:user_id).distinct
    ids.each do |i|
      swap = swaps.where(user_id: i.user.id).includes(:user).last
      if ((swap.on_off_patrol == true) && (!patrol.users.where(id: i.user.id).present?))
        added << swap.user
      end
    end
    added
  end

  def removed
    removed = Array.new
    ids = swaps.select(:user_id).distinct
    ids.each do |i|
      swap = swaps.where(user_id: i.user.id).includes(:user).last
      if ((swap.on_off_patrol == false) && (patrol.users.where(id: i.user.id).present?))
        removed << swap.user
      end
    end
    removed
  end

  def user_rostered_on(user)
    if swaps.where(user_id: user.id).present?
      # find last swap and determine if 'on' or 'off' patrol
      if swaps.where(user_id: user.id).last.on_off_patrol == true
        true
      else
        false
      end
    else
      # will check if member is part of patrol that is rosterd on
      patrol.users.where(id: user.id).present? #returns true or false
    end
  end

  def self.upload(file)
    #Roster.delete_all #delete all data in table before import
    allowed_attributes = [
       'Rostered Team Name',
     'Patrol Roster Date',
     'Patrol Roster Start Time',
     'Patrol Roster Finish Time',
     'Organisation Display Name'
     ]

    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(5)
    (6..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      roster = Roster.new
      roster.patrol_name = row['Rostered Team Name']
      date = row['Patrol Roster Date'].split('/')
      year = date[0].to_s
      month = date [1].to_s
      day = date [2].to_s
      formatted_date = year+'-'+month+'-'+day
      roster.start = Time.zone.parse(formatted_date + ' ' + row['Patrol Roster Start Time'] + ':00').utc.iso8601
      roster.finish = Time.zone.parse(formatted_date + ' ' + row['Patrol Roster Finish Time'] + ':00').utc.iso8601
      roster.organisation = row['Organisation Display Name']
      roster.generate_secret
      roster.save!
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
