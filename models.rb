class User < ActiveRecord::Base
   has_many :posts, dependent: :destroy
end

class Post < ActiveRecord::Base
   belongs_to :user
end

# class Profile < ActiveRecord::Base
#    belongs_to :user
#    # has_many :posts
# end

# class Feed < ActiveRecord::Base
#    has_many :posts
# end
