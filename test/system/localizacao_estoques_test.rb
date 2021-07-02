require "application_system_test_case"

class LocalizacaoEstoquesTest < ApplicationSystemTestCase
  setup do
    @localizacao_estoque = localizacao_estoques(:one)
  end

  test "visiting the index" do
    visit localizacao_estoques_url
    assert_selector "h1", text: "Localizacao Estoques"
  end

  test "creating a Localizacao estoque" do
    visit localizacao_estoques_url
    click_on "Novo Localizacao Estoque"

    fill_in "Local", with: @localizacao_estoque.local
    fill_in "Observacao", with: @localizacao_estoque.observacao
    click_on "Create Localizacao estoque"

    assert_text "Localizacao estoque was successfully created"
    click_on "Back"
  end

  test "updating a Localizacao estoque" do
    visit localizacao_estoques_url
    click_on "Edit", match: :first

    fill_in "Local", with: @localizacao_estoque.local
    fill_in "Observacao", with: @localizacao_estoque.observacao
    click_on "Update Localizacao estoque"

    assert_text "Localizacao estoque was successfully updated"
    click_on "Back"
  end

  test "destroying a Localizacao estoque" do
    visit localizacao_estoques_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Localizacao estoque was successfully destroyed"
  end
end
