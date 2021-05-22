require 'test_helper'

class LocalizacaoEstoquesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @localizacao_estoque = localizacao_estoques(:one)
  end

  test "should get index" do
    get localizacao_estoques_url
    assert_response :success
  end

  test "should get new" do
    get new_localizacao_estoque_url
    assert_response :success
  end

  test "should create localizacao_estoque" do
    assert_difference('LocalizacaoEstoque.count') do
      post localizacao_estoques_url, params: { localizacao_estoque: { nome: @localizacao_estoque.nome } }
    end

    assert_redirected_to localizacao_estoque_url(LocalizacaoEstoque.last)
  end

  test "should show localizacao_estoque" do
    get localizacao_estoque_url(@localizacao_estoque)
    assert_response :success
  end

  test "should get edit" do
    get edit_localizacao_estoque_url(@localizacao_estoque)
    assert_response :success
  end

  test "should update localizacao_estoque" do
    patch localizacao_estoque_url(@localizacao_estoque), params: { localizacao_estoque: { nome: @localizacao_estoque.nome } }
    assert_redirected_to localizacao_estoque_url(@localizacao_estoque)
  end

  test "should destroy localizacao_estoque" do
    assert_difference('LocalizacaoEstoque.count', -1) do
      delete localizacao_estoque_url(@localizacao_estoque)
    end

    assert_redirected_to localizacao_estoques_url
  end
end
