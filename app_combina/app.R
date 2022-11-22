library(shiny)
library(DT)
library(tidyverse)
library(shinythemes)
library(shinyhelper)

ui <- fluidPage(theme = shinytheme("flatly"),

  # App title ----
  titlePanel(
    title =
      div("Combina datos GPS de diferentes dispositivos",
          p(),
          img(src = "logo_serpam.jpg", height = "50", " SERPAM-EEZ"),
          tags$a(href = "https://lifewatcheric-sumhal.csic.es/", 
                 target = "_blank", 
                 tags$img(src = "logosumhal.jpg", height = "70", "Proyecto SUMHAL"))),
    windowTitle = "GPS Combina"
  ),
  
  
  sidebarLayout(
    sidebarPanel(width = 3,
      fileInput("csvs",
                label = "Selecciona los archivos *.csv",
                multiple = TRUE) %>% 
        helper(icon = "question",
               colour = "green",
               type = "markdown",
               content = "input_helper", 
               buttonLabel = "Ok")
    ),
    mainPanel(width = 9,
      tabsetPanel(type = "tabs",
                  tabPanel("Summary Table", DT::dataTableOutput("SummaryTable")),
                  tabPanel("Table", DT::dataTableOutput("Table")),
                  tabPanel("Plot", plotOutput("Plot")),
                  tabPanel("About", includeMarkdown("about.md")))
    )
  )
)

server <- function(input, output, session) {
  
  observe_helpers(withMathJax = TRUE)
  
  mycsvs <- reactive({
    
    ruta <- input$csvs$datapath
    
    if (is.null(ruta)) 
      return(NULL)
    
      lapply(ruta, read_csv) %>% 
        bind_rows() %>% 
        mutate(date = lubridate::make_date(as.numeric(paste0("20", year)), month, day),
               date_time = lubridate::make_datetime(as.numeric(paste0("20", year)), month, day, 
                                                    hour, min = minute, sec = second)) 
  })


  output$Plot <- renderPlot({
    
    d <- mycsvs()
    
    if (is.null(d)) return(NULL)
    
  
    # number of cols in plot 
    ncolplot <- function(x){
      ratio <- x/4
      if (ratio <= 1) n <- 1
      if ((ratio - floor(ratio)) == 0) {
        n <- round(ratio)
      } else {
        n <- round(ratio) + 1}
      return(n)
    }
    
    nn <- ncolplot(length(unique(d$id_gps)))

    d %>% 
      group_by(date, id_gps) %>% 
      summarise(n = length(id_gps)) %>% 
      ggplot(aes(y = n, x = date)) + 
      geom_bar(stat = "identity") +
      geom_hline(yintercept = (60/5)*23, colour = "blue") +
      facet_wrap(~id_gps, ncol = nn) +
      theme_bw()
  
  })
  
  output$SummaryTable <- renderDataTable({
    
    d <- mycsvs()
    
    if (is.null(d)) return(NULL)
    
    d %>%
      group_by(id_gps) %>% 
      summarise(
        n_records = n(),
        start_date = min(date_time),
        end_date = max(date_time),
        ndays = max(date) - min(date),
        expected_records = as.vector(ndays) * (60/5)*23
      ) %>% 
      datatable() %>% 
      formatDate(3:4, method = "toLocaleString")
    
    })
  
output$Table <- DT::renderDT(server = FALSE, {
    DT::datatable(
      mycsvs(),
      extensions = c("Buttons"),
      options = list(
        dom = 'Bfrtip',
        buttons = list(
          list(extend = "csv", text = "Download Current Page", filename = "page",
               exportOptions = list(
                 modifier = list(page = "current")
               )
          ),
          list(extend = "csv", text = "Download Full Results", filename = "data",
               exportOptions = list(
                 modifier = list(page = "all")
               )
          )
        )
      )
    )
  })
  
}

shinyApp(ui = ui, server = server)