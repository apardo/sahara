require 'test_helper'

class MailmanTest < ActionMailer::TestCase
  test "send_activation_code" do
    mail = Mailman.send_activation_code
    assert_equal "Send activation code", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
