class Tasks < SitePrism::Page
  element :h2_create, '#pagecontent .moduleTitle .module-title-text'
  element :inpt_name, '#name'
  element :select_status, '#status'
  element :opt_status, '#status option[value*=Progress]'
  element :select_priority, '#priority'
  element :opt_priority, "#priority option[label='Medium']"
  element :h2_task, '.module-title-text'
  element :div_name, "div[field='name']"
  element :div_status, "div[field='status']"
  element :div_priority, 'div[field=priority]'
  element :li_actions, '#tab-actions'
  element :inpt_edit, 'input[title=Edit]'
  element :inpt_delete, '#delete_button'
  elements :li_recent, '.recently_viewed_link_container_sidebar .recentlinks'
  elements :btn_save, '#SAVE'
end
