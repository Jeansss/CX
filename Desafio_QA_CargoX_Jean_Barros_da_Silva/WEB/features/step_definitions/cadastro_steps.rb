Dado("realizar login no site suite crm") do
  @login_page.load
  @login_page.inpt_username.set(MASSA['login']['user'])
  @login_page.inpt_password.set(MASSA['login']['password'])
  @login_page.btn_login.click
  @home_page.has_btn_user?
end

Quando("acessar a sessão de tasks") do
  @home_page.li_create.click
  @home_page.li_options.last.click
  @tasks_page.has_h2_create?
end

Quando("cadastrar uma task {string}") do |name|
  @task_name = name
  @tasks_page.inpt_name.set(name).text
  @tasks_page.select_status.click
  @tasks_page.opt_status.click
  @status = @tasks_page.opt_status.text
  @tasks_page.select_priority.click
  @tasks_page.opt_priority.click
  @priority = @tasks_page.opt_priority.text
  @tasks_page.btn_save.first.click
  @tasks_page.wait_until_h2_task_visible
  @tasks_page.has_h2_task?
end

Então("devo validar a task cadastrada/editada com sucesso") do
  expect(@tasks_page.h2_task.text.capitalize).to eql(@tasks_page.inpt_name.text)
  expect(@tasks_page.div_name.text).to eql(@tasks_page.inpt_name.text)
  expect(@tasks_page.div_status.text).to eql(@status)
  expect(@tasks_page.div_priority.text).to eql(@priority)
end