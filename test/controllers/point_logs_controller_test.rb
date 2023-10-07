require "test_helper"

class PointLogsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @point_log = point_logs(:one)
  end

  test "should get index" do
    get point_logs_url
    assert_response :success
  end

  test "should get new" do
    get new_point_log_url
    assert_response :success
  end

  test "should create point_log" do
    assert_difference("PointLog.count") do
      post point_logs_url, params: { point_log: { reason: @point_log.reason, type: @point_log.type, value: @point_log.value } }
    end

    assert_redirected_to point_log_url(PointLog.last)
  end

  test "should show point_log" do
    get point_log_url(@point_log)
    assert_response :success
  end

  test "should get edit" do
    get edit_point_log_url(@point_log)
    assert_response :success
  end

  test "should update point_log" do
    patch point_log_url(@point_log), params: { point_log: { reason: @point_log.reason, type: @point_log.type, value: @point_log.value } }
    assert_redirected_to point_log_url(@point_log)
  end

  test "should destroy point_log" do
    assert_difference("PointLog.count", -1) do
      delete point_log_url(@point_log)
    end

    assert_redirected_to point_logs_url
  end
end
