require 'test_helper'

class IcmsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @icms = icms(:one)
  end

  test "should get index" do
    get icms_index_url
    assert_response :success
  end

  test "should get new" do
    get new_icms_url
    assert_response :success
  end

  test "should create icms" do
    assert_difference('Icms.count') do
      post icms_index_url, params: { icms: { aliquota_icms: @icms.aliquota_icms, aliquota_icms_st: @icms.aliquota_icms_st, estado: @icms.estado, fcp_pc: @icms.fcp_pc, fcp_sn: @icms.fcp_sn, mva_icms_st: @icms.mva_icms_st } }
    end

    assert_redirected_to icms_url(Icms.last)
  end

  test "should show icms" do
    get icms_url(@icms)
    assert_response :success
  end

  test "should get edit" do
    get edit_icms_url(@icms)
    assert_response :success
  end

  test "should update icms" do
    patch icms_url(@icms), params: { icms: { aliquota_icms: @icms.aliquota_icms, aliquota_icms_st: @icms.aliquota_icms_st, estado: @icms.estado, fcp_pc: @icms.fcp_pc, fcp_sn: @icms.fcp_sn, mva_icms_st: @icms.mva_icms_st } }
    assert_redirected_to icms_url(@icms)
  end

  test "should destroy icms" do
    assert_difference('Icms.count', -1) do
      delete icms_url(@icms)
    end

    assert_redirected_to icms_index_url
  end
end
