
# Test script automatisation

library(RSelenium)

setwd("C:/Users/Administrator/Downloads/")

# Selection des fichiers avec le nom "Enedis" dessus
files_Enedis <- dir()[sapply(dir(), function(X) grepl("Enedis",X))]
unlink(files_Enedis)

# Commencer par lib?rer tout les ports
system("taskkill /im java.exe /f", intern=FALSE, ignore.stdout=FALSE)
# Connexion (avec cookies pour google Rekaptcha)
driver<- rsDriver(browser=c("chrome"), chromever = "90.0.4430.24", port = 04400L)
remDr <- driver[["client"]]
remDr$navigate("https://mon-compte-particulier.enedis.fr/home-connectee/")
remDr$addCookie(name = "internalAuthId", value = "eyJhbGciOiJBMTI4S1ciLCJlbmMiOiJBMTI4Q0JDLUhTMjU2In0.8zPyTjiCBZi0mB4vdpOAkQQO1XwHv8-8RkqL2uvHc85sGKra7HRREg.04Pq4qxTl-l6j7dFKvbP-g.j-m3eRTIlRluy2LSJ2uAPQ.0YU4mEk1nOax3gQS8xJlvg")
remDr$navigate("https://mon-compte-particulier.enedis.fr/home-connectee/")
Sys.sleep(5)
remDr$findElement(using = "id", value = 'idToken2')$sendKeysToElement(list("Ec3cf2f8c1.."))
Sys.sleep(1.5)
remDr$findElements("id", "idToken3_0")[[1]]$clickElement()
Sys.sleep(5)
remDr$navigate("https://apps.lincs.enedis.fr/mes-mesures/private-donnees-de-mesures?ajouter_telechargement=true")
remDr$navigate("https://apps.lincs.enedis.fr/mes-mesures/private-donnees-de-mesures?ajouter_telechargement=true")
remDr$maxWindowSize()
Sys.sleep(2)



######## crtl + Z ! 

### Telecharger les fichier
remDr$navigate("https://apps.lincs.enedis.fr/mes-mesures/private-telechargements")
Sys.sleep(4)
xpath = '//*[@id="app_component"]/app-tableau-telechargements/div/div[2]/table/tbody/tr[1]/td[5]/a'
remDr$findElement("xpath",xpath)$clickElement()
Sys.sleep(8)
xpath = '//*[@id="app_component"]/app-tableau-telechargements/div/div[2]/table/tbody/tr[2]/td[5]/a'
remDr$findElement("xpath",xpath)$clickElement()
Sys.sleep(8)
xpath = '//*[@id="app_component"]/app-tableau-telechargements/div/div[2]/table/tbody/tr[3]/td[5]/a'
remDr$findElement("xpath",xpath)$clickElement()
Sys.sleep(8)
xpath = '//*[@id="app_component"]/app-tableau-telechargements/div/div[2]/table/tbody/tr[4]/td[5]/a'
remDr$findElement("xpath",xpath)$clickElement()
Sys.sleep(8)
xpath = '//*[@id="app_component"]/app-tableau-telechargements/div/div[2]/table/tbody/tr[5]/td[5]/a'
remDr$findElement("xpath",xpath)$clickElement()
Sys.sleep(8)
xpath = '//*[@id="app_component"]/app-tableau-telechargements/div/div[2]/table/tbody/tr[6]/td[5]/a'
remDr$findElement("xpath",xpath)$clickElement()
Sys.sleep(8)
xpath = '//*[@id="app_component"]/app-tableau-telechargements/div/div[2]/table/tbody/tr[7]/td[5]/a'
remDr$findElement("xpath",xpath)$clickElement()
Sys.sleep(8)
xpath = '//*[@id="app_component"]/app-tableau-telechargements/div/div[2]/table/tbody/tr[8]/td[5]/a'
remDr$findElement("xpath",xpath)$clickElement()
Sys.sleep(8)
xpath = '//*[@id="app_component"]/app-tableau-telechargements/div/div[2]/table/tbody/tr[9]/td[5]/a'
remDr$findElement("xpath",xpath)$clickElement()
Sys.sleep(8)
xpath = '//*[@id="app_component"]/app-tableau-telechargements/div/div[2]/table/tbody/tr[10]/td[5]/a'
remDr$findElement("xpath",xpath)$clickElement()
Sys.sleep(8)


# Fermeture + liberation du port 
remDr$close()
system("taskkill /im java.exe /f", intern=FALSE, ignore.stdout=FALSE)
rm(driver)

setwd("C:/Users/Administrator/Downloads/")

# Selection des fichiers avec le nom "Enedis" dessus
files_Enedis <- dir()[sapply(dir(), function(X) grepl("Enedis",X))]

