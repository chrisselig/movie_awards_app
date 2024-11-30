#' helpers
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd

#' Common Filters for Tabs
#'
#' This function generates a shared set of filters that can be reused across multiple tabs
#' in a Shiny application. Additional tab-specific filters can be added to the same row.
#'
#' @param additional_filters UI elements for tab-specific filters. These will appear in the
#'   same row as the common filters.
#'
#' @return A `fluidRow` containing shared `selectInput` elements (year and reviewer)
#'   and any additional filters passed to the function.
#'
#' @examples
#' # Use this function in a Shiny UI:
#' common_filters(
#'   shiny::selectInput("specific_filter", "Specific Filter", choices = c("A", "B"))
#' )
#'
#' @export
common_filters <- function(additional_filters = NULL) {
    fluidRow(
        # Shared filters
        column(
            2,
            shiny::selectInput(
                "year_filter",
                "Year",
                choices = NULL,
                selected = NULL
            )
        ),
        column(
            2,
            shiny::selectInput(
                "reviewer_filter",
                "Reviewer",
                choices = NULL,
                selected = NULL
            )
        ),
        # Tab-specific filters in the same row
        additional_filters
    )
}

#' Execute a Custom Query on a MotherDuck DuckDB Database
#'
#' This function connects to a MotherDuck DuckDB database, executes a custom SQL query,
#' and returns the queried data as a data frame. The connection is automatically closed after the query.
#'
#' @param query A character string containing the SQL query to execute.
#'
#' @return A data frame containing the results of the SQL query.
#'
#' @examples
#' # Example usage:
#' query <- "SELECT * FROM awards WHERE year > 2020"
#' results <- custom_query_duckdb(query)
#'
#' @export
custom_query_duckdb <- function(query) {
    # Get the token from the environment
    token <- Sys.getenv("bidamia_motherduck_token")

    if (nchar(token) == 0) {
        stop("MotherDuck token not found. Please set the environment variable 'bidamia_motherduck_token'.")
    }

    # Establish connection to DuckDB
    con <- DBI::dbConnect(duckdb::duckdb())

    # Load the MotherDuck extension
    DBI::dbExecute(con, "LOAD 'motherduck'")

    # Attach to MotherDuck with the token
    DBI::dbExecute(con, paste0("SET motherduck_token='", token, "'"))
    DBI::dbExecute(con, "ATTACH 'md:'")

    # Use the specific database
    DBI::dbExecute(con, "USE movie_awards")

    # Execute the query
    queried_data <- DBI::dbGetQuery(con, query)

    # Disconnect
    DBI::dbDisconnect(con, shutdown = TRUE)

    return(queried_data)
}
