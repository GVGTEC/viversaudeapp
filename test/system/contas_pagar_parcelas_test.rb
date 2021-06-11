require "application_system_test_case"

class ContasPagarParcelasTest < ApplicationSystemTestCase
  setup do
    @contas_pagar_parcela = contas_pagar_parcelas(:one)
  end

  test "visiting the index" do
    visit contas_pagar_parcelas_url
    assert_selector "h1", text: "Contas Pagar Parcelas"
  end

  test "creating a Contas pagar parcela" do
    visit contas_pagar_parcelas_url
    click_on "New Contas Pagar Parcela"

    fill_in "Contas pagar", with: @contas_pagar_parcela.contas_pagar_id
    fill_in "Data pagamento", with: @contas_pagar_parcela.data_pagamento
    fill_in "Data vencimento", with: @contas_pagar_parcela.data_vencimento
    fill_in "Descricao", with: @contas_pagar_parcela.descricao
    fill_in "Documento", with: @contas_pagar_parcela.documento
    fill_in "Valor juros desconto", with: @contas_pagar_parcela.valor_juros_desconto
    fill_in "Valor parcela", with: @contas_pagar_parcela.valor_parcela
    click_on "Create Contas pagar parcela"

    assert_text "Contas pagar parcela was successfully created"
    click_on "Back"
  end

  test "updating a Contas pagar parcela" do
    visit contas_pagar_parcelas_url
    click_on "Edit", match: :first

    fill_in "Contas pagar", with: @contas_pagar_parcela.contas_pagar_id
    fill_in "Data pagamento", with: @contas_pagar_parcela.data_pagamento
    fill_in "Data vencimento", with: @contas_pagar_parcela.data_vencimento
    fill_in "Descricao", with: @contas_pagar_parcela.descricao
    fill_in "Documento", with: @contas_pagar_parcela.documento
    fill_in "Valor juros desconto", with: @contas_pagar_parcela.valor_juros_desconto
    fill_in "Valor parcela", with: @contas_pagar_parcela.valor_parcela
    click_on "Update Contas pagar parcela"

    assert_text "Contas pagar parcela was successfully updated"
    click_on "Back"
  end

  test "destroying a Contas pagar parcela" do
    visit contas_pagar_parcelas_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Contas pagar parcela was successfully destroyed"
  end
end
