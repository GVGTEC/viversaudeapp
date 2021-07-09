require "application_system_test_case"

class ContasRecTest < ApplicationSystemTestCase
  setup do
    @contas_rec = contas_rec(:one)
  end

  test "visiting the index" do
    visit contas_rec_url
    assert_selector "h1", text: "Contas Rec"
  end

  test "creating a Contas rec" do
    visit contas_rec_url
    click_on "New Contas Rec"

    fill_in "Cliente", with: @contas_rec.cliente_id
    fill_in "Data emissao", with: @contas_rec.data_emissao
    fill_in "Documento", with: @contas_rec.documento
    fill_in "Historico", with: @contas_rec.historico
    fill_in "Plano conta", with: @contas_rec.plano_conta_id
    fill_in "Valor total", with: @contas_rec.valor_total
    click_on "Create Contas rec"

    assert_text "Contas rec was successfully created"
    click_on "Back"
  end

  test "updating a Contas rec" do
    visit contas_rec_url
    click_on "Edit", match: :first

    fill_in "Cliente", with: @contas_rec.cliente_id
    fill_in "Data emissao", with: @contas_rec.data_emissao
    fill_in "Documento", with: @contas_rec.documento
    fill_in "Historico", with: @contas_rec.historico
    fill_in "Plano conta", with: @contas_rec.plano_conta_id
    fill_in "Valor total", with: @contas_rec.valor_total
    click_on "Update Contas rec"

    assert_text "Contas rec was successfully updated"
    click_on "Back"
  end

  test "destroying a Contas rec" do
    visit contas_rec_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Contas rec was successfully destroyed"
  end
end
