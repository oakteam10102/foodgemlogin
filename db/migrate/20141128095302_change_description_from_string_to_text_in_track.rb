class ChangeDescriptionFromStringToTextInTrack < ActiveRecord::Migration
  def change
  	def self.up
	    change_table :trakcs do |t|
	      t.change :description, :text
	    end
	  end
	  def self.down
	    change_table :trakcs do |t|
	      t.change :description, :text
	    end
	  end
  end
end
