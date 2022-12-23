scriptTag = "<script>"
scriptEndTag = "</script>"
scriptSrcTag = "<script src="
htmlEndTag = "</html>"
layerControlVar = "var layer_control"
mapVar = "var map"

onWrite = False
writeNewHTML = False

with open("map.html","r") as htmlFile:
    with open("map.js","w+") as jsFile:
        with open("newMap.html","w+") as newHtmlFile:
            with open("mapHelper.js","w+") as helperFile:
                while True:
                    line = htmlFile.readline()
                    if not line:
                        break
                    if scriptTag in line:
                        onWrite = True
                    elif scriptEndTag in line:
                        onWrite = False
                        if scriptSrcTag in line and writeNewHTML:
                            newHtmlFile.write(line)
                    elif onWrite:
                        jsFile.write(line)
                        jsFile.write("\n")
                    elif writeNewHTML:
                        if htmlEndTag in line:
                            newHtmlFile.write('<script src="map.js"></script>\n')
                        newHtmlFile.write(line)
                    if layerControlVar in line:
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
                    if mapVar in line:
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
                    



