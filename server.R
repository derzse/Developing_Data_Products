## File Name : server.R
## Date      : 21st Dec 2014
############################

library(Ecdat)
library(caret)
modelFit <- train(price ~ .,data=Diamond,method="glm")


shinyServer(
        function(input, output) {

                output$carat_out <- renderText({
                        paste("Carat: ", input$carat)
                })
                output$colour_out <- renderText({
                        paste("Colour: ", input$colour)
                })
                output$clarity_out <- renderText({
                        paste("Clarity: ", input$clarity)
                })
                output$cert_out <- renderText({
                        paste("Certification: ", input$cert)
                })
                output$data_out <- renderText({
                        paste("Certification: ", input$cert)
                })                
                output$prediction <- renderText({
                        new_ob <- data.frame(as.numeric(input$carat),
                                            as.factor(input$colour),
                                            as.factor(input$clarity),
                                            as.factor(input$cert))
                        names(new_ob) <- c('carat','colour','clarity','certification')
                        paste("Price Estimatefor selected diamond: ", sprintf("$ %.2f",predict(modelFit, newdata=new_ob)))
                })

                buildPlot <- reactive({
                        caratParam <- input$carat
                        colourParam <-input$colour
                        if (colourParam == "D - Colorless")
                                colourParam="D"
                        else if (colourParam == "E - Colorless")
                                colourParam="E"
                        else if (colourParam == "F - Colorless")
                                colourParam="F"
                        else if (colourParam == "G - Near Colorless")
                                colourParam="G"
                        else if (colourParam == "H - Near Colorless")
                                colourParam="H"
                        else if (colourParam == "I - Near Colorless")
                                colourParam="I"

                        clarityParam <-input$clarity
                        if (clarityParam == "IF - Internally Flawless")
                                clarityParam="IF"
                        else if (clarityParam == "VVS1 - Very Very Slighlty Included")
                                clarityParam="VVS1"
                        else if (clarityParam == "VVS2 - Very Very Slighlty Included")
                                clarityParam="VVS2"
                        else if (clarityParam == "VS1 - Very Slighlty Included")
                                clarityParam="VS1"
                        else if (clarityParam == "VS1 - Very Slighlty Included")
                                clarityParam="VS2"

                        certParam <-input$cert
                        if (certParam == "GIA")
                                certParam="GIA"
                        else if (certParam == "HRD")
                                certParam="HRD"
                        else if (certParam == "IGI")
                                certParam="IGI"
                        
                        
                        DS<- subset(Diamond,  colour == colourParam  ) #& clarity == clarityParam & certification == certParam)
                        
                  if(nrow(DS)>0)
                  {      
                         ggplot(DS, aes(x=carat, y=price, fill=clarity, group=clarity)) +  facet_grid(.~ certification) +
                          geom_point(aes(group=clarity, colour=clarity), size=3)  + 
                          stat_smooth(method="lm") + 
                          xlab("Carat") + ylab("Price in $") +
                          ggtitle("Diamond price evaluation")
                  }
                       
                        
                })

               output$Plot <- renderPlot ({buildPlot()})
               datasetInput <- reactive(Diamond)
               output$tableView <- renderTable({datasetInput()})

        }
)
