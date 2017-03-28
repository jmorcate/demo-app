require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    assert_no_difference 'User.count' do
      get signup_path
      post users_path, params: {user: {
                                  name: 'user',
                                  email: 'user@example.com',
                                  password: '1234567',
                                  password_confirmation: '2222222'}
      }
    end
    assert_template 'users/new'
  end
  
  test 'valis sigup information' do
    get signup_path
    assert_difference 'User.count', 1 do 
      post users_path, params: { user: {
                                  name: "Jorge Mi",
                                  email: "jorge@example.com",
                                  password: "123456",
                                  password_confirmation: '123456'}
      }
    end
    follow_redirect!
    assert_template 'users/show'
  end
end
