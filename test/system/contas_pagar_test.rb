require "application_system_test_case"

class ContasPagarTest < ApplicationSystemTestCase
  setup do
    @contas_pagar = contas_pagar(:one)
  end

  test "visiting the index" do
    visit contas_pagar_url
    assert_selector "h1", text: "Contas Pagar"
  end

  test "creating a Contas pagar" do
    visit contas_pagar_url
    click_on "New Contas Pagar"

    fill_in "Data emissao", with: @contas_pagar.data_emissao
    fill_in "Documento", with: @contas_pagar.documento
    fill_in "Fornecedores", with: @contas_pagar.fornecedores_id
    fill_in "Historico", with: @contas_pagar.historico
    fill_in "Plano contas", with: @contas_pagar.plano_contas_id
    fill_in "Valor total", with: @contas_pagar.valor_total
    click_on "Create Contas pagar"

    assert_text "Contas pagar was successfully created"
    click_on "Back"
  end

  test "updating a Contas pagar" do
    visit contas_pagar_url
    click_on "Edit", match: :first

    fill_in "Data emissao", with: @contas_pagar.data_emissao
    fill_in "Documento", with: @contas_pagar.documento
    fill_in "Fornecedores", with: @contas_pagar.fornecedores_id
    fill_in "Historico", with: @contas_pagar.historico
    fill_in "Plano contas", with: @contas_pagar.plano_contas_id
    fill_in "Valor total", with: @contas_pagar.valor_total
    click_on "Update Contas pagar"

    assert_text "Contas pagar was successfully updated"
    click_on "Back"
  end

  test "destroying a Contas pagar" do
    visit contas_pagar_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Contas pagar was successfully destroyed"
  end
end
