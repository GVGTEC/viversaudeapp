require 'test_helper'

class TerceirosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @terceiro = terceiros(:one)
  end

  test "should get index" do
    get terceiros_url
    assert_response :success
  end

  test "should get new" do
    get new_terceiro_url
    assert_response :success
  end

  test "should create terceiro" do
    assert_difference('Terceiro.count') do
      post terceiros_url, params: { terceiro: { bairro: @terceiro.bairro, cep: @terceiro.cep, cidade: @terceiro.cidade, cnpj: @terceiro.cnpj, cpf: @terceiro.cpf, email: @terceiro.email, endereco: @terceiro.endereco, ie: @terceiro.ie, nome: @terceiro.nome, pessoa: @terceiro.pessoa, rg: @terceiro.rg, telefone: @terceiro.telefone, uf: @terceiro.uf } }
    end

    assert_redirected_to terceiro_url(Terceiro.last)
  end

  test "should show terceiro" do
    get terceiro_url(@terceiro)
    assert_response :success
  end

  test "should get edit" do
    get edit_terceiro_url(@terceiro)
    assert_response :success
  end

  test "should update terceiro" do
    patch terceiro_url(@terceiro), params: { terceiro: { bairro: @terceiro.bairro, cep: @terceiro.cep, cidade: @terceiro.cidade, cnpj: @terceiro.cnpj, cpf: @terceiro.cpf, email: @terceiro.email, endereco: @terceiro.endereco, ie: @terceiro.ie, nome: @terceiro.nome, pessoa: @terceiro.pessoa, rg: @terceiro.rg, telefone: @terceiro.telefone, uf: @terceiro.uf } }
    assert_redirected_to terceiro_url(@terceiro)
  end

  test "should destroy terceiro" do
    assert_difference('Terceiro.count', -1) do
      delete terceiro_url(@terceiro)
    end

    assert_redirected_to terceiros_url
  end
end
