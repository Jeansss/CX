Quando("selecionar a opção de editar") do
  @tasks_page.li_actions.click
  @tasks_page.inpt_edit.click
  @tasks_page.has_inpt_name?
end

Quando("editar os dados que desejo") do
  @tasks_page.inpt_name.set('Testa')
  @tasks_page.btn_save.first.click
  @tasks_page.wait_until_h2_task_visible
  @tasks_page.has_h2_task?
end