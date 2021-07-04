require "application_system_test_case"

class NotaFiscaisTest < ApplicationSystemTestCase
  setup do
    @nota_fiscal = nota_fiscais(:one)
  end

  test "visiting the index" do
    visit nota_fiscais_url
    assert_selector "h1", text: "Nota Fiscais"
  end

  test "creating a Nota fiscal" do
    visit nota_fiscais_url
    click_on "New Nota Fiscal"

    fill_in "Cfop", with: @nota_fiscal.cfop_id
    fill_in "Chave acesso nfe", with: @nota_fiscal.chave_acesso_nfe
    fill_in "Cliente", with: @nota_fiscal.cliente_id
    fill_in "Data emissao", with: @nota_fiscal.data_emissao
    fill_in "Data saida", with: @nota_fiscal.data_saida
    fill_in "Entsai", with: @nota_fiscal.entsai
    fill_in "Fornecedor", with: @nota_fiscal.fornecedor_id
    fill_in "Hora saida", with: @nota_fiscal.hora_saida
    fill_in "Meio pagamento", with: @nota_fiscal.meio_pagamento
    fill_in "Nota cancelada sn", with: @nota_fiscal.nota_cancelada_sn
    fill_in "Numero nota", with: @nota_fiscal.numero_nota
    fill_in "Numero parcelas pagamento", with: @nota_fiscal.numero_parcelas_pagamento
    fill_in "Numero pedido", with: @nota_fiscal.numero_pedido
    fill_in "Numero pedido compra", with: @nota_fiscal.numero_pedido_compra
    fill_in "Observacao", with: @nota_fiscal.observacao
    fill_in "Tipo pagamento", with: @nota_fiscal.tipo_pagamento
    fill_in "Valor desconto", with: @nota_fiscal.valor_desconto
    fill_in "Valor frete", with: @nota_fiscal.valor_frete
    fill_in "Valor outras despesas", with: @nota_fiscal.valor_outras_despesas
    fill_in "Valor produtos", with: @nota_fiscal.valor_produtos
    fill_in "Valor total nota", with: @nota_fiscal.valor_total_nota
    fill_in "Vendedor", with: @nota_fiscal.vendedor_id
    click_on "Create Nota fiscal"

    assert_text "Nota fiscal was successfully created"
    click_on "Back"
  end

  test "updating a Nota fiscal" do
    visit nota_fiscais_url
    click_on "Edit", match: :first

    fill_in "Cfop", with: @nota_fiscal.cfop_id
    fill_in "Chave acesso nfe", with: @nota_fiscal.chave_acesso_nfe
    fill_in "Cliente", with: @nota_fiscal.cliente_id
    fill_in "Data emissao", with: @nota_fiscal.data_emissao
    fill_in "Data saida", with: @nota_fiscal.data_saida
    fill_in "Entsai", with: @nota_fiscal.entsai
    fill_in "Fornecedor", with: @nota_fiscal.fornecedor_id
    fill_in "Hora saida", with: @nota_fiscal.hora_saida
    fill_in "Meio pagamento", with: @nota_fiscal.meio_pagamento
    fill_in "Nota cancelada sn", with: @nota_fiscal.nota_cancelada_sn
    fill_in "Numero nota", with: @nota_fiscal.numero_nota
    fill_in "Numero parcelas pagamento", with: @nota_fiscal.numero_parcelas_pagamento
    fill_in "Numero pedido", with: @nota_fiscal.numero_pedido
    fill_in "Numero pedido compra", with: @nota_fiscal.numero_pedido_compra
    fill_in "Observacao", with: @nota_fiscal.observacao
    fill_in "Tipo pagamento", with: @nota_fiscal.tipo_pagamento
    fill_in "Valor desconto", with: @nota_fiscal.valor_desconto
    fill_in "Valor frete", with: @nota_fiscal.valor_frete
    fill_in "Valor outras despesas", with: @nota_fiscal.valor_outras_despesas
    fill_in "Valor produtos", with: @nota_fiscal.valor_produtos
    fill_in "Valor total nota", with: @nota_fiscal.valor_total_nota
    fill_in "Vendedor", with: @nota_fiscal.vendedor_id
    click_on "Update Nota fiscal"

    assert_text "Nota fiscal was successfully updated"
    click_on "Back"
  end

  test "destroying a Nota fiscal" do
    visit nota_fiscais_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Nota fiscal was successfully destroyed"
  end
end
