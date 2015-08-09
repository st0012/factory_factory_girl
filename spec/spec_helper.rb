$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'fakery'
require "generator_spec"
require "pry"
require "active_record"

ActiveRecord::Base.default_timezone = "Taipei"
ActiveRecord::Base.time_zone_aware_attributes = true

# migrations
ActiveRecord::Base.establish_connection adapter: "sqlite3", database: "tmp/:fakery:"

ActiveRecord::Base.raise_in_transactional_callbacks = true if ActiveRecord::Base.respond_to?(:raise_in_transactional_callbacks=)

ActiveRecord::Migration.create_table :posts do |t|
  t.string :title
  t.integer :user_id
  t.boolean :is_published
  t.integer :view_count
  t.text :description
  t.text :content
  t.timestamps null: true
end

ActiveRecord::Migration.create_table :users do |t|
  t.string :name
  t.string :email
end

class Post < ActiveRecord::Base
end

class User < ActiveRecord::Base
end
