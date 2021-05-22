require 'test_helper'

class ProdutosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @produto = produtos(:one)
  end

  test "should get index" do
    get produtos_url
    assert_response :success
  end

  test "should get new" do
    get new_produto_url
    assert_response :success
  end

  test "should create produto" do
    assert_difference('Produto.count') do
      post produtos_url, params: { produto: { bloquear_preco: @produto.bloquear_preco, codigo_barras: @produto.codigo_barras, comissao_pc: @produto.comissao_pc, controlar_estoque: @produto.controlar_estoque, data_final_oferta: @produto.data_final_oferta, data_inativo: @produto.data_inativo, data_inicial_oferta: @produto.data_inicial_oferta, data_ultima_reposicao: @produto.data_ultima_reposicao, data_ultimo_reajuste: @produto.data_ultimo_reajuste, descricao: @produto.descricao, descricao_nfe: @produto.descricao_nfe, embalagem: @produto.embalagem, localizacao_estoque_id: @produto.localizacao_estoque_id, margem_lucro: @produto.margem_lucro, margem_lucro_oferta: @produto.margem_lucro_oferta, ncm: @produto.ncm, por_lote: @produto.por_lote, preco_custo: @produto.preco_custo, preco_custo_medio: @produto.preco_custo_medio, preco_oferta: @produto.preco_oferta, preco_venda: @produto.preco_venda, situacao: @produto.situacao, situacao_tributaria: @produto.situacao_tributaria, unidade: @produto.unidade } }
    end

    assert_redirected_to produto_url(Produto.last)
  end

  test "should show produto" do
    get produto_url(@produto)
    assert_response :success
  end

  test "should get edit" do
    get edit_produto_url(@produto)
    assert_response :success
  end

  test "should update produto" do
    patch produto_url(@produto), params: { produto: { bloquear_preco: @produto.bloquear_preco, codigo_barras: @produto.codigo_barras, comissao_pc: @produto.comissao_pc, controlar_estoque: @produto.controlar_estoque, data_final_oferta: @produto.data_final_oferta, data_inativo: @produto.data_inativo, data_inicial_oferta: @produto.data_inicial_oferta, data_ultima_reposicao: @produto.data_ultima_reposicao, data_ultimo_reajuste: @produto.data_ultimo_reajuste, descricao: @produto.descricao, descricao_nfe: @produto.descricao_nfe, embalagem: @produto.embalagem, localizacao_estoque_id: @produto.localizacao_estoque_id, margem_lucro: @produto.margem_lucro, margem_lucro_oferta: @produto.margem_lucro_oferta, ncm: @produto.ncm, por_lote: @produto.por_lote, preco_custo: @produto.preco_custo, preco_custo_medio: @produto.preco_custo_medio, preco_oferta: @produto.preco_oferta, preco_venda: @produto.preco_venda, situacao: @produto.situacao, situacao_tributaria: @produto.situacao_tributaria, unidade: @produto.unidade } }
    assert_redirected_to produto_url(@produto)
  end

  test "should destroy produto" do
    assert_difference('Produto.count', -1) do
      delete produto_url(@produto)
    end

    assert_redirected_to produtos_url
  end
end
