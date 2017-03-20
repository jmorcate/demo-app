require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @common_part_title = "The SSSB TDY Application"
  end
  test "should get home" do
    get static_pages_home_url
    assert_response :success
    assert_select "title", full_title
  end

  test "should get help" do
    get static_pages_help_url
    assert_response :success
    assert_select "title", full_title("Help")
  end
  
  test 'should get about' do
    get static_pages_about_url
    assert_response :success
    assert_select "title", full_title("About")
  end
end
