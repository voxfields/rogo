#' Trim shoots
#'
#' Remove shoots or an entire root from a grammar.
#'
#' @param grammar A data table containing a Tracery-like grammar
#' @param trimmed_root Root string to remove
#' @param ... A series of shoot strings to remove from the specified root
#' @return A data table containing a Tracery-like grammar
#' @export

trim_shoots <- function(grammar, trimmed_root, ...) {
  if (length(c(...)) > 0) {
    return(grammar[! paste0(root, shoot) %in% paste0(trimmed_root, c(...))])
  }
  else {
    return(grammar[root != trimmed_root])
  }
}
