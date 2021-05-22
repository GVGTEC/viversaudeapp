require 'test_helper'

class ClientesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cliente = clientes(:one)
  end

  test "should get index" do
    get clientes_url
    assert_response :success
  end

  test "should get new" do
    get new_cliente_url
    assert_response :success
  end

  test "should create cliente" do
    assert_difference('Cliente.count') do
      post clientes_url, params: { cliente: { bairro: @cliente.bairro, cep: @cliente.cep, cidade: @cliente.cidade, cnpj: @cliente.cnpj, codcidade_ibge: @cliente.codcidade_ibge, cpf: @cliente.cpf, email: @cliente.email, endereco: @cliente.endereco, ie: @cliente.ie, nome: @cliente.nome, pessoa: @cliente.pessoa, rg: @cliente.rg, uf: @cliente.uf } }
    end

    assert_redirected_to cliente_url(Cliente.last)
  end

  test "should show cliente" do
    get cliente_url(@cliente)
    assert_response :success
  end

  test "should get edit" do
    get edit_cliente_url(@cliente)
    assert_response :success
  end

  test "should update cliente" do
    patch cliente_url(@cliente), params: { cliente: { bairro: @cliente.bairro, cep: @cliente.cep, cidade: @cliente.cidade, cnpj: @cliente.cnpj, codcidade_ibge: @cliente.codcidade_ibge, cpf: @cliente.cpf, email: @cliente.email, endereco: @cliente.endereco, ie: @cliente.ie, nome: @cliente.nome, pessoa: @cliente.pessoa, rg: @cliente.rg, uf: @cliente.uf } }
    assert_redirected_to cliente_url(@cliente)
  end

  test "should destroy cliente" do
    assert_difference('Cliente.count', -1) do
      delete cliente_url(@cliente)
    end

    assert_redirected_to clientes_url
  end
end
