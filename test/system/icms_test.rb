require "application_system_test_case"

class IcmsTest < ApplicationSystemTestCase
  setup do
    @icms = icms(:one)
  end

  test "visiting the index" do
    visit icms_url
    assert_selector "h1", text: "Icms"
  end

  test "creating a Icms" do
    visit icms_url
    click_on "New Icms"

    fill_in "Aliquota icms", with: @icms.aliquota_icms
    fill_in "Aliquota icms st", with: @icms.aliquota_icms_st
    fill_in "Estado", with: @icms.estado
    fill_in "Fcp pc", with: @icms.fcp_pc
    fill_in "Fcp sn", with: @icms.fcp_sn
    fill_in "Mva icms st", with: @icms.mva_icms_st
    click_on "Create Icms"

    assert_text "Icms was successfully created"
    click_on "Back"
  end

  test "updating a Icms" do
    visit icms_url
    click_on "Edit", match: :first

    fill_in "Aliquota icms", with: @icms.aliquota_icms
    fill_in "Aliquota icms st", with: @icms.aliquota_icms_st
    fill_in "Estado", with: @icms.estado
    fill_in "Fcp pc", with: @icms.fcp_pc
    fill_in "Fcp sn", with: @icms.fcp_sn
    fill_in "Mva icms st", with: @icms.mva_icms_st
    click_on "Update Icms"

    assert_text "Icms was successfully updated"
    click_on "Back"
  end

  test "destroying a Icms" do
    visit icms_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Icms was successfully destroyed"
  end
end
