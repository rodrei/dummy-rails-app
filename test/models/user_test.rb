require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    Rails.cache.clear
  end

  test "the truth" do
    user = User.create!
    user.avatar.attach(io: File.open(Rails.root.join("test", "support", "sample.png")), filename: "sample.png")
    Rails.cache.write('123', user.avatar.blob)
    cached_blob = Rails.cache.read('123')

    assert_equal user.avatar.blob, cached_blob
    assert_equal user.avatar.blob.id, cached_blob.id
  end
end
