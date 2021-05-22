require "application_system_test_case"

class ProdutosTest < ApplicationSystemTestCase
  setup do
    @produto = produtos(:one)
  end

  test "visiting the index" do
    visit produtos_url
    assert_selector "h1", text: "Produtos"
  end

  test "creating a Produto" do
    visit produtos_url
    click_on "New Produto"

    check "Bloquear preco" if @produto.bloquear_preco
    fill_in "Codigo barras", with: @produto.codigo_barras
    fill_in "Comissao pc", with: @produto.comissao_pc
    check "Controlar estoque" if @produto.controlar_estoque
    fill_in "Data final oferta", with: @produto.data_final_oferta
    fill_in "Data inativo", with: @produto.data_inativo
    fill_in "Data inicial oferta", with: @produto.data_inicial_oferta
    fill_in "Data ultima reposicao", with: @produto.data_ultima_reposicao
    fill_in "Data ultimo reajuste", with: @produto.data_ultimo_reajuste
    fill_in "Descricao", with: @produto.descricao
    fill_in "Descricao nfe", with: @produto.descricao_nfe
    fill_in "Embalagem", with: @produto.embalagem
    fill_in "Localizacao estoque", with: @produto.localizacao_estoque_id
    fill_in "Margem lucro", with: @produto.margem_lucro
    fill_in "Margem lucro oferta", with: @produto.margem_lucro_oferta
    fill_in "Ncm", with: @produto.ncm
    check "Por lote" if @produto.por_lote
    fill_in "Preco custo", with: @produto.preco_custo
    fill_in "Preco custo medio", with: @produto.preco_custo_medio
    fill_in "Preco oferta", with: @produto.preco_oferta
    fill_in "Preco venda", with: @produto.preco_venda
    check "Situacao" if @produto.situacao
    fill_in "Situacao tributaria", with: @produto.situacao_tributaria
    fill_in "Unidade", with: @produto.unidade
    click_on "Create Produto"

    assert_text "Produto was successfully created"
    click_on "Back"
  end

  test "updating a Produto" do
    visit produtos_url
    click_on "Edit", match: :first

    check "Bloquear preco" if @produto.bloquear_preco
    fill_in "Codigo barras", with: @produto.codigo_barras
    fill_in "Comissao pc", with: @produto.comissao_pc
    check "Controlar estoque" if @produto.controlar_estoque
    fill_in "Data final oferta", with: @produto.data_final_oferta
    fill_in "Data inativo", with: @produto.data_inativo
    fill_in "Data inicial oferta", with: @produto.data_inicial_oferta
    fill_in "Data ultima reposicao", with: @produto.data_ultima_reposicao
    fill_in "Data ultimo reajuste", with: @produto.data_ultimo_reajuste
    fill_in "Descricao", with: @produto.descricao
    fill_in "Descricao nfe", with: @produto.descricao_nfe
    fill_in "Embalagem", with: @produto.embalagem
    fill_in "Localizacao estoque", with: @produto.localizacao_estoque_id
    fill_in "Margem lucro", with: @produto.margem_lucro
    fill_in "Margem lucro oferta", with: @produto.margem_lucro_oferta
    fill_in "Ncm", with: @produto.ncm
    check "Por lote" if @produto.por_lote
    fill_in "Preco custo", with: @produto.preco_custo
    fill_in "Preco custo medio", with: @produto.preco_custo_medio
    fill_in "Preco oferta", with: @produto.preco_oferta
    fill_in "Preco venda", with: @produto.preco_venda
    check "Situacao" if @produto.situacao
    fill_in "Situacao tributaria", with: @produto.situacao_tributaria
    fill_in "Unidade", with: @produto.unidade
    click_on "Update Produto"

    assert_text "Produto was successfully updated"
    click_on "Back"
  end

  test "destroying a Produto" do
    visit produtos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Produto was successfully destroyed"
  end
end
