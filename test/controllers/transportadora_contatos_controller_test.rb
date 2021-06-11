require 'test_helper'

class TransportadoraContatosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @transportadora_contato = transportadora_contatos(:one)
  end

  test "should get index" do
    get transportadora_contatos_url
    assert_response :success
  end

  test "should get new" do
    get new_transportadora_contato_url
    assert_response :success
  end

  test "should create transportadora_contato" do
    assert_difference('TransportadoraContato.count') do
      post transportadora_contatos_url, params: { transportadora_contato: { email: @transportadora_contato.email, nome: @transportadora_contato.nome, telefone: @transportadora_contato.telefone, transportadora_id: @transportadora_contato.transportadora_id } }
    end

    assert_redirected_to transportadora_contato_url(TransportadoraContato.last)
  end

  test "should show transportadora_contato" do
    get transportadora_contato_url(@transportadora_contato)
    assert_response :success
  end

  test "should get edit" do
    get edit_transportadora_contato_url(@transportadora_contato)
    assert_response :success
  end

  test "should update transportadora_contato" do
    patch transportadora_contato_url(@transportadora_contato), params: { transportadora_contato: { email: @transportadora_contato.email, nome: @transportadora_contato.nome, telefone: @transportadora_contato.telefone, transportadora_id: @transportadora_contato.transportadora_id } }
    assert_redirected_to transportadora_contato_url(@transportadora_contato)
  end

  test "should destroy transportadora_contato" do
    assert_difference('TransportadoraContato.count', -1) do
      delete transportadora_contato_url(@transportadora_contato)
    end

    assert_redirected_to transportadora_contatos_url
  end
end
