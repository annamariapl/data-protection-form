require 'test_helper'

class AgreementsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get agreements_new_url
    assert_response :success
  end

  test "should get create" do
    get agreements_create_url
    assert_response :success
  end

end
