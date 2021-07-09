require 'test_helper'

class ContasRecControllerTest < ActionDispatch::IntegrationTest
  setup do
    @contas_rec = contas_rec(:one)
  end

  test "should get index" do
    get contas_rec_index_url
    assert_response :success
  end

  test "should get new" do
    get new_contas_rec_url
    assert_response :success
  end

  test "should create contas_rec" do
    assert_difference('ContasRec.count') do
      post contas_rec_index_url, params: { contas_rec: { cliente_id: @contas_rec.cliente_id, data_emissao: @contas_rec.data_emissao, documento: @contas_rec.documento, historico: @contas_rec.historico, plano_conta_id: @contas_rec.plano_conta_id, valor_total: @contas_rec.valor_total } }
    end

    assert_redirected_to contas_rec_url(ContasRec.last)
  end

  test "should show contas_rec" do
    get contas_rec_url(@contas_rec)
    assert_response :success
  end

  test "should get edit" do
    get edit_contas_rec_url(@contas_rec)
    assert_response :success
  end

  test "should update contas_rec" do
    patch contas_rec_url(@contas_rec), params: { contas_rec: { cliente_id: @contas_rec.cliente_id, data_emissao: @contas_rec.data_emissao, documento: @contas_rec.documento, historico: @contas_rec.historico, plano_conta_id: @contas_rec.plano_conta_id, valor_total: @contas_rec.valor_total } }
    assert_redirected_to contas_rec_url(@contas_rec)
  end

  test "should destroy contas_rec" do
    assert_difference('ContasRec.count', -1) do
      delete contas_rec_url(@contas_rec)
    end

    assert_redirected_to contas_rec_index_url
  end
end
