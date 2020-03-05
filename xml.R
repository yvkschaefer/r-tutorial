library(XML)
library(httr)

UA <- "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2227.0 Safari/537.36"
my_url <- "https://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist.xml"

doc <- xmlParse(GET(my_url, user_agent(UA)))
namespaces <- c(ns="http://www.ecb.int/vocabulary/2002-08-01/eurofxref")

# Get the data for US currency for all time periods.
# Find all the nodes of the form <Cube currency="USD"...>

united_states <- getNodeSet(doc, "//ns:Cube[@currency='USD']", namespaces)

rates <- as.numeric(sapply(united_states, xmlGetAttr, "rate"))

names(rates) <- sapply(getNodeSet(doc, "//ns:Cube[@time]", namespaces), xmlGetAttr, "time")


df <- data.frame(rates = rates,
                 time = names(rates))

# Using xpathApply, we can do
rates = xpathApply(doc, "//ns:Cube[@currency='SIT']",
                   xmlGetAttr, "rate", namespaces = namespaces )
rates = as.numeric(unlist(rates))
