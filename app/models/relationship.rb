class Relationship < ApplicationRecord
    # @user.followerを使ってレコードを取得できるようになる
    belongs_to :follower, class_name: "User"
    # @user.followedを使ってレコードを取得できるようになる
    belongs_to :followed, class_name: "User"

end
