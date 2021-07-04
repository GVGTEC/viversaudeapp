require "application_system_test_case"

class CfopTest < ApplicationSystemTestCase
  setup do
    @cfop = cfop(:one)
  end

  test "visiting the index" do
    visit cfop_url
    assert_selector "h1", text: "Cfop"
  end

  test "creating a Cfop" do
    visit cfop_url
    click_on "New Cfop"

    fill_in "Calcular impostos sn", with: @cfop.calcular_impostos_sn
    fill_in "Cfop de", with: @cfop.cfop_de
    fill_in "Cfop fe", with: @cfop.cfop_fe
    fill_in "Cfop st de", with: @cfop.cfop_st_de
    fill_in "Cfop st fe", with: @cfop.cfop_st_fe
    fill_in "Cliente fornecedor cf", with: @cfop.cliente_fornecedor_cf
    fill_in "Descricao", with: @cfop.descricao
    fill_in "Entrada saida es", with: @cfop.entrada_saida_es
    fill_in "Faturamento sn", with: @cfop.faturamento_sn
    fill_in "Natureza operacao", with: @cfop.natureza_operacao
    fill_in "Natureza operacao st", with: @cfop.natureza_operacao_st
    fill_in "Nota complementar impostos sn", with: @cfop.nota_complementar_impostos_sn
    fill_in "Observacao", with: @cfop.observacao
    fill_in "Operacao", with: @cfop.operacao
    click_on "Create Cfop"

    assert_text "Cfop was successfully created"
    click_on "Back"
  end

  test "updating a Cfop" do
    visit cfop_url
    click_on "Edit", match: :first

    fill_in "Calcular impostos sn", with: @cfop.calcular_impostos_sn
    fill_in "Cfop de", with: @cfop.cfop_de
    fill_in "Cfop fe", with: @cfop.cfop_fe
    fill_in "Cfop st de", with: @cfop.cfop_st_de
    fill_in "Cfop st fe", with: @cfop.cfop_st_fe
    fill_in "Cliente fornecedor cf", with: @cfop.cliente_fornecedor_cf
    fill_in "Descricao", with: @cfop.descricao
    fill_in "Entrada saida es", with: @cfop.entrada_saida_es
    fill_in "Faturamento sn", with: @cfop.faturamento_sn
    fill_in "Natureza operacao", with: @cfop.natureza_operacao
    fill_in "Natureza operacao st", with: @cfop.natureza_operacao_st
    fill_in "Nota complementar impostos sn", with: @cfop.nota_complementar_impostos_sn
    fill_in "Observacao", with: @cfop.observacao
    fill_in "Operacao", with: @cfop.operacao
    click_on "Update Cfop"

    assert_text "Cfop was successfully updated"
    click_on "Back"
  end

  test "destroying a Cfop" do
    visit cfop_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Cfop was successfully destroyed"
  end
end
