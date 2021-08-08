namespace :swapsea do
  namespace :data do
    desc 'Daily transfer from staging tables to working tables.'
    task :transfer => :environment do |task|

      if StagingAward.transfer
        EventLog.create!(subject: 'Transfer', desc: 'Awards import success.')
      else
        EventLog.create!(subject: 'Transfer', desc: 'Awards import failed.')
      end

      if StagingUser.transfer
        EventLog.create!(subject: 'Transfer', desc: 'Users import success.')
      else
        EventLog.create!(subject: 'Transfer', desc: 'Users import failed.')
      end

      if StagingPatrolMember.transfer
        EventLog.create!(subject: 'Transfer', desc: 'Patrol Member import success.')
      else
        EventLog.create!(subject: 'Transfer', desc: 'Patrol Member import failed.')
      end

      NumJuniors = User.juniors.length
      if NumJuniors > 0
        EventLog.create!(subject: 'Transfer', desc: "Removing #{NumJuniors} junior members...")
        User.where(id: User.juniors.pluck(:id)).delete_all
        NumJuniors = User.juniors.length
        EventLog.create!(subject: 'Transfer', desc: "There are #{NumJuniors} junior members remaining.")
      else
        EventLog.create!(subject: 'Transfer', desc: 'No junior members found to remove.')
      end

    end
  end
end
