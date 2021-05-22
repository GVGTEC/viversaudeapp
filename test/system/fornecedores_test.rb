require "application_system_test_case"

class FornecedoresTest < ApplicationSystemTestCase
  setup do
    @fornecedor = fornecedores(:one)
  end

  test "visiting the index" do
    visit fornecedores_url
    assert_selector "h1", text: "Fornecedores"
  end

  test "creating a Fornecedor" do
    visit fornecedores_url
    click_on "New Fornecedor"

    fill_in "Bairro", with: @fornecedor.bairro
    fill_in "Cep", with: @fornecedor.cep
    fill_in "Cidade", with: @fornecedor.cidade
    fill_in "Cnpj", with: @fornecedor.cnpj
    fill_in "Cpf", with: @fornecedor.cpf
    fill_in "Email", with: @fornecedor.email
    fill_in "Endereco", with: @fornecedor.endereco
    fill_in "Ie", with: @fornecedor.ie
    fill_in "Nome", with: @fornecedor.nome
    fill_in "Pessoa", with: @fornecedor.pessoa
    fill_in "Rg", with: @fornecedor.rg
    fill_in "Uf", with: @fornecedor.uf
    click_on "Create Fornecedor"

    assert_text "Fornecedor was successfully created"
    click_on "Back"
  end

  test "updating a Fornecedor" do
    visit fornecedores_url
    click_on "Edit", match: :first

    fill_in "Bairro", with: @fornecedor.bairro
    fill_in "Cep", with: @fornecedor.cep
    fill_in "Cidade", with: @fornecedor.cidade
    fill_in "Cnpj", with: @fornecedor.cnpj
    fill_in "Cpf", with: @fornecedor.cpf
    fill_in "Email", with: @fornecedor.email
    fill_in "Endereco", with: @fornecedor.endereco
    fill_in "Ie", with: @fornecedor.ie
    fill_in "Nome", with: @fornecedor.nome
    fill_in "Pessoa", with: @fornecedor.pessoa
    fill_in "Rg", with: @fornecedor.rg
    fill_in "Uf", with: @fornecedor.uf
    click_on "Update Fornecedor"

    assert_text "Fornecedor was successfully updated"
    click_on "Back"
  end

  test "destroying a Fornecedor" do
    visit fornecedores_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Fornecedor was successfully destroyed"
  end
end
