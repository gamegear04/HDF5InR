#############################################
#
# Fraunhofer-IOSB
#
# Autor: Darius Korzeniewski
# Datum: 12.01.17
# Datei: hdf5.r
# Beschreibung: hierbei handelt sich um eine 
# Test-Script, um HDF5 Dateien zu lesen und
# schreiben
#
#############################################

#<-- Installation -->
#source("http://bioconductor.org/biocLite.R")
#biocLite("rhdf5")

#<-- Bibliothek einbinden -->
library(rhdf5);

#<-- HDF5 Datei erstellen -->
h5createFile("meins.h5");

#<-- Erstellen der Hdf Gruppen -->
h5createGroup("meins.h5","foo");        # 1 Ebene 
h5createGroup("meins.h5","baa");        # 1 Ebene
h5createGroup("meins.h5","foo/foobaa"); # 2 Ebene 

#<-- Variablen in die Gruppen schreiben -->
A = matrix(1:10,nr=5,nc=2);
h5write(A, "meins.h5","foo/A");

B = array(seq(0.1,2.0,by=0.1),dim=c(5,2,2))attr(B, "scale") <- "liter";
h5write(B, "meins.h5","foo/B");

C = matrix(paste(LETTERS[1:10],LETTERS[11:20], collapse=""),nr=2,nc=5);
h5write(C, "meins.h5","foo/foobaa/C");

df = data.frame(1L:5L,seq(0,1,length.out=5),c("ab","cde","fghi","a","s"), stringsAsFactors=FALSE);
h5write(df, "meins.h5","df");

#<-- Oeffnen einer H5 Datei -->
h5f = H5Fopen("meins.h5");

#<-- Zeige Inhalt der Datei -->
h5ls("meins.h5");
h5ls("meins.h5", all=TRUE);
h5ls("meins.h5", recursive=2);

#<-- Lese Werte aus der Datei -->
D = h5read("meins.h5","foo/A");
E = h5read("meins.h5","foo/B");
F = h5read("meins.h5","foo/foobaa/C");
G = h5read("meins.h5","df");

#<-- Schliesst einzelne Abschnitte -->
H5Dclose(h5d);
H5Fclose(h5f);

#<-- Schliesst alles -->
H5close();
