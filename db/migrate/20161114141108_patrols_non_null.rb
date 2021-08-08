class PatrolsNonNull < ActiveRecord::Migration
  def change
  	execute 'update patrols set need_bbm=0 where need_bbm IS NULL;'
	execute 'update patrols set need_irbd=0 where need_irbd IS NULL;'
	execute 'update patrols set need_irbc=0 where need_irbc IS NULL;'
	execute 'update patrols set need_artc=0 where need_artc IS NULL;'
	execute 'update patrols set need_firstaid=0 where need_firstaid IS NULL;'
	execute 'update patrols set need_spinal=0 where need_spinal IS NULL;'
	execute 'update patrols set need_bronze=0 where need_bronze IS NULL;'
	execute 'update patrols set need_src=0 where need_src IS NULL;'

	execute 'ALTER TABLE patrols ALTER COLUMN need_bbm SET NOT NULL;'
	execute 'ALTER TABLE patrols ALTER COLUMN need_irbd SET NOT NULL;'
	execute 'ALTER TABLE patrols ALTER COLUMN need_irbc SET NOT NULL;'
	execute 'ALTER TABLE patrols ALTER COLUMN need_artc SET NOT NULL;'
	execute 'ALTER TABLE patrols ALTER COLUMN need_firstaid SET NOT NULL;'
	execute 'ALTER TABLE patrols ALTER COLUMN need_spinal SET NOT NULL;'
	execute 'ALTER TABLE patrols ALTER COLUMN need_bronze SET NOT NULL;'
	execute 'ALTER TABLE patrols ALTER COLUMN need_src SET NOT NULL;'
  end
end
