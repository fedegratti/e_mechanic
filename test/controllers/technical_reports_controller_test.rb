require 'test_helper'

class TechnicalReportsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @technical_report = technical_reports(:one)
  end

  test "should get index" do
    get technical_reports_url
    assert_response :success
  end

  test "should get new" do
    get new_technical_report_url
    assert_response :success
  end

  test "should create technical_report" do
    assert_difference('TechnicalReport.count') do
      post technical_reports_url, params: { technical_report: { picture: @technical_report.picture } }
    end

    assert_redirected_to technical_report_url(TechnicalReport.last)
  end

  test "should show technical_report" do
    get technical_report_url(@technical_report)
    assert_response :success
  end

  test "should get edit" do
    get edit_technical_report_url(@technical_report)
    assert_response :success
  end

  test "should update technical_report" do
    patch technical_report_url(@technical_report), params: { technical_report: { picture: @technical_report.picture } }
    assert_redirected_to technical_report_url(@technical_report)
  end

  test "should destroy technical_report" do
    assert_difference('TechnicalReport.count', -1) do
      delete technical_report_url(@technical_report)
    end

    assert_redirected_to technical_reports_url
  end
end
