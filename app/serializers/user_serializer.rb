class UserSerializer < ActiveModel::Serializer
   attributes :id, :name, :user_name, :type, :email,:image_url

  def image_url
    object.image.url
  end
end
