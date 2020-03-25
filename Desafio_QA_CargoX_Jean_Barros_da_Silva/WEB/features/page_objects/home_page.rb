class Home < SitePrism::Page
  element :btn_user, '#with-label'
  element :li_create, '#quickcreatetop'
  elements :li_options, '.desktop-bar #quickcreatetop .dropdown-menu li'
end
