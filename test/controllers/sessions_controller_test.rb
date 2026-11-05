require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "login page renders" do
    get login_url

    assert_response :success
    assert_select "form[action='#{login_path}'][method='post']"
  end

  test "invalid credentials redirect back to login" do
    post login_url, params: { username: "", password: "" }

    assert_redirected_to login_url
    assert_equal "Invalid username or password.", flash[:error]
  end
end
