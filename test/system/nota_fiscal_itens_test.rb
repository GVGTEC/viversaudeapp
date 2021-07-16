require "application_system_test_case"

class NotaFiscalItensTest < ApplicationSystemTestCase
  setup do
    @nota_fiscal_item = nota_fiscal_itens(:one)
  end

  test "visiting the index" do
    visit nota_fiscal_itens_url
    assert_selector "h1", text: "Nota Fiscal Itens"
  end

  test "creating a Nota fiscal item" do
    visit nota_fiscal_itens_url
    click_on "New Nota Fiscal Item"

    fill_in "Aliquota cofins", with: @nota_fiscal_item.aliquota_cofins
    fill_in "Aliquota difal", with: @nota_fiscal_item.aliquota_difal
    fill_in "Aliquota fcp", with: @nota_fiscal_item.aliquota_fcp
    fill_in "Aliquota icms", with: @nota_fiscal_item.aliquota_icms
    fill_in "Aliquota icms st", with: @nota_fiscal_item.aliquota_icms_st
    fill_in "Aliquota ipi", with: @nota_fiscal_item.aliquota_ipi
    fill_in "Aliquota pis", with: @nota_fiscal_item.aliquota_pis
    check "Baixou estoque" if @nota_fiscal_item.baixou_estoque
    fill_in "Cfop", with: @nota_fiscal_item.cfop
    fill_in "Comissao ter pc", with: @nota_fiscal_item.comissao_ter_pc
    fill_in "Comissao ter vr", with: @nota_fiscal_item.comissao_ter_vr
    fill_in "Comissao ven pc", with: @nota_fiscal_item.comissao_ven_pc
    fill_in "Comissao ven vr", with: @nota_fiscal_item.comissao_ven_vr
    fill_in "Cst", with: @nota_fiscal_item.cst
    fill_in "Descricao", with: @nota_fiscal_item.descricao
    fill_in "Local estoque", with: @nota_fiscal_item.local_estoque
    fill_in "Ncm", with: @nota_fiscal_item.ncm
    fill_in "Nota fiscal", with: @nota_fiscal_item.nota_fiscal_id
    fill_in "Pagar comissao sn", with: @nota_fiscal_item.pagar_comissao_sn
    fill_in "Preco total", with: @nota_fiscal_item.preco_total
    fill_in "Preco unitario", with: @nota_fiscal_item.preco_unitario
    fill_in "Produto", with: @nota_fiscal_item.produto_id
    fill_in "Quantidade", with: @nota_fiscal_item.quantidade
    fill_in "St", with: @nota_fiscal_item.st
    fill_in "Unidade", with: @nota_fiscal_item.unidade
    fill_in "Valor bc icms", with: @nota_fiscal_item.valor_bc_icms
    fill_in "Valor bc icms st", with: @nota_fiscal_item.valor_bc_icms_st
    fill_in "Valor cofins", with: @nota_fiscal_item.valor_cofins
    fill_in "Valor difal", with: @nota_fiscal_item.valor_difal
    fill_in "Valor fcp", with: @nota_fiscal_item.valor_fcp
    fill_in "Valor icms", with: @nota_fiscal_item.valor_icms
    fill_in "Valor icms st", with: @nota_fiscal_item.valor_icms_st
    fill_in "Valor ipi", with: @nota_fiscal_item.valor_ipi
    fill_in "Valor pis", with: @nota_fiscal_item.valor_pis
    click_on "Create Nota fiscal item"

    assert_text "Nota fiscal item was successfully created"
    click_on "Back"
  end

  test "updating a Nota fiscal item" do
    visit nota_fiscal_itens_url
    click_on "Edit", match: :first

    fill_in "Aliquota cofins", with: @nota_fiscal_item.aliquota_cofins
    fill_in "Aliquota difal", with: @nota_fiscal_item.aliquota_difal
    fill_in "Aliquota fcp", with: @nota_fiscal_item.aliquota_fcp
    fill_in "Aliquota icms", with: @nota_fiscal_item.aliquota_icms
    fill_in "Aliquota icms st", with: @nota_fiscal_item.aliquota_icms_st
    fill_in "Aliquota ipi", with: @nota_fiscal_item.aliquota_ipi
    fill_in "Aliquota pis", with: @nota_fiscal_item.aliquota_pis
    check "Baixou estoque" if @nota_fiscal_item.baixou_estoque
    fill_in "Cfop", with: @nota_fiscal_item.cfop
    fill_in "Comissao ter pc", with: @nota_fiscal_item.comissao_ter_pc
    fill_in "Comissao ter vr", with: @nota_fiscal_item.comissao_ter_vr
    fill_in "Comissao ven pc", with: @nota_fiscal_item.comissao_ven_pc
    fill_in "Comissao ven vr", with: @nota_fiscal_item.comissao_ven_vr
    fill_in "Cst", with: @nota_fiscal_item.cst
    fill_in "Descricao", with: @nota_fiscal_item.descricao
    fill_in "Local estoque", with: @nota_fiscal_item.local_estoque
    fill_in "Ncm", with: @nota_fiscal_item.ncm
    fill_in "Nota fiscal", with: @nota_fiscal_item.nota_fiscal_id
    fill_in "Pagar comissao sn", with: @nota_fiscal_item.pagar_comissao_sn
    fill_in "Preco total", with: @nota_fiscal_item.preco_total
    fill_in "Preco unitario", with: @nota_fiscal_item.preco_unitario
    fill_in "Produto", with: @nota_fiscal_item.produto_id
    fill_in "Quantidade", with: @nota_fiscal_item.quantidade
    fill_in "St", with: @nota_fiscal_item.st
    fill_in "Unidade", with: @nota_fiscal_item.unidade
    fill_in "Valor bc icms", with: @nota_fiscal_item.valor_bc_icms
    fill_in "Valor bc icms st", with: @nota_fiscal_item.valor_bc_icms_st
    fill_in "Valor cofins", with: @nota_fiscal_item.valor_cofins
    fill_in "Valor difal", with: @nota_fiscal_item.valor_difal
    fill_in "Valor fcp", with: @nota_fiscal_item.valor_fcp
    fill_in "Valor icms", with: @nota_fiscal_item.valor_icms
    fill_in "Valor icms st", with: @nota_fiscal_item.valor_icms_st
    fill_in "Valor ipi", with: @nota_fiscal_item.valor_ipi
    fill_in "Valor pis", with: @nota_fiscal_item.valor_pis
    click_on "Update Nota fiscal item"

    assert_text "Nota fiscal item was successfully updated"
    click_on "Back"
  end

  test "destroying a Nota fiscal item" do
    visit nota_fiscal_itens_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Nota fiscal item was successfully destroyed"
  end
end
