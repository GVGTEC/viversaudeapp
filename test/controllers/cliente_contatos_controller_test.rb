require 'test_helper'

class ClienteContatosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cliente_contato = cliente_contatos(:one)
  end

  test "should get index" do
    get cliente_contatos_url
    assert_response :success
  end

  test "should get new" do
    get new_cliente_contato_url
    assert_response :success
  end

  test "should create cliente_contato" do
    assert_difference('ClienteContato.count') do
      post cliente_contatos_url, params: { cliente_contato: { cargo: @cliente_contato.cargo, cliente_id: @cliente_contato.cliente_id, departamento: @cliente_contato.departamento, email: @cliente_contato.email, nome: @cliente_contato.nome, telefone: @cliente_contato.telefone } }
    end

    assert_redirected_to cliente_contato_url(ClienteContato.last)
  end

  test "should show cliente_contato" do
    get cliente_contato_url(@cliente_contato)
    assert_response :success
  end

  test "should get edit" do
    get edit_cliente_contato_url(@cliente_contato)
    assert_response :success
  end

  test "should update cliente_contato" do
    patch cliente_contato_url(@cliente_contato), params: { cliente_contato: { cargo: @cliente_contato.cargo, cliente_id: @cliente_contato.cliente_id, departamento: @cliente_contato.departamento, email: @cliente_contato.email, nome: @cliente_contato.nome, telefone: @cliente_contato.telefone } }
    assert_redirected_to cliente_contato_url(@cliente_contato)
  end

  test "should destroy cliente_contato" do
    assert_difference('ClienteContato.count', -1) do
      delete cliente_contato_url(@cliente_contato)
    end

    assert_redirected_to cliente_contatos_url
  end
end
