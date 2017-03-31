require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Cristiano Ronaldo", email:"crt@realmadrid.com", 
                     password: "123456", password_confirmation: "123456")
  end
  test 'user should be valid' do
    assert @user.valid?
  end
  test 'name should be present' do
    @user.name = "      "
    assert_not @user.valid?
  end
  test 'assert email is present' do
    @user.email = "          "
    assert_not @user.valid?
  end
  test 'name should not be to long' do
    @user.name = "a"*501
    assert_not @user.valid?
  end
  test 'email should not be too long' do
    @user.email = "a"*51
    assert_not @user.valid?
  end
  
  test 'valid addresses shoudl be accepted by the validator' do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |address|
      @user.email = address
      assert @user.valid?, "The address #{address.inspect} should be valid"
    end
  end
  test 'invalid addresses should be rejected by the validator' do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |address|
      @user.email = address
      assert_not @user.valid?, "The address #{address.inspect} should be rejected"
    end
  end
  
  test 'email should be unique' do
    @user.save
    user_dup = @user.dup
    assert_not user_dup.valid?
  end
  
  test 'email uniqueness shoudl not be case sensitive' do
    @user.email = @user.email.upcase
    @user.save
    user_dup = @user.dup
    user_dup.email = @user.email.downcase
    assert_not user_dup.valid?
  end
  
  test 'email should be saved in lowcase' do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end
  
  test 'password should be present' do
    @user.password=@user.password_confirmation= "        "
    assert_not @user.valid?
  end
  
  test 'password should not be too short' do
    @user.password=@user.password_confirmation="a"*5
    assert_not @user.valid?
  end
  test "authenticated? should return false for a user with nil digest" do
    @user.authenticated?("")
  end
end
