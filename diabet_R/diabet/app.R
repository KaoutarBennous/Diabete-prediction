# Import libraries
library(shiny)
library(data.table)
library('randomForest')

# Read in the RF model
model <- readRDS("model.rds")

# User interface                   

ui <- pageWithSidebar(
  includeCSS("www/styleR.css"),
  # Page header
  
  # Input values
  sidebarPanel(
    tags$style("
      .well{
        background-color: #143F6B;
        margin-left:-2%;
        height:100%;
        box-shadow: 10px 2px 27px 2px rgba(214, 231, 233, 0.52);
   
      }"
    ),
    #HTML("<h3>Input parameters</h3>")
    tags$label(h3("Paramètres d'entrée"), class="one"),
    numericInput("Pregnancies", 
                 label = "Grossesses", value = "0"),
    numericInput("Glucose", 
                 label = "Glucose", value = "0"),
    numericInput("BloodPressure", 
                 label = "Tension artérielle", value = "0"),
    numericInput("SkinThickness", 
                 label = "Epaisseur de la peau", value = "0"),
    numericInput("Insulin", 
                 label = "Insuline", value = "0"),
    numericInput("BMI", 
                 label = "IMC", value = "0.0"),
    numericInput("DiabetesPedigreeFunction", 
                 label = "Fonction généalogique du diabète", value = "0.0"),
    numericInput("Age", 
                 label = "Age", value = "0"),
    
    actionButton("submitbutton", "Tester", 
                 class = "btn btn-primary")
  ),
  
  
  mainPanel(
    tags$label(h2('État/Résultat')), # Status/Output Text Box
    verbatimTextOutput('contents'),
    tableOutput('tabledata'), # Prediction results table
    verbatimTextOutput('texto'),
    verbatimTextOutput('textoo'),
    tabPanel("Component 2"),
    tabPanel("Component 3")
    
  )
)

# Server                           
server<- function(input, output, session) {
  
  # Input Data
  datasetInput <- reactive({  
    df <- data.frame(
      Name = c("Pregnancies",
               "Glucose",
               "BloodPressure",
               "SkinThickness",
               "Insulin",
               "BMI",
               "DiabetesPedigreeFunction",
               "Age"),
      Value = as.character(c(input$Pregnancies,
                             input$Glucose,
                             input$BloodPressure,
                             input$SkinThickness,
                             input$Insulin,
                             input$BMI,
                             input$DiabetesPedigreeFunction,
                             input$Age)),
      stringsAsFactors = FALSE)
    
    Outcome <- 0
    df <- rbind(df, Outcome)
    input <- transpose(df)
    
    write.table(input,"input.csv", sep=",", quote = FALSE, row.names = FALSE, col.names = FALSE)
    
    test <- read.csv(paste("input", ".csv", sep=""), header = TRUE)
    
    Output <<- data.frame(Prediction=predict(model,test), round(predict(model,test,type="prob"), 3))
    print(Output)
    
  })
  
  # Status/Output Text Box
  output$contents <- renderPrint({
    if (input$submitbutton>0) { 
      isolate("Aprés calcules.") 
    } else {
      return("Avant calcules.")
    }
  })
  
  # Prediction results table
  output$tabledata <- renderTable({ 
    if (input$submitbutton>0) { 
      isolate(datasetInput()) 
    } 
  })
  
  # Prediction results table
  output$texto <- renderPrint({
    if (input$submitbutton>0) { 
      if (Output$Prediction == 0) { 
        isolate("Test négative.") 
      } else {
        result = paste("Test positive avec un pourcentage de ",Output$X1)
        return(result)
      } 
    }
  })
  
}


# Create the shiny app
shinyApp(ui = ui, server = server)

