## File Name : ui.R
## Date      : 21st Dec 2014
############################

shinyUI(fluidPage(
  headerPanel(h4("Coursera Data Science specialization : Developing data product assignment")),
  navbarPage("Navigation Menu",
      tabPanel("Diamond Pricing",
          fluidPage(titlePanel("Diamond Price Evaluator"),
              sidebarLayout(
                  sidebarPanel(
                      helpText("In order to evaluate the price of a diamond, we need some characteristics of 
                        the diamond first (number of carats, diamond colour, clarity of the diamond and the 
                          type of certification."),
                          sliderInput("carat", 
                                      label = h5("Size of Diamond in Carats:"),
                                      min = .1, max = 5,step=.01, value = 1),
                          br(),
                          selectInput("colour", 
                                      label = h5("Color of Diamond:"),
                                      choices = list("D - Colorless" = "D",
                                                    "E - Colorless" = "E",
                                                    "F - Colorless" = "F",
                                                    "G - Near Colorless" = "G",
                                                    "H - Near Colorless" = "H",
                                                    "I - Near Colorless" = "I"),
                                      selected = "F"),
                          br(),
                          radioButtons("clarity",label=h5("Clarity of Diamond:"),
                                       choices = list("IF - Internally Flawless" = "IF",
                                                      "VVS1 - Very Very Slighlty Included" = "VVS1",
                                                      "VVS2 - Very Very Slighlty Included" = "VVS2",
                                                      "VS1 - Very Slighlty Included" = "VS1",
                                                      "VS1 - Very Slighlty Included" = "VS2"),
                                       selected = "VVS2" ),
                          br(),
                          selectInput("cert", 
                                      label = h5("Certification Type:"),
                                      choices = c("GIA","HRD","IGI"),
                                      selected = "GIA")
                  ),
                
                  #mainPanel(plotOutput("map"))
                  mainPanel(
                          h3("Evaluation results"),
                          br(),
                          h5("Your Diamond specifications are:"),
                          textOutput("carat_out"), 
                          textOutput("colour_out"),
                          textOutput("clarity_out"),
                          textOutput("cert_out"),
                          br(),
                          h5(textOutput("prediction")),
                          br(),
                          tags$div(class = "row-fluid", plotOutput("Plot"))
                          )
              )
          )
      ),
      tabPanel("Data table",
          h5("The dataset used for this assignment is part of ggplot2 package and is presented below:"),
          br(),
          tableOutput("tableView")
      ),
      tabPanel("Documentation",
          h5("Getting Started with this App"),
          br(),
          p("This App is an application for the Developing Data Products course on Coursera and is designed to allow 
          a user to evaluate diamond prices based on some input characteristics for the diamond. The following 
          characteristics are selectable from within the application:"),
          br(),
          h6("Carat"),
          p("Represents a measure of size of a diamond. Usually diamonds are increasing their price with size: the 
          larger the diamond is, the higher the price is. The allowable range is .1 to 5 (even if larger diamonds 
          are rare in a retail setting."),
          h6("Color"),
          p("Represents a measure of how colorless a diamond is with less color often being more desireable. The 
          scale ranges from D (least amount of color) to I (most amount of color). Again diamonds do exist outside 
          of this range but won't be present in this app."),
          h6("Clarity"),
          p("Represents a measure of how flawless a diamond is. The range contains five levels: IF, VVS1, VVS2, VS1 
          and VS2"),
          h6("Certification"),
          p("Lastly certification type represents which agency graded the diamond in question. Each agency has 
          differing standard for the above measures and therefore which agency determined the Carat, Color, and 
          Clarity can impact price.")
      )
    )
))