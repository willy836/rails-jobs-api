class Job < ApplicationRecord
    belongs_to :author, class_name: 'User', foreign_key: 'author_id'

    enum status: { interview: 0, pending: 1, declined: 2 }
end
