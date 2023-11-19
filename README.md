# DKDL Model demo tool
Interactieve implementatie van het DKDL model.
De tool is bedoeld om de werking van het model te illustreren.
De data die wordt ingevuld door de gebruiker wordt enkel gebruikt om een profiel af te leiden.
**Er wordt géén data opgeslagen**.

**Let op** De app is nog in actieve ontwikkeling.

# Lokaal runnen tool

De tool is getest met R versie 4.3.1 en Shiny 1.8.

Installeer eerst de benodigde R packages:

```
dependencies <- c("shiny", "shinyjs", "partykit")
install.packages(dependencies)
```

Clone nu deze Github repository naar een lokale map.
Open Rstudio en zorg dat deze lokale map de "current working directory" is.

De app kan nu gestart worden met:

```
shiny::runApp()
```

