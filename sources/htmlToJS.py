scriptTag = "<script>"
scriptEndTag = "</script>"
scriptSrcTag = "<script src="
htmlEndTag = "</html>"
layerControlVar = "var layer_control"
mapVar = "var map"

onWrite = False # Initialise la variable qui décide si la balise <script> à été repérée et si le programme doit générer le JS, cette variable doit rester False
writeNewHTML = False # Décide si l'on veut générer un nouveau HTML ou non

with open("map.html","r") as htmlFile:
    with open("map.js","w+") as jsFile:
        with open("newMap.html","w+") as newHtmlFile:
            with open("mapHelper.js","w+") as helperFile:
                while True:
                    line = htmlFile.readline()
                    if not line: # Si la ligne est vide (null), arrêter la lecture
                        break

                    if scriptTag in line: # Si la balise <script> est détectée, écrire le JS
                        onWrite = True
                    elif scriptEndTag in line: # Si la balise </script> est détectée, ne plus écrire le JS
                        onWrite = False
                        if scriptSrcTag in line and writeNewHTML: # Si la balise "<script src=" est détectée et que l'écriture d'un nouveau HTML est activée, écrire la ligne
                            newHtmlFile.write(line)
                    elif onWrite: #Ecrit le JS
                        jsFile.write(line)
                        jsFile.write("\n")
                    elif writeNewHTML: #Ecrit le HTML
                        if htmlEndTag in line: #Ajoute le nouveau JS au nouveau HTML
                            newHtmlFile.write('<script src="map.js"></script>\n')
                        newHtmlFile.write(line)

                    if layerControlVar in line: #Trouve la variable de layer_control et l'assigne a une autre variable plus simple d'utilisation
                        i=0
                        while line[i] == " ":
                            i+=1
                        i+=3
                        while line[i] == " ":
                            i+=1
                        helperFile.write("var layerControlNumber = ")
                        while line[i] != " ":
                            helperFile.write(line[i])
                            i+=1
                        helperFile.write(";\n")

                    if mapVar in line: #Trouve la variable de map et l'assigne a une autre variable plus simple d'utilisation
                        i=0
                        while line[i] == " ":
                            i+=1
                        i+=3
                        while line[i] == " ":
                            i+=1
                        helperFile.write("var mapNumber = ")
                        while line[i] != " ":
                            helperFile.write(line[i])
                            i+=1
                        helperFile.write(";\n")
                    



