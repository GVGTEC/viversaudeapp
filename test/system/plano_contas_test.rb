require "application_system_test_case"

class PlanoContasTest < ApplicationSystemTestCase
  setup do
    @plano_conta = plano_contas(:one)
  end

  test "visiting the index" do
    visit plano_contas_url
    assert_selector "h1", text: "Plano Contas"
  end

  test "creating a Plano conta" do
    visit plano_contas_url
    click_on "New Plano Conta"

    fill_in "Conta", with: @plano_conta.conta
    fill_in "Descricao", with: @plano_conta.descricao
    fill_in "Grau", with: @plano_conta.grau
    click_on "Create Plano conta"

    assert_text "Plano conta was successfully created"
    click_on "Back"
  end

  test "updating a Plano conta" do
    visit plano_contas_url
    click_on "Edit", match: :first

    fill_in "Conta", with: @plano_conta.conta
    fill_in "Descricao", with: @plano_conta.descricao
    fill_in "Grau", with: @plano_conta.grau
    click_on "Update Plano conta"

    assert_text "Plano conta was successfully updated"
    click_on "Back"
  end

  test "destroying a Plano conta" do
    visit plano_contas_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Plano conta was successfully destroyed"
  end
end
