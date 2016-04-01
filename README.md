# bRasilLegis
R tools for Brazilian Chamber of Deputies (Camara dos Deputados) data

## Data Source
Camara dos Deputados web service: http://www2.camara.leg.br/transparencia/dados-abertos/dados-abertos-legislativo

## Authors
Leonardo Sangali Barone <leobarone@gmail.com>, Alexia Aslan <alexia.aslan@gmail.com> and Robert Myles McDonnell

## How to install?
install.packages("devtools"); library(devtools);
install_github("leobarone/bRasilLegis")

## How does it work?
The package offers methods to fetch legislative information stored in the web API maintained by the Brazilian Chamber of Deputies. Tutorial coming soon. Please check Câmara dos Deputados web service for detailed information on the data available.

[Neylson Crepalde] (https://www.facebook.com/neylson.crepalde) provided us with a very nice example of how to use the package to build networks of federal deputies (in portuguese, [here] (https://neylsoncrepalde.github.io/2016-04-01-Rede-de-Parlamentares-usando-o-pacote-bRasilLegis/)).

## Important!
This package depends on 2 other R packages: XML and httr. Please, make sure you have them ready prior to using bRasilLeg. ALL of the functions require XML and httr.

## Want to help the developers? Have good ideas?
This is an ongoing open source and open minded project. The main purposes are to generate public data on Brazilian politics, enhance gov transparency, help political science community and have fun. If you have comments, critics, suggestions or even want to be part of the developing team, just write us (leobarone@gmail.com and alexia.aslan@gmail.com).

