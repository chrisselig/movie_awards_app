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



