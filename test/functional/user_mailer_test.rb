require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "caregiver_invite" do
    mail = UserMailer.caregiver_invite
    assert_equal "Caregiver invite", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
