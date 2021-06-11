require "application_system_test_case"

class VendedoresTest < ApplicationSystemTestCase
  setup do
    @vendedor = vendedores(:one)
  end

  test "visiting the index" do
    visit vendedores_url
    assert_selector "h1", text: "Vendedores"
  end

  test "creating a Vendedor" do
    visit vendedores_url
    click_on "New Vendedor"

    fill_in "Bairro", with: @vendedor.bairro
    fill_in "Cep", with: @vendedor.cep
    fill_in "Cidade", with: @vendedor.cidade
    fill_in "Cnpj", with: @vendedor.cnpj
    fill_in "Cpf", with: @vendedor.cpf
    fill_in "Email", with: @vendedor.email
    fill_in "Endereco", with: @vendedor.endereco
    fill_in "Ie", with: @vendedor.ie
    fill_in "Nome", with: @vendedor.nome
    fill_in "Pessoa", with: @vendedor.pessoa
    fill_in "Rg", with: @vendedor.rg
    fill_in "Telefone", with: @vendedor.telefone
    fill_in "Uf", with: @vendedor.uf
    click_on "Create Vendedor"

    assert_text "Vendedor was successfully created"
    click_on "Back"
  end

  test "updating a Vendedor" do
    visit vendedores_url
    click_on "Edit", match: :first

    fill_in "Bairro", with: @vendedor.bairro
    fill_in "Cep", with: @vendedor.cep
    fill_in "Cidade", with: @vendedor.cidade
    fill_in "Cnpj", with: @vendedor.cnpj
    fill_in "Cpf", with: @vendedor.cpf
    fill_in "Email", with: @vendedor.email
    fill_in "Endereco", with: @vendedor.endereco
    fill_in "Ie", with: @vendedor.ie
    fill_in "Nome", with: @vendedor.nome
    fill_in "Pessoa", with: @vendedor.pessoa
    fill_in "Rg", with: @vendedor.rg
    fill_in "Telefone", with: @vendedor.telefone
    fill_in "Uf", with: @vendedor.uf
    click_on "Update Vendedor"

    assert_text "Vendedor was successfully updated"
    click_on "Back"
  end

  test "destroying a Vendedor" do
    visit vendedores_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Vendedor was successfully destroyed"
  end
end
