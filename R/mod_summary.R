#' summary UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_summary_ui <- function(id){
  ns <- NS(id)
  tagList(

  )
}

#' name_of_module1 Server Functions
#'
#' @noRd
mod_summary_server <- function(id,r){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

  })
}

## To be copied in the UI
# mod_summary_ui("summary")

## To be copied in the server
# mod_summary_server("summary")
