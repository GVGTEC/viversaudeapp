require 'test_helper'

class ContasPagarControllerTest < ActionDispatch::IntegrationTest
  setup do
    @contas_pagar = contas_pagar(:one)
  end

  test "should get index" do
    get contas_pagar_index_url
    assert_response :success
  end

  test "should get new" do
    get new_contas_pagar_url
    assert_response :success
  end

  test "should create contas_pagar" do
    assert_difference('ContasPagar.count') do
      post contas_pagar_index_url, params: { contas_pagar: { data_emissao: @contas_pagar.data_emissao, documento: @contas_pagar.documento, fornecedores_id: @contas_pagar.fornecedores_id, historico: @contas_pagar.historico, plano_contas_id: @contas_pagar.plano_contas_id, valor_total: @contas_pagar.valor_total } }
    end

    assert_redirected_to contas_pagar_url(ContasPagar.last)
  end

  test "should show contas_pagar" do
    get contas_pagar_url(@contas_pagar)
    assert_response :success
  end

  test "should get edit" do
    get edit_contas_pagar_url(@contas_pagar)
    assert_response :success
  end

  test "should update contas_pagar" do
    patch contas_pagar_url(@contas_pagar), params: { contas_pagar: { data_emissao: @contas_pagar.data_emissao, documento: @contas_pagar.documento, fornecedores_id: @contas_pagar.fornecedores_id, historico: @contas_pagar.historico, plano_contas_id: @contas_pagar.plano_contas_id, valor_total: @contas_pagar.valor_total } }
    assert_redirected_to contas_pagar_url(@contas_pagar)
  end

  test "should destroy contas_pagar" do
    assert_difference('ContasPagar.count', -1) do
      delete contas_pagar_url(@contas_pagar)
    end

    assert_redirected_to contas_pagar_index_url
  end
end
