require 'test_helper'

class PlanoContasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @plano_conta = plano_contas(:one)
  end

  test "should get index" do
    get plano_contas_url
    assert_response :success
  end

  test "should get new" do
    get new_plano_conta_url
    assert_response :success
  end

  test "should create plano_conta" do
    assert_difference('PlanoConta.count') do
      post plano_contas_url, params: { plano_conta: { conta: @plano_conta.conta, descricao: @plano_conta.descricao, grau: @plano_conta.grau } }
    end

    assert_redirected_to plano_conta_url(PlanoConta.last)
  end

  test "should show plano_conta" do
    get plano_conta_url(@plano_conta)
    assert_response :success
  end

  test "should get edit" do
    get edit_plano_conta_url(@plano_conta)
    assert_response :success
  end

  test "should update plano_conta" do
    patch plano_conta_url(@plano_conta), params: { plano_conta: { conta: @plano_conta.conta, descricao: @plano_conta.descricao, grau: @plano_conta.grau } }
    assert_redirected_to plano_conta_url(@plano_conta)
  end

  test "should destroy plano_conta" do
    assert_difference('PlanoConta.count', -1) do
      delete plano_conta_url(@plano_conta)
    end

    assert_redirected_to plano_contas_url
  end
end
