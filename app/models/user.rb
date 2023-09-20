class User < ApplicationRecord
    has_secure_password
    has_many :jobs, class_name: 'Job', foreign_key: 'author_id'
end
