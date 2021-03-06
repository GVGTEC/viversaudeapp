require 'application_system_test_case'

class OrcamentosTest < ApplicationSystemTestCase
  before do
    @orcamento = orcamentos(:one)
  end

  test 'visiting the index' do
    visit orcamentos_url
    assert_selector 'h1', text: 'Orcamentos'
  end

  test 'creating a Orcamento' do
    visit orcamentos_url
    click_on 'New Orcamento'

    fill_in 'Cliente', with: @orcamento.cliente_id
    fill_in 'Data emissao', with: @orcamento.data_emissao
    fill_in 'Flag', with: @orcamento.flag
    fill_in 'Observacao', with: @orcamento.observacao
    fill_in 'Valor total', with: @orcamento.valor_total
    fill_in 'Vendedor', with: @orcamento.vendedor_id
    click_on 'Create Orcamento'

    assert_text 'Orcamento was successfully created'
    click_on 'Back'
  end

  test 'updating a Orcamento' do
    visit orcamentos_url
    click_on 'Edit', match: :first

    fill_in 'Cliente', with: @orcamento.cliente_id
    fill_in 'Data emissao', with: @orcamento.data_emissao
    fill_in 'Flag', with: @orcamento.flag
    fill_in 'Observacao', with: @orcamento.observacao
    fill_in 'Valor total', with: @orcamento.valor_total
    fill_in 'Vendedor', with: @orcamento.vendedor_id
    click_on 'Update Orcamento'

    assert_text 'Orcamento was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Orcamento' do
    visit orcamentos_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Orcamento was successfully destroyed'
  end
end