# Selection des derniers fichiers pour chaque type de conso
for (i in 1:length(files_Enedis)){
  # Conso jour
  file_name <- files_Enedis[i]
  if(grepl("Conso_Jour",file_name)){
    Date_jour_max <- as.Date("1997-07-03")
    date_file_jour <- as.Date(substr(unlist(strsplit(file_name,"-")[1])[2],1,8), "%Y%m%d")
    if(Date_jour_max < date_file_jour){
      Date_jour_max <- date_file_jour
      file_name_jour <- file_name
    }
  }
  # Conso horraire
  if(grepl("Conso_Heure",file_name)){
    Date_horraire_max <- as.Date("1997-07-03")
    date_file_horraire <- as.Date(substr(unlist(strsplit(file_name,"-")[1])[2],1,8), "%Y%m%d")
    if(Date_horraire_max < date_file_horraire){
      Date_horraire_max <- date_file_horraire
      file_name_horraire <- file_name
    }
  }
  # Pmax
  if(grepl("Conso_Pmax",file_name)){
    Date_pmax_max <- as.Date("1997-07-03")
    date_file_pmax <- as.Date(substr(unlist(strsplit(file_name,"-")[1])[2],1,8), "%Y%m%d")
    if(Date_pmax_max < date_file_pmax){
      Date_pmax_max <- date_file_pmax
      file_name_pmax <- file_name
    }
  }
}

# Lecture et traitement :
jour_df = read.csv(file_name_jour, encoding = "UTF8")
heure_df = read.csv2(file_name_horraire)
pmax_df = read.csv2(file_name_pmax)

### Traitemnent
# jours : Mise en forme des données
Conso_jour = jour_df[3:(nrow(jour_df)-2),]
Time_jour = as.Date(substr(Conso_jour,1,10))
Conso_jour = strsplit(Conso_jour,";")
Conso_jour = sapply(1:(nrow(jour_df)-4), function(i) Conso_jour[[i]][3])
Data_jours = data.frame(Dates = Time_jour, Consommation = Conso_jour)
# heure : Mise en forme des données
heure_df = heure_df[c(3:nrow(heure_df)),c(1,2)]
names(heure_df) = c("Date","Conso")
heure_df$Conso = as.numeric(heure_df$Conso)
heure_df = heure_df[!is.na(heure_df$Conso),]
heures = strsplit(heure_df$Date,"T")
heure_df$Date = as.POSIXct((sapply(1:length(heures), function(i) paste(heures[[i]][1],substr(heures[[i]][2],1,8) ))), tz="UTC")
Data_heures = heure_df
# Pmax : Mise en forme des données
pmax_df = pmax_df[c(3:nrow(pmax_df)),c(1,2)]
names(pmax_df) = c("Date","Conso")
pmax_df$Conso = as.numeric(pmax_df$Conso)
pmax_df = pmax_df[!is.na(pmax_df$Conso),]
heures = strsplit(pmax_df$Date,"T")
pmax_df$Date = as.POSIXct((sapply(1:length(heures), function(i) paste(heures[[i]][1],substr(heures[[i]][2],1,8) ))), tz="UTC")
Data_pmax = pmax_df

# Enregistrement des données
setwd("./Data_R/")
### Ajouter les donn�es aux anciennes donn�es
# Jours
name_rds_jours <- dir()[grepl("Jour",dir())]
Data_original_jour <- readRDS(name_rds_jours)
Date_original_max <- max(Data_original_jour$Dates)
# Elimination des dates anterieur a la date max du data original
Data_jours <- Data_jours[Data_jours$Dates>Date_original_max,]
Data_jours <- rbind(Data_original_jour,Data_jours)
# heures
name_rds_heures <- dir()[grepl("Heure",dir())]
Data_original_heure <- readRDS(name_rds_heures)
Date_original_max <- max(Data_original_heure$Date)
# Elimination des dates anterieur a la date max du data original
Data_heures <- Data_heures[Data_heures$Date>Date_original_max,]
Data_heures <- rbind(Data_original_heure,Data_heures)
# Pmax
name_rds_pmax <- dir()[grepl("Pmax",dir())]
Data_original_pmax <- readRDS(name_rds_pmax)
Date_original_max <- max(Data_original_pmax$Date)
# Elimination des dates anterieur a la date max du data original
Data_pmax <- Data_pmax[Data_pmax$Date>Date_original_max,]
Data_pmax <- rbind(Data_original_pmax,Data_pmax)



sapply(dir(), unlink)

saveRDS(Data_jours,paste0(file_name_jour,".Rds"))
saveRDS(Data_heures,paste0(file_name_horraire,".Rds"))
saveRDS(Data_pmax,paste0(file_name_pmax,".Rds"))

rm(list = ls())
