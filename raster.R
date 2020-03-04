library(raster)

r <- raster(nrows=10, ncols=10)
r <- setValues(r, 1:ncell(r))
plot(r)

# addLayer
file <- system.file("external/test.grd", package="raster")
s <- stack(file, file, file)
r <- raster(file)
plot(r)
plot(s)
s <- addLayer(s, r/2, r*2)
s
plot(s)
s <- dropLayer(s, c(3, 5))
nlayers(s)
plot(s)
s



# adjacent
r <- raster(nrows=10, ncols=10)
adjacent(r, cells=c(1, 55), directions=8, pairs=TRUE)
plot(r)
a <- adjacent(r, cell = c(1,55,90), directions=4, sorted=TRUE)
a
r[c(1,55,90)] <- 1
r[a] <- 2
plot(r)
# same result as above
rook <- matrix(c(NA, 1, NA,
                 1, 0, 1,
                 NA, 1, NA), ncol=3, byrow=TRUE)
adjacent(r, cells = c(1,55,90), directions=rook, sorted=TRUE)
# Count the number of times that a cell with a certain value
# occurs next to a cell with a certain value
set.seed(0)
r <- raster(ncol=10, nrow=10)
values(r) <- round(runif(ncell(r)) * 5)
a <- adjacent(r, 1:ncell(r), 4, pairs=TRUE)
tb <- table(r[a[,1]], r[a[,2]])
tb
# make a matrix out of the 'table' object
tb <- unclass(tb)
plot(raster(tb, xmn=-0.5, xmx=5.5, ymn=-0.5, ymx=5.5))







# aggregate
r <- raster()
# a new aggregated raster, no values
ra <- aggregate(r, fact=10)
r <- setValues(r, runif(ncell(r)))
# a new aggregated raster, max of the values
ra <- aggregate(r, fact=10, fun=max)
# multiple layers
s <- stack(r, r*2)
x <- aggregate(s,2)
#SpatialPolygons
if (require(rgdal) & require(rgeos)) {
  p <- shapefile(system.file("external/lux.shp", package="raster"))
  p
  pa0 <- aggregate(p)
  pa0
  pa1 <- aggregate(p, by='NAME_1', sums=list(list(mean, 'ID_2')))
  pa1
}



# alignExtent
r <- raster()
e <- extent(-10.1, 9.9, -20.1, 19.9)
ea <- alignExtent(e, r)
e
extent(r)
ea




# animate

b <- brick(system.file("external/rlogo.grd", package="raster"))
animate(b, n=5)




# approxNA

r <- raster(ncols=5, nrows=5)
r1 <- setValues(r, runif(ncell(r)))
r2 <- setValues(r, runif(ncell(r)))
r3 <- setValues(r, runif(ncell(r)))
r4 <- setValues(r, runif(ncell(r)))
r5 <- setValues(r, NA)
r6 <- setValues(r, runif(ncell(r)))
r1[6:10] <- NA
r2[5:15] <- NA
r3[8:25] <- NA
s <- stack(r1,r2,r3,r4,r5,r6)
s[1:5] <- NA
x1 <- approxNA(s)
x2 <- approxNA(s, rule=2)
x3 <- approxNA(s, rule=2, z=c(1,2,3,5,14,15))






# area

r <- raster(nrow=18, ncol=36)
a <- area(r)
if (require(rgdal) & require(rgeos)) {
  p <- shapefile(system.file("external/lux.shp", package="raster"))
  p$area <- round(area(p) / 10000000,1)
  p$area
}



# arithmetic methods

r1 <- raster(ncols=10, nrows=10)
values(r1) <- runif(ncell(r1))
r2 <- setValues(r1, 1:ncell(r1) / ncell(r1) )
r3 <- r1 + r2
r2 <- r1 / 10
r3 <- r1 * (r2 - 1 + r1^2 / r2)



r <- raster(ncol=3, nrow=3)
values(r) <- 1:ncell(r)
as.character(r)
s <- stack(r, r)
as.character(s)
as.character(extent(s))

x <- as.character(s)
eval(parse(text=x))
y <- as.character(extent(s))
eval(parse(text=y))



r <- raster(ncol=3, nrow=3)
values(r) <- 1:ncell(r)
as.raster(r)


b <- brick(system.file("external/rlogo.grd", package="raster"))
b
nlayers(b)
names(b)
extract(b, 870)








# https://rspatial.org/raster/spatial/8-rastermanip.html

x <- raster()
x
x <- raster(ncol=36, nrow=18, xmn=-1000, xmx=1000, ymn=-100, ymx=900)
x
res(x) # res = resolution
res(x) <- 100
res(x)
ncol(x)
ncol(x) <- 18
ncol(x)
res(x)
# crs = coordinate reference system. defines the projection
projection(x) <- "+proj=utm +zone=48 +datum=WGS84"
x
r <- 0
r <- raster(ncol=10, nrow=10)
ncell(r)
hasValues(r)
values(r) <- 1:ncell(r)
hasValues(r)
values(r)
set.seed(0)
values(r) <- runif(ncell(r))
hasValues(r)
inMemory(r)
values(r)[1:10]
plot(r, main='Raster with 100 cells')
hasValues(r)
res(r)
dim(r)
xmax(r)
r
xmax(r) <- 0
hasValues(r)
r
res(r)
dim(r)
ncol(r) <- 6
hasValues(r)
res(r)
dim(r)
xmax(r)

r <- 0
r

r <- raster(ncol=10, nrow=10)
values(r) <- 1:ncell(r)
r

s <- r + 10 # this + 10 affects the _values_
s <- sqrt(s) # again, this operation affects the values
s <- s * r + 5
s
r[] <- runif(ncell(r))
r <- round(r)
r <- r == 1
r
s[r] <- -0.5
s[!r] <- 5
s[s == 5] <- 15
s