# frozen_string_literal: true

class ImportExternalData < ActiveRecord::Migration[7.0]
  def change
    PlayersService.import
  end
end
