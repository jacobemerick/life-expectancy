
# This is the server logic for the life expectancy app
#

library(shiny)

source('global.R')

shinyServer(function(input, output) {
    
    output$lifePlot <- renderPlot({
        years <- names(lifeData)[5:58]
        years <- substr(years, 2, 5)
        years <- as.numeric(years)
        
        expectancy <- lifeData[lifeData$Country.Code == input$country, 5:58]
        expectancy <- as.numeric(expectancy)
        
        fit <- lm(expectancy ~ poly(years, 2, raw = TRUE))
        
        predicted_expectancy <- predict(
            fit,
            newdata = data.frame(years = c(input$year)),
            interval = 'confidence'
        )
        output$predicted_expectancy <- renderText({
            paste(
                'Predicted Expectancy:',
                round(predicted_expectancy[1], digits = 2)
            )
        })
        output$prediction_confidence <- renderText({
            paste(
                '95% confidence between',
                round(predicted_expectancy[2], digits = 2),
                'and',
                round(predicted_expectancy[3], digits = 2)
            )
        })
        
        years <- c(years, input$year)
        expectancy <- c(expectancy, predicted_expectancy[1])
        
        plot(
            years,
            expectancy,
            xlab = 'Year',
            ylab = 'Life Expectancy (in years)'
        )
        lines(
            years,
            predict(fit, newdata = data.frame(years = years)),
            col = 'blue'
        )
        points(
            input$year,
            predicted_expectancy[1],
            col = 'red',
            pch = 19
        )
    })

})
