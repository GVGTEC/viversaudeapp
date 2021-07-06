require "application_system_test_case"

class TerceirosTest < ApplicationSystemTestCase
  setup do
    @terceiro = terceiros(:one)
  end

  test "visiting the index" do
    visit terceiros_url
    assert_selector "h1", text: "Terceiros"
  end

  test "creating a Terceiro" do
    visit terceiros_url
    click_on "New Terceiro"

    fill_in "Bairro", with: @terceiro.bairro
    fill_in "Cep", with: @terceiro.cep
    fill_in "Cidade", with: @terceiro.cidade
    fill_in "Cnpj", with: @terceiro.cnpj
    fill_in "Cpf", with: @terceiro.cpf
    fill_in "Email", with: @terceiro.email
    fill_in "Endereco", with: @terceiro.endereco
    fill_in "Ie", with: @terceiro.ie
    fill_in "Nome", with: @terceiro.nome
    fill_in "Pessoa", with: @terceiro.pessoa
    fill_in "Rg", with: @terceiro.rg
    fill_in "Telefone", with: @terceiro.telefone
    fill_in "Uf", with: @terceiro.uf
    click_on "Create Terceiro"

    assert_text "Terceiro was successfully created"
    click_on "Back"
  end

  test "updating a Terceiro" do
    visit terceiros_url
    click_on "Edit", match: :first

    fill_in "Bairro", with: @terceiro.bairro
    fill_in "Cep", with: @terceiro.cep
    fill_in "Cidade", with: @terceiro.cidade
    fill_in "Cnpj", with: @terceiro.cnpj
    fill_in "Cpf", with: @terceiro.cpf
    fill_in "Email", with: @terceiro.email
    fill_in "Endereco", with: @terceiro.endereco
    fill_in "Ie", with: @terceiro.ie
    fill_in "Nome", with: @terceiro.nome
    fill_in "Pessoa", with: @terceiro.pessoa
    fill_in "Rg", with: @terceiro.rg
    fill_in "Telefone", with: @terceiro.telefone
    fill_in "Uf", with: @terceiro.uf
    click_on "Update Terceiro"

    assert_text "Terceiro was successfully updated"
    click_on "Back"
  end

  test "destroying a Terceiro" do
    visit terceiros_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Terceiro was successfully destroyed"
  end
end
