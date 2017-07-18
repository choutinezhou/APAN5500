needs::needs(rvest, stringr)

url = "Topic  1. Getting to Know You Discussion Forum.htm"
page = read_html(url)

texts = page %>%
  html_nodes("ul.discussion-entries p") 

aaa = texts %>% html_text()
