class Policy::TweetPolicy

    def edit_allowed?(tweet, user)
        user.roles_name.include?('ADMIN') || tweet.user_id == user.id
    end

    def is_admin?(user)
        puts user.roles_name
        user.roles_name.include?('ADMIN')
    end
end