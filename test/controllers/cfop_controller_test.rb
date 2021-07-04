require 'test_helper'

class CfopControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cfop = cfop(:one)
  end

  test "should get index" do
    get cfop_index_url
    assert_response :success
  end

  test "should get new" do
    get new_cfop_url
    assert_response :success
  end

  test "should create cfop" do
    assert_difference('Cfop.count') do
      post cfop_index_url, params: { cfop: { calcular_impostos_sn: @cfop.calcular_impostos_sn, cfop_de: @cfop.cfop_de, cfop_fe: @cfop.cfop_fe, cfop_st_de: @cfop.cfop_st_de, cfop_st_fe: @cfop.cfop_st_fe, cliente_fornecedor_cf: @cfop.cliente_fornecedor_cf, descricao: @cfop.descricao, entrada_saida_es: @cfop.entrada_saida_es, faturamento_sn: @cfop.faturamento_sn, natureza_operacao: @cfop.natureza_operacao, natureza_operacao_st: @cfop.natureza_operacao_st, nota_complementar_impostos_sn: @cfop.nota_complementar_impostos_sn, observacao: @cfop.observacao, operacao: @cfop.operacao } }
    end

    assert_redirected_to cfop_url(Cfop.last)
  end

  test "should show cfop" do
    get cfop_url(@cfop)
    assert_response :success
  end

  test "should get edit" do
    get edit_cfop_url(@cfop)
    assert_response :success
  end

  test "should update cfop" do
    patch cfop_url(@cfop), params: { cfop: { calcular_impostos_sn: @cfop.calcular_impostos_sn, cfop_de: @cfop.cfop_de, cfop_fe: @cfop.cfop_fe, cfop_st_de: @cfop.cfop_st_de, cfop_st_fe: @cfop.cfop_st_fe, cliente_fornecedor_cf: @cfop.cliente_fornecedor_cf, descricao: @cfop.descricao, entrada_saida_es: @cfop.entrada_saida_es, faturamento_sn: @cfop.faturamento_sn, natureza_operacao: @cfop.natureza_operacao, natureza_operacao_st: @cfop.natureza_operacao_st, nota_complementar_impostos_sn: @cfop.nota_complementar_impostos_sn, observacao: @cfop.observacao, operacao: @cfop.operacao } }
    assert_redirected_to cfop_url(@cfop)
  end

  test "should destroy cfop" do
    assert_difference('Cfop.count', -1) do
      delete cfop_url(@cfop)
    end

    assert_redirected_to cfop_index_url
  end
end
