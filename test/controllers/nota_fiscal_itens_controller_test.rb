require 'test_helper'

class NotaFiscalItensControllerTest < ActionDispatch::IntegrationTest
  setup do
    @nota_fiscal_item = nota_fiscal_itens(:one)
  end

  test "should get index" do
    get nota_fiscal_itens_url
    assert_response :success
  end

  test "should get new" do
    get new_nota_fiscal_item_url
    assert_response :success
  end

  test "should create nota_fiscal_item" do
    assert_difference('NotaFiscalItem.count') do
      post nota_fiscal_itens_url, params: { nota_fiscal_item: { aliquota_cofins: @nota_fiscal_item.aliquota_cofins, aliquota_difal: @nota_fiscal_item.aliquota_difal, aliquota_fcp: @nota_fiscal_item.aliquota_fcp, aliquota_icms: @nota_fiscal_item.aliquota_icms, aliquota_icms_st: @nota_fiscal_item.aliquota_icms_st, aliquota_ipi: @nota_fiscal_item.aliquota_ipi, aliquota_pis: @nota_fiscal_item.aliquota_pis, baixou_estoque: @nota_fiscal_item.baixou_estoque, cfop: @nota_fiscal_item.cfop, comissao_ter_pc: @nota_fiscal_item.comissao_ter_pc, comissao_ter_vr: @nota_fiscal_item.comissao_ter_vr, comissao_ven_pc: @nota_fiscal_item.comissao_ven_pc, comissao_ven_vr: @nota_fiscal_item.comissao_ven_vr, cst: @nota_fiscal_item.cst, descricao: @nota_fiscal_item.descricao, local_estoque: @nota_fiscal_item.local_estoque, ncm: @nota_fiscal_item.ncm, nota_fiscal_id: @nota_fiscal_item.nota_fiscal_id, pagar_comissao_sn: @nota_fiscal_item.pagar_comissao_sn, preco_total: @nota_fiscal_item.preco_total, preco_unitario: @nota_fiscal_item.preco_unitario, produto_id: @nota_fiscal_item.produto_id, quantidade: @nota_fiscal_item.quantidade, st: @nota_fiscal_item.st, unidade: @nota_fiscal_item.unidade, valor_bc_icms: @nota_fiscal_item.valor_bc_icms, valor_bc_icms_st: @nota_fiscal_item.valor_bc_icms_st, valor_cofins: @nota_fiscal_item.valor_cofins, valor_difal: @nota_fiscal_item.valor_difal, valor_fcp: @nota_fiscal_item.valor_fcp, valor_icms: @nota_fiscal_item.valor_icms, valor_icms_st: @nota_fiscal_item.valor_icms_st, valor_ipi: @nota_fiscal_item.valor_ipi, valor_pis: @nota_fiscal_item.valor_pis } }
    end

    assert_redirected_to nota_fiscal_item_url(NotaFiscalItem.last)
  end

  test "should show nota_fiscal_item" do
    get nota_fiscal_item_url(@nota_fiscal_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_nota_fiscal_item_url(@nota_fiscal_item)
    assert_response :success
  end

  test "should update nota_fiscal_item" do
    patch nota_fiscal_item_url(@nota_fiscal_item), params: { nota_fiscal_item: { aliquota_cofins: @nota_fiscal_item.aliquota_cofins, aliquota_difal: @nota_fiscal_item.aliquota_difal, aliquota_fcp: @nota_fiscal_item.aliquota_fcp, aliquota_icms: @nota_fiscal_item.aliquota_icms, aliquota_icms_st: @nota_fiscal_item.aliquota_icms_st, aliquota_ipi: @nota_fiscal_item.aliquota_ipi, aliquota_pis: @nota_fiscal_item.aliquota_pis, baixou_estoque: @nota_fiscal_item.baixou_estoque, cfop: @nota_fiscal_item.cfop, comissao_ter_pc: @nota_fiscal_item.comissao_ter_pc, comissao_ter_vr: @nota_fiscal_item.comissao_ter_vr, comissao_ven_pc: @nota_fiscal_item.comissao_ven_pc, comissao_ven_vr: @nota_fiscal_item.comissao_ven_vr, cst: @nota_fiscal_item.cst, descricao: @nota_fiscal_item.descricao, local_estoque: @nota_fiscal_item.local_estoque, ncm: @nota_fiscal_item.ncm, nota_fiscal_id: @nota_fiscal_item.nota_fiscal_id, pagar_comissao_sn: @nota_fiscal_item.pagar_comissao_sn, preco_total: @nota_fiscal_item.preco_total, preco_unitario: @nota_fiscal_item.preco_unitario, produto_id: @nota_fiscal_item.produto_id, quantidade: @nota_fiscal_item.quantidade, st: @nota_fiscal_item.st, unidade: @nota_fiscal_item.unidade, valor_bc_icms: @nota_fiscal_item.valor_bc_icms, valor_bc_icms_st: @nota_fiscal_item.valor_bc_icms_st, valor_cofins: @nota_fiscal_item.valor_cofins, valor_difal: @nota_fiscal_item.valor_difal, valor_fcp: @nota_fiscal_item.valor_fcp, valor_icms: @nota_fiscal_item.valor_icms, valor_icms_st: @nota_fiscal_item.valor_icms_st, valor_ipi: @nota_fiscal_item.valor_ipi, valor_pis: @nota_fiscal_item.valor_pis } }
    assert_redirected_to nota_fiscal_item_url(@nota_fiscal_item)
  end

  test "should destroy nota_fiscal_item" do
    assert_difference('NotaFiscalItem.count', -1) do
      delete nota_fiscal_item_url(@nota_fiscal_item)
    end

    assert_redirected_to nota_fiscal_itens_url
  end
end
