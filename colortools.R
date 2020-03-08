library(colortools)


adjacent("red")

x <- adjacent("#606FEF", bg = "gray20")
x


ana_tom <- anagrams("tomato")
pizza(ana_tom, bg = "gray20")


x <- col2HSV("red")
x

col2HSV("tomato") # #FF6347




# complementary: complementary or opposite colour
# complementary or opposite colour scheme is formed by colours that are opposite each other on the colour wheel (ex: red and green). The high contrast of complementary colours creates a vibrant look that must be managed well so it is not jarring.

complementary("red", bg = "gray20")
complementary("tomato", bg = "gray20")
complementary("goldenrod", bg = "gray20")
opposite("goldenrod", bg = "gray20")
opposite("#DB00FF", bg = "gray20")


# pals: palette colours included in colortools
# this function can be used to display the palettes included in the package, or to show the colour names of the specified palette

pals()
pals(bg = "gray30")
pals(name = "dream")

adjacent(pals(name = "dream"))


pizza(pals("cheer"), bg = "gray20")
pizza(pals("cheer"), bg = "gray20", init.angle = 90)


wheel(pals("fish")[1])
pals(name = "fish")


pizza(c("red", "blue", "white", "green"))
pals("fish")[1]
pizza(pals("fish")[2], bg = "gray20")
wheel(pals("fish")[2])
pals(bg = "gray20")
wheel(pals("terra")[5], bg = "gray20")
wheel(pals("terra")[5])


pizza(rainbow(7), bg = "gray20")
pizza(setColors("tomato", 18), bg = "gray20", cex = 0.9)
pizza(setColors("#0000FF", 7), bg = "gray20", cex = 0.9)
col2HSV("tomato")






# sequential: sequential hue-saturation-value (HSV) colours
# this function allows to get a sequence of colors in an HSV model with optional pre-especified numbers for saturation, value, and alpha. It is a very flexible function to play with different combinations of saturation, value, and alpha.

sequential("tomato", percentage = 30, what = "value",
           s = NULL, v = NULL, alpha = NULL, fun = "linear",
           plot = TRUE, verbose = TRUE)
sequential("tomato", percentage = 30,
           fun = "sqrt", plot = TRUE)
col2HSV("tomato")

sequential("orange") # fun = "linear" by default
sequential("orange", fun = "sqrt")
sequential("orange", fun = "log")
# linear and sqrt both share the same start and final hex colour codes, however log has a different final hex colour code... hm...

#logarithmic | ˌlɒɡəˈrɪðmɪk |
# adjective
# relating to or expressed in terms of logarithms.
# • (of a scale) constructed so that successive points along an axis, or graduations which are an equal distance apart, represent values which are in an equal ratio: the scale is logarithmic, so pH 2 is ten times more acidic than pH 3.
# • (of a curve) forming a straight line when plotted on a logarithmic scale; exponential.

#so, logarithmic in this case means that each hexadecimal colour vector value is 10x more than the one previous to it ??

sequential("orange", what="value", s = 0.7, fun = "log")


sequential("orange")
sequential("orange", what = "value")
sequential("orange", what = "saturation") # this is default
sequential("orange", what = "alpha")

# -------------------------------------------------------------------------



sequential("orange", 10, what = "value", s = 0.7, alpha = 0.5, fun = "log")
x <- 4
sequential("blue", 5, s = 0.7, alpha = 0.5, fun = "log")



# setColors: set colours for a colour wheel
# this function sets a given number of colours to create a colour wheel

setColors("tomato", 3)
pizza(setColors("tomato", 3), bg = "gray20")
opposite("tomato", bg = "gray20")

### this above function is 100% my answer for PEM... but it _will_ be jarring. So how to improve.... I think sequential() could be helpful, in conjunction. Maybe


# more examples
setColors("tomato", 12)
pizza(setColors("tomato", 12), bg = "gray20")
pizza(setColors("#3D6DCC", 7), bg = "gray20", init.angle = 90)
pizza(setColors("#3D6DCC", 7), bg = "gray20")
pizza(setColors("#3D6DCC", 8), bg = "gray20")




# splitComp: split complementary colour scheme
# a variation of the complementary colour scheme. It uses the two colours adjacent to its complement

splitComp("red", bg = "gray20")


# square

square("red", bg = "gray20")



# tetradic
# uses four colours arranged into two complementary pairs
tetradic("red", bg = "gray20")


# triadic
# uses colours that are evenly spaced around the colour wheel
triadic("red", bg = "gray20")


# wheel
# generates a colour wheel for a given colour
wheel(pals("drift")[5], bg = "gray20", verbose = TRUE)
pals()

wheel("tomato", num = 18, bg = "gray20", cex = 0.7)






