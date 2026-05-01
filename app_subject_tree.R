library(shiny)
library(dplyr)
library(networkD3)
library(DT)

subjects <- read.csv('bachelor_it_subjects.csv', stringsAsFactors = FALSE)

build_hierarchy <- function(subjects_data) {
  year_nodes <- subjects_data %>%
    distinct(course_name, year_level) %>%
    mutate(
      source_name = course_name,
      target_name = paste('Year', year_level)
    ) %>%
    select(source_name, target_name)

  type_nodes <- subjects_data %>%
    distinct(year_level, subject_type) %>%
    mutate(
      source_name = paste('Year', year_level),
      target_name = paste('Year', year_level, '-', subject_type)
    ) %>%
    select(source_name, target_name)

  subject_nodes <- subjects_data %>%
    mutate(
      source_name = paste('Year', year_level, '-', subject_type),
      target_name = paste(subject_code, subject_name, sep = ': ')
    ) %>%
    select(source_name, target_name)

  links_raw <- bind_rows(year_nodes, type_nodes, subject_nodes) %>%
    distinct()

  nodes <- data.frame(
    name = unique(c(links_raw$source_name, links_raw$target_name)),
    stringsAsFactors = FALSE
  )

  links <- links_raw %>%
    mutate(
      source = match(source_name, nodes$name) - 1,
      target = match(target_name, nodes$name) - 1,
      value = 1
    ) %>%
    select(source, target, value)

  list(nodes = nodes, links = links)
}

ui <- fluidPage(
  titlePanel('Bachelor of IT Subject Structure'),

  sidebarLayout(
    sidebarPanel(
      selectInput(
        'year_filter',
        'Select Year Level',
        choices = c('All', sort(unique(subjects$year_level))),
        selected = 'All'
      ),
      selectInput(
        'type_filter',
        'Select Subject Type',
        choices = c('All', unique(subjects$subject_type)),
        selected = 'All'
      )
    ),

    mainPanel(
      h4('Hierarchy View'),
      sankeyNetworkOutput('subject_tree', height = '520px'),
      br(),
      h4('Filtered Subject List'),
      DTOutput('subject_table')
    )
  )
)

server <- function(input, output, session) {

  filtered_subjects <- reactive({
    data <- subjects

    if (input$year_filter != 'All') {
      data <- data %>% filter(year_level == as.numeric(input$year_filter))
    }

    if (input$type_filter != 'All') {
      data <- data %>% filter(subject_type == input$type_filter)
    }

    data
  })

  output$subject_tree <- renderSankeyNetwork({
    data <- filtered_subjects()
    hierarchy <- build_hierarchy(data)

    sankeyNetwork(
      Links = hierarchy$links,
      Nodes = hierarchy$nodes,
      Source = 'source',
      Target = 'target',
      Value = 'value',
      NodeID = 'name',
      fontSize = 12,
      nodeWidth = 30,
      sinksRight = FALSE
    )
  })

  output$subject_table <- renderDT({
    filtered_subjects() %>%
      arrange(year_level, semester, subject_type, subject_code) %>%
      datatable(
        rownames = FALSE,
        options = list(pageLength = 10)
      )
  })
}

shinyApp(ui = ui, server = server)
