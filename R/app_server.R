#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @import DBI
#' @import duckdb
#' @noRd
app_server <- function(input, output, session) {
  # Your application server logic

    # Define reactive values ----
    r <- reactiveValues(
        # Data loads
        best_movies = custom_query_duckdb("SELECT * FROM stg_best_movies")
    )


    # Load modules ----
    mod_summary_server("summary")
}
