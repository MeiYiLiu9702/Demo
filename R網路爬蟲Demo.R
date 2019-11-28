rm(list = ls())
setwd("E:/2.Work/C.素卿老師科技部綠基盤計畫/2.Table")
library(rvest)
library(jsonlite)
urlR <-"http://udndata.com/ndapp/Searchdec?udndbid=udndata&page=1&SearchString=%A4%6A%A6%77%B4%CB%AA%4C%A4%BD%B6%E9%2B%A4%E9%B4%C1%3E%3D20150101%2B%A4%E9%B4%C1%3C%3D20181009%2B%B3%F8%A7%4F%3D%C1%70%A6%58%B3%F8%7C%B8%67%C0%D9%A4%E9%B3%F8%7C%C1%70%A6%58%B1%DF%B3%F8%7CUpaper&sharepage=50&select=1&kind=2&showSearchString="
a <- read_html(urlR)
xpath_name <- ('//*[@id="mainbar"]/section/div[6]/ul/li[1]/div/h2/a')
xpath_location <- ('//*[@id="mainbar"]/section/div[6]/ul/li[1]/div/span')
xpath_summary <- ('//*[@id="mainbar"]/section/div[6]/ul/li[1]/div/p')
news_name <- xml_find_all(a, xpath_name) %>%
  xml_text()

news_date <- xml_find_all(a, xpath_location) %>%
  xml_text()%>%
  gsub("\n",replacement="",.)

news_summary <- xml_find_all(a, xpath_summary ) %>%
  xml_text()%>%
  gsub("\n",replacement="",.)

n_url <- xml_find_all(a, xpath_name) %>%
  xml_attr(.,"href")%>%
  paste("http://udndata.com/",.)%>%
  gsub(" ","",.)
df <- data.frame("name"=news_name,"Date"=news_date,"Url"=n_url,"summary"=news_summary)
for (i in 1:18) {
  urlR1 <- paste("http://udndata.com/ndapp/Searchdec?udndbid=udndata&page=",i,"&SearchString=%A4%6A%A6%77%B4%CB%AA%4C%A4%BD%B6%E9%2B%A4%E9%B4%C1%3E%3D20150101%2B%A4%E9%B4%C1%3C%3D20181009%2B%B3%F8%A7%4F%3D%C1%70%A6%58%B3%F8%7C%B8%67%C0%D9%A4%E9%B3%F8%7C%C1%70%A6%58%B1%DF%B3%F8%7CUpaper&sharepage=50&select=1&kind=2&showSearchString=")%>%
    gsub(" ","",.)
  b <- read_html(urlR1)
  for (j in 1:50) {
    xpath_name1 <- paste('//*[@id="mainbar"]/section/div[6]/ul/li[',j,']/div/h2/a')%>%
      gsub(" ","",.)
    xpath_location1 <- paste('//*[@id="mainbar"]/section/div[6]/ul/li[',j,']/div/span')%>%
      gsub(" ","",.)
    xpath_summary1 <- paste('//*[@id="mainbar"]/section/div[6]/ul/li[',j,']/div/p')%>%
      gsub(" ","",.)
    
    news_name1 <- xml_find_all(b, xpath_name1) %>%
      xml_text()
    
    news_date1 <- xml_find_all(b, xpath_location1) %>%
      xml_text()%>%
      gsub("\n",replacement="",.)
    
    news_summary1 <- xml_find_all(b, xpath_summary1 ) %>%
      xml_text()%>%
      gsub("\n",replacement="",.)
    
    n_url1 <- xml_find_all(a, xpath_name) %>%
      xml_attr(.,"href")%>%
      paste("http://udndata.com/",.)%>%
      gsub(" ","",.)
    df2 <- data.frame("name"=news_name1,"Date"=news_date1,"Url"=n_url1,"summary"=news_summary1)
    df<-rbind(df,df2)
    print(j)
  }
  print(i)
  Sys.sleep(5)
}

write.csv(df,"DaanParkNews.csv")

-------------------------------

b <- "https://pwd.gov.taipei/OpenData.aspx?SN=6D379FB78830B556"
