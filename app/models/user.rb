class User < ActiveRecord::Base
  # validates :name, :uid, :provider, presence: true

  def self.find_or_create_from_omniauth(auth_hash)
    # Find or create a user
    user = self.find_by(uid: auth_hash["uid"], provider: auth_hash["provider"])
    if user.nil?
      user = User.new
      user.name = auth_hash["info"]["display_name"]
      user.nickname = auth_hash["info"]["display_name"]
      user.uid = auth_hash["uid"]
      user.provider = auth_hash["provider"]

      user.save ? user : nil
    else
      user
    end
  end

end
