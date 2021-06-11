require 'test_helper'

class TransportadorasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @transportadora = transportadoras(:one)
  end

  test "should get index" do
    get transportadoras_url
    assert_response :success
  end

  test "should get new" do
    get new_transportadora_url
    assert_response :success
  end

  test "should create transportadora" do
    assert_difference('Transportadora.count') do
      post transportadoras_url, params: { transportadora: { bairro: @transportadora.bairro, cep: @transportadora.cep, cidade: @transportadora.cidade, cnpj: @transportadora.cnpj, endereco: @transportadora.endereco, ie: @transportadora.ie, nome: @transportadora.nome, uf: @transportadora.uf } }
    end

    assert_redirected_to transportadora_url(Transportadora.last)
  end

  test "should show transportadora" do
    get transportadora_url(@transportadora)
    assert_response :success
  end

  test "should get edit" do
    get edit_transportadora_url(@transportadora)
    assert_response :success
  end

  test "should update transportadora" do
    patch transportadora_url(@transportadora), params: { transportadora: { bairro: @transportadora.bairro, cep: @transportadora.cep, cidade: @transportadora.cidade, cnpj: @transportadora.cnpj, endereco: @transportadora.endereco, ie: @transportadora.ie, nome: @transportadora.nome, uf: @transportadora.uf } }
    assert_redirected_to transportadora_url(@transportadora)
  end

  test "should destroy transportadora" do
    assert_difference('Transportadora.count', -1) do
      delete transportadora_url(@transportadora)
    end

    assert_redirected_to transportadoras_url
  end
end
