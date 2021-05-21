library(RSelenium)
  
# Commencer par lib?rer tout les ports
system("taskkill /im java.exe /f", intern=FALSE, ignore.stdout=FALSE)
# Connexion (avec cookies pour google Rekaptcha)
driver<- rsDriver(browser=c("chrome"), chromever = "90.0.4430.24", port = 04400L)
remDr <- driver[["client"]]
remDr$navigate("https://mon-compte-particulier.enedis.fr/home-connectee/")
remDr$addCookie(name = "internalAuthId", value = "eyJhbGciOiJBMTI4S1ciLCJlbmMiOiJBMTI4Q0JDLUhTMjU2In0.8zPyTjiCBZi0mB4vdpOAkQQO1XwHv8-8RkqL2uvHc85sGKra7HRREg.04Pq4qxTl-l6j7dFKvbP-g.j-m3eRTIlRluy2LSJ2uAPQ.0YU4mEk1nOax3gQS8xJlvg")
remDr$navigate("https://mon-compte-particulier.enedis.fr/home-connectee/")
Sys.sleep(2.5)
remDr$findElement(using = "id", value = 'idToken2')$sendKeysToElement(list("Ec3cf2f8c1.."))
remDr$findElements("id", "idToken3_0")[[1]]$clickElement()
Sys.sleep(2)



### Conso Quotidienne 1
remDr$navigate("https://apps.lincs.enedis.fr/mes-mesures/private-donnees-de-mesures?ajouter_telechargement=true")
remDr$maxWindowSize()
Sys.sleep(9)
# Choix de dates
# remDr$findElement("id","mat-input-1")$clickElement()
# Consommation quotidienne 08/03
# recul en arrière jusqu'au bout en mois
# for(i in 1:130){
  #   xpath = "/html/body/bs-datepicker-container/div/div/div/div/bs-days-calendar-view/bs-calendar-layout/div[1]/bs-datepicker-navigation-view/button[1]"
  #   remDr$findElement("xpath",xpath)$clickElement()
  # }
# cliquer sur la date la plus tôt
# for (i in 1:6){
  #   for (j in 1:7){
    #     xpath = paste0("/html/body/bs-datepicker-container/div/div/div/div/bs-days-calendar-view/bs-calendar-layout/div[2]/table/tbody/tr[",i,"]/td[",j,"]/span")
    #     remDr$findElement("xpath",xpath)$clickElement()
    #   }
  # }
#Downloads
xpath = "/html/body/modal-container/div/div/app-popin-telechargement/div[3]/div/div/button[2]"
remDr$findElement("xpath",xpath)$clickElement()
Sys.sleep(9)






### Conso horraire 1 
# Consommation horraires 08/03
remDr$navigate("https://apps.lincs.enedis.fr/mes-mesures/private-donnees-de-mesures?ajouter_telechargement=true")
Sys.sleep(4)
remDr$findElement("id","mat-radio-3")$clickElement()
Sys.sleep(1)
# Choix de dates
# remDr$findElement("id","mat-input-1")$clickElement()
# Consommation quotidienne 08/03
# recul en arrière jusqu'au bout en mois
# for(i in 1:130){
#   xpath = "/html/body/bs-datepicker-container/div/div/div/div/bs-days-calendar-view/bs-calendar-layout/div[1]/bs-datepicker-navigation-view/button[1]"
#   remDr$findElement("xpath",xpath)$clickElement()
# }
# cliquer sur la date la plus tôt
# for (i in 1:6){
#   for (j in 1:7){
#     xpath = paste0("/html/body/bs-datepicker-container/div/div/div/div/bs-days-calendar-view/bs-calendar-layout/div[2]/table/tbody/tr[",i,"]/td[",j,"]/span")
#     remDr$findElement("xpath",xpath)$clickElement()
#   }
# }
#Downloads
xpath = "/html/body/modal-container/div/div/app-popin-telechargement/div[3]/div/div/button[2]"
remDr$findElement("xpath",xpath)$clickElement()
Sys.sleep(9)

### Pmax 1 
# puissances max 08/03
remDr$navigate("https://apps.lincs.enedis.fr/mes-mesures/private-donnees-de-mesures?ajouter_telechargement=true")
Sys.sleep(4)
remDr$findElement("id","mat-radio-4")$clickElement()
Sys.sleep(1)
# Choix de dates
# remDr$findElement("id","mat-input-1")$clickElement()
# Consommation quotidienne 08/03
# recul en arrière jusqu'au bout en mois
# for(i in 1:130){
#   xpath = "/html/body/bs-datepicker-container/div/div/div/div/bs-days-calendar-view/bs-calendar-layout/div[1]/bs-datepicker-navigation-view/button[1]"
#   remDr$findElement("xpath",xpath)$clickElement()
# }
# cliquer sur la date la plus tôt
# for (i in 1:6){
#   for (j in 1:7){
#     xpath = paste0("/html/body/bs-datepicker-container/div/div/div/div/bs-days-calendar-view/bs-calendar-layout/div[2]/table/tbody/tr[",i,"]/td[",j,"]/span")
#     remDr$findElement("xpath",xpath)$clickElement()
#   }
# }
#Downloads
xpath = "/html/body/modal-container/div/div/app-popin-telechargement/div[3]/div/div/button[2]"
remDr$findElement("xpath",xpath)$clickElement()
Sys.sleep(9)


# Fermeture + liberation du port 
remDr$close()
system("taskkill /im java.exe /f", intern=FALSE, ignore.stdout=FALSE)
rm(driver)


