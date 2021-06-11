require 'test_helper'

class ContasPagarParcelasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @contas_pagar_parcela = contas_pagar_parcelas(:one)
  end

  test "should get index" do
    get contas_pagar_parcelas_url
    assert_response :success
  end

  test "should get new" do
    get new_contas_pagar_parcela_url
    assert_response :success
  end

  test "should create contas_pagar_parcela" do
    assert_difference('ContasPagarParcela.count') do
      post contas_pagar_parcelas_url, params: { contas_pagar_parcela: { contas_pagar_id: @contas_pagar_parcela.contas_pagar_id, data_pagamento: @contas_pagar_parcela.data_pagamento, data_vencimento: @contas_pagar_parcela.data_vencimento, descricao: @contas_pagar_parcela.descricao, documento: @contas_pagar_parcela.documento, valor_juros_desconto: @contas_pagar_parcela.valor_juros_desconto, valor_parcela: @contas_pagar_parcela.valor_parcela } }
    end

    assert_redirected_to contas_pagar_parcela_url(ContasPagarParcela.last)
  end

  test "should show contas_pagar_parcela" do
    get contas_pagar_parcela_url(@contas_pagar_parcela)
    assert_response :success
  end

  test "should get edit" do
    get edit_contas_pagar_parcela_url(@contas_pagar_parcela)
    assert_response :success
  end

  test "should update contas_pagar_parcela" do
    patch contas_pagar_parcela_url(@contas_pagar_parcela), params: { contas_pagar_parcela: { contas_pagar_id: @contas_pagar_parcela.contas_pagar_id, data_pagamento: @contas_pagar_parcela.data_pagamento, data_vencimento: @contas_pagar_parcela.data_vencimento, descricao: @contas_pagar_parcela.descricao, documento: @contas_pagar_parcela.documento, valor_juros_desconto: @contas_pagar_parcela.valor_juros_desconto, valor_parcela: @contas_pagar_parcela.valor_parcela } }
    assert_redirected_to contas_pagar_parcela_url(@contas_pagar_parcela)
  end

  test "should destroy contas_pagar_parcela" do
    assert_difference('ContasPagarParcela.count', -1) do
      delete contas_pagar_parcela_url(@contas_pagar_parcela)
    end

    assert_redirected_to contas_pagar_parcelas_url
  end
end
