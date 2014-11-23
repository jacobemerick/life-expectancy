
# This is the shared logic for the life expectancy app
# You can learn more about this data set here
#
# http://data.worldbank.org/indicator/SP.DYN.LE00.IN
#

countryData <- read.csv(
    'data/country-metadata.csv',
    header = TRUE,
    stringsAsFactors = FALSE
)
isCountry <- countryData$Region != ''

lifeData <- read.csv(
    'data/life-expectancy.csv',
    header = TRUE,
    skip = 2,
    stringsAsFactors = FALSE
)
lifeData <- lifeData[isCountry,]

incompleteCountries <- apply(
    lifeData,
    1,
    function(row) {
        sum(is.na(row))
    }
) > 10
lifeData <- lifeData[!incompleteCountries,]

lifeData <- lifeData[order(lifeData$Country.Name),]
