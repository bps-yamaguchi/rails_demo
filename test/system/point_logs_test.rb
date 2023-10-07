require "application_system_test_case"

class PointLogsTest < ApplicationSystemTestCase
  setup do
    @point_log = point_logs(:one)
  end

  test "visiting the index" do
    visit point_logs_url
    assert_selector "h1", text: "Point logs"
  end

  test "should create point log" do
    visit point_logs_url
    click_on "New point log"

    fill_in "Reason", with: @point_log.reason
    fill_in "Type", with: @point_log.type
    fill_in "Value", with: @point_log.value
    click_on "Create Point log"

    assert_text "Point log was successfully created"
    click_on "Back"
  end

  test "should update Point log" do
    visit point_log_url(@point_log)
    click_on "Edit this point log", match: :first

    fill_in "Reason", with: @point_log.reason
    fill_in "Type", with: @point_log.type
    fill_in "Value", with: @point_log.value
    click_on "Update Point log"

    assert_text "Point log was successfully updated"
    click_on "Back"
  end

  test "should destroy Point log" do
    visit point_log_url(@point_log)
    click_on "Destroy this point log", match: :first

    assert_text "Point log was successfully destroyed"
  end
end
