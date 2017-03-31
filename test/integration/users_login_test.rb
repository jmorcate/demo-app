require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  
  def setup 
    @user = users(:joaquin)
  end
  
  test 'log in with with invalid credentials' do
    get login_path
    assert_template 'sessions/new'
    post login_path, params:{ session: { 
                                email: 'nobody@example.com',
                                password: 'nopassword'}}
    assert_template 'sessions/new'
    assert_not flash.empty?
    
    get root_path
    assert flash.empty?
  end
  
  test "login with valid data" do
    get login_path
    post login_path, params:{ session: { 
                        email: @user.email,
                        password: "my_password"}}
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count:0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
  end
  
  test "login with valid information followed by logout" do
    get login_path
    post login_path, params: {session: { 
                                email: @user.email,
                                password: "my_password"}}
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template "users/show"
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_path
    follow_redirect!
    assert_template "static_pages/home"
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
    
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_path
    follow_redirect!
    assert_template "static_pages/home"
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
    
  end
  
  test "login with remembering" do 
    log_in_as(@user, password: 'my_password', remember_me: '1')
    assert_not_empty cookies['remember_token']
    assert_equal cookies['remember_token'], assigns(:user).remember_token
  end
  test "login without remembering" do
    # Log in to set the cookie.
    log_in_as(@user, password: 'my_password', remember_me: '1')
    # Log in again and verify that the cookie is deleted.
    log_in_as(@user, password: 'my_password', remember_me: '0')
    
  end

end
