#' Grid layout pages
#'
#' @param css Additional CSS files to include
#' @param page_size Set page size
#' @param ... Additional arguments passed to pagedown
#'
#' @export
deckhand <- function(css = NULL, page_size = NULL, ...) {

  if (page_size != "A4 landscape") {
    stop("Only A4 landscape is permitted")
  }

  core_css <- system.file(
    "resources", "css",
    c("deckhand-a4-landscape.css"),
    package = "deckhand2"
  )

  if (!is.null(css)) {
    css <- c(core_css, css)
  }

  pagedown::html_paged(
    css = css,
    number_sections = FALSE,
    ...
  )


}
