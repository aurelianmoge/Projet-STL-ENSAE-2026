install.packages("forecast")
install.packages("fUnitRoots")

library(zoo) #format de serie temporelle pratique et facile d'utilisation
library(tseries) #diverses fonctions sur les séries temporelles
library(tidyverse) #pour la manipulation des données
library(forecast) #fonctions utiles pour les séries temporelles
library(fUnitRoots) #pour le test ADF


> df <- read.csv("/Users/ana/Documents/ENSAE/2A/Semestre 2/Séries temporelles /Projet série temp/valeurs_mensuelles_pharma.csv", sep=";")
> df <- df[-c(1,2,3), ] # on ne conserve que les lignes avec des valeurs renseignées
> df <- df[, c(1,2)]    # on ne conserve que les colonnes avec la date et l'indice
> df <- df %>%          # on renomme la colonne des indices pour la manipuler facilement
  +   rename("Indice_pharma" 
             +          = "Indice.brut.de.la.production.industrielle..base.100.en.2021....Industrie.pharmaceutique..NAF.rév..2..niveau.division..poste.21.")
> 
  > 
  > summary(df)

# On convertit en série zoo la colonne des indices
df$Indice_pharma <- as.numeric(gsub(",", ".", df$Indice_pharma))

### Construction de la série temporelle

# On enregistre la série dans un fichier xm.source (on ajoute "01" à la date pour simuler une date journalière)
xm.source <- zoo(df$Indice_pharma, order.by = as.Date(paste0(df$Libellé, "-01")))

# On définit la taille de la série temporelle (434 observations)
T <- length(xm.source)

# On enregistre ces observations dans un fichier à part, mais on enlève les 4 dernières observations, car on cherche à les prédire
xm <- head(xm.source, T-4)

plot(xm)

plot(window(xm.source, start = as.Date("2015-01-01")),
     main = "IPI Industrie pharmaceutique (2015–2026)",
     ylab = "Indice (base 100 en 2021)",
     xlab = "")




