
# This is the user-interface definition for the life expectancy app
#

library(shiny)

source('global.R')

shinyUI(fluidPage(

    titlePanel('Predicted Life Expectancy'),
    
    sidebarLayout(
        sidebarPanel(
            p(
                'There are a number of factors involved in human life expectancy, especially predicting average life expectancy in the future. By using the data available from the World Bank, we can observe life expectancy values by country over the years and make predictions on what life expectancy will be in the future.'
            ),
            h3(
                'Instructions'
            ),
            p(
                'Select a country of interest and what year you want to view the predicted life expectancy.'
            ),
            selectInput(
                'country',
                'Choose a Country',
                choices = setNames(lifeData$Country.Code, lifeData$Country.Name),
                selected = 'USA'
            ),
            sliderInput(
                'year',
                'Choose a Year',
                min = 2015,
                max = 2050,
                value = 2015,
                step = 1,
                format = '####'
            )
        ),
        mainPanel(
            plotOutput('lifePlot'),
            h3(textOutput('predicted_expectancy'))
            # p(textOutput('prediction_confidence'))
        )
    )
))
