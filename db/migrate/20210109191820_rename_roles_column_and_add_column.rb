class RenameRolesColumnAndAddColumn < ActiveRecord::Migration[6.0]
  def change
    rename_column :roles, :name, :controller_name
    add_column :roles, :action_name, :string, limit: 255, default: '', null: false

    reversible do |dir|
      dir.up do
        begin
          roles = Role.all
          for r in roles
            new_name = r.controller_name.split('_')
            new_controller_name = new_name[0]
            new_action_name = '*'
            unless new_name[1].blank?
              new_action_name = new_name[1]
            end
            r.controller_name = new_controller_name
            r.action_name = new_action_name
            r.save!
          end
        rescue Exception => ex
          say "migration up: resued from an error, rollback migration, fix the error and run migration again"
          say ex.to_s
        end
      end
      dir.down do
        begin
          roles = Role.all
          for r in roles
            if r.action_name != '*'
              r.controller_name += '_' + r.action_name
              r.save!
            end
          end
        rescue Exception => ex
          say "migration down: resued from an error, rollback migration, fix the error and run migration again"
          say ex.to_s
        end
      end
    end
    
  end
end
