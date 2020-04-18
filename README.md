# LisezMoi

Un QaD(Quick And Dirty) generateur de blog statique
à base **vscode-journal** et **pandoc** le tout souspoudré de **bash** et **vue.js**

A partir d'un dépot contenant une copie des donnée généré par le daily de vscode-journal
en utilisant pandoc on génére un weblog en passant par le script `./generate.sh`

Ce dépot n'est là qu'a titre indicatif pour inspiration seulement

## Installation sous osx

- cloner le dépot git clone `git clone git@github.com:tisseurdetoile/pandoc-vscode-journal.git`
- installer pandoc `brew install pandoc`
- lancer le script `./generate.sh`

## template html pandoc

Le template pandoc pour les fichiers markdown est une copie du fichier original

- [ici](https://github.com/jgm/pandoc-templates/blob/master/default.html5)

## Parcours des fichiers dans generate.sh

Pour afficher les archives le generate.sh alimente un fichier index.json au format suivant

```json
{ "timestamp": 1587251755, "articles" : [
{"year" : 2020,"displaymonth" : "01","month" : 1,"displayday" : "01","day" : 1,"fileDestination" : "2020_01_01.html"}
,{"year" : 2020,"displaymonth" : "04","month" : 4,"displayday" : "18","day" : 18,"fileDestination" : "2020_04_18.html"}
]
```

## Bibliographie

- [website with pandoc](https://www.romangeber.com/static_websites_with_pandoc/)
- [css water](https://kognise.github.io/water.css/)

## CopyRight

Licence [MIT](LICENSE)
Le [tisseurDeToile](http://www.tisseurdetoile.net)
