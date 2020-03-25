Quando("selecionar a opção de deletar") do
  @tasks_page.li_actions.click
  @tasks_page.inpt_delete.click
  page.driver.browser.switch_to.alert.accept
end

Então("devo validar que a task foi deletada com sucesso") do
  expect(@tasks_page.h2_task.text.strip).to eql('TASKS')
  @tasks_page.li_recent.each do |item|
    expect(item.text).not_to eql(@task_name)
  end
end