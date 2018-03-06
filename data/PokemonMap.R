#install.packages("leaflet")
#install.packages("sp")
#install.packages("rgeos")
#install.packages("shinythemes")

library("rgeos")
library("leaflet")
library("sp")
library("shinythemes")



#Coordinates of all Cities
pallet.town = Polygon(cbind(c(0, 0, 1, 1, 0), c(4, 5, 5, 4, 4)))
viridian.city = Polygon(cbind(c(0, 0, 1, 1, 0), c(7, 8, 8, 7, 7)))
pewter.city = Polygon(cbind(c(0, 0, 1, 1, 0), c(10, 11, 11, 10, 10)))
cerulean.city = Polygon(cbind(c(8, 8, 9, 9, 8), c(11, 12, 12, 11, 11)))
saffron.city = Polygon(cbind(c(8, 8, 9, 9, 8), c(8, 9, 9, 8, 8)))
vermillion.city = Polygon(cbind(c(8, 8, 9, 9, 8), c(5, 6, 6, 5, 5)))
celadon.city = Polygon(cbind(c(4, 4, 5, 5, 4), c(8, 9, 9, 8, 8)))
fuschia.city = Polygon(cbind(c(6, 6, 7, 7, 6), c(2, 3, 3, 2, 2)))
lavender.town = Polygon(cbind(c(12, 12, 13, 13, 12), c(8, 9, 9, 8, 8)))
cinnabar.island = Polygon(cbind(c(0, 0, 1, 1, 0), c(0, 1, 1, 0, 0)))
indigo.plateau = Polygon(cbind(c(-3, -3, -2, -2, -3), c(11, 12, 12, 11, 11)))

pallet = Polygons(list(pallet.town), "c1")
viridian = Polygons(list(viridian.city), "c2")
pewter = Polygons(list(pewter.city), "c3")
cerulean = Polygons(list(cerulean.city), "c4")
saffron = Polygons(list(saffron.city), "c5")
vermillion = Polygons(list(vermillion.city), "c6")  
celadon = Polygons(list(celadon.city), "c7")  
fuschia = Polygons(list(fuschia.city), "c8")  
lavender = Polygons(list(lavender.town), "c9")  
cinnabar = Polygons(list(cinnabar.island), "c10")
indigo = Polygons(list(indigo.plateau), "c11")

#Coordinates of all Routes
route.1 = Polygon(cbind(c(0, 0, 1, 1, 0), c(5, 7, 7, 5, 5)))
route.2 = Polygon(cbind(c(0, 0, 1, 1, 0), c(8, 10, 10, 8, 8)))
route.3 = Polygon(cbind(c(1, 1, 4, 4, 1), c(10, 11, 11, 10, 10)))
route.4 = Polygon(cbind(c(3, 3, 8, 8, 3), c(11, 12, 12, 11, 11)))
route.5 = Polygon(cbind(c(8, 8, 9, 9, 8), c(9, 11, 11, 9, 9)))
route.6 = Polygon(cbind(c(8, 8, 9, 9, 8), c(6, 8, 8, 6, 6)))
route.7 = Polygon(cbind(c(5, 5, 8, 8, 5), c(8, 9, 9, 8, 8)))
route.8 = Polygon(cbind(c(9, 9, 12, 12, 9), c(8, 9, 9, 8, 8)))
route.9 = Polygon(cbind(c(9, 9, 12, 12, 9), c(11, 12, 12, 11, 11)))
route.10 = Polygon(cbind(c(12, 12, 13, 13, 12), c(9, 12, 12, 9, 9)))
route.11 = Polygon(cbind(c(9, 9, 12, 12, 9), c(5, 6, 6, 5, 5)))
route.12 = Polygon(cbind(c(12, 12, 13, 13, 12), c(4, 8, 8, 4, 4)))
route.13 = Polygon(cbind(c(10, 10, 13, 13, 10), c(3, 4, 4, 3, 3)))
route.14 = Polygon(cbind(c(9, 9, 10, 10, 9), c(2, 4, 4, 2, 2)))
route.15 = Polygon(cbind(c(7, 7, 9, 9, 7), c(2, 3, 3, 2, 2)))
route.16 = Polygon(cbind(c(2, 2, 4, 4, 2), c(8, 9, 9, 8, 8)))
route.17 = Polygon(cbind(c(2, 2, 3, 3, 2), c(2, 8, 8, 2, 2)))
route.18 = Polygon(cbind(c(3, 3, 6, 6, 3), c(2, 3, 3, 2, 2)))
route.19 = Polygon(cbind(c(6, 6, 7, 7, 6), c(1, 2, 2, 1, 1)))
route.20 = Polygon(cbind(c(1, 7, 7, 1, 1), c(0, 0, 1, 1, 0)))
route.21 = Polygon(cbind(c(0, 0, 1, 1, 0), c(1, 4, 4, 1, 1)))
route.22 = Polygon(cbind(c(-3, -3, 0, 0, -3), c(7, 8, 8, 7, 7)))
route.23 = Polygon(cbind(c(-3, -3, -2, -2, -3), c(8, 11, 11, 8, 8)))
route.24 = Polygon(cbind(c(8, 8, 9, 9, 8), c(12, 14, 14, 12, 12)))
route.25 = Polygon(cbind(c(9, 9, 11, 11, 9), c(13, 14, 14, 13, 13)))

r1 = Polygons(list(route.1), "r1")
r2 = Polygons(list(route.2), "r2")
r3 = Polygons(list(route.3), "r3")
r4 = Polygons(list(route.4), "r4")
r5 = Polygons(list(route.5), "r5")
r6 = Polygons(list(route.6), "r6")
r7 = Polygons(list(route.7), "r7")
r8 = Polygons(list(route.8), "r8")
r9 = Polygons(list(route.9), "r9")
r10 = Polygons(list(route.10), "r10")
r11 = Polygons(list(route.11), "r11")
r12 = Polygons(list(route.12), "r12")
r13 = Polygons(list(route.13), "r13")
r14 = Polygons(list(route.14), "r14")
r15 = Polygons(list(route.15), "r15")
r16 = Polygons(list(route.16), "r16")
r17 = Polygons(list(route.17), "r17")
r18 = Polygons(list(route.18), "r18")
r19 = Polygons(list(route.19), "r19")
r20 = Polygons(list(route.20), "r20")
r21 = Polygons(list(route.21), "r21")
r22 = Polygons(list(route.22), "r22")
r23 = Polygons(list(route.23), "r23")
r24 = Polygons(list(route.24), "r24")
r25 = Polygons(list(route.25), "r25")

#List of Cities
city = SpatialPolygons(list(pallet, viridian, pewter, cerulean, saffron, vermillion, 
                            celadon, fuschia, lavender, cinnabar, indigo), 1:11)

#List of Land Routes
land.route = SpatialPolygons(list(r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11,
                                  r12, r13, r14, r15, r16, r17, r18, r19, r22, 
                                  r23, r24, r25), 1:23)

#List of Water Routes
water.route = SpatialPolygons(list(r20, r21), 1:2)

#Map the Kanto Region
kanto.region <- leaflet(height = "1000px") %>% 
                addPolygons(color = "#a52020", weight = 1, data = city)  %>% 
                addPolygons(color = "#5f7bc0", weight = 1, data = water.route) %>% 
                addPolygons(color = "#75c191", weight = 1, data = land.route) 
               

