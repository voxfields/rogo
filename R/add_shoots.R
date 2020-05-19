#' Add shoots
#'
#' Append new shoots to a new or existing root in a grammar.
#'
#' @param grammar A data table containing a Tracery-like grammar
#' @param new_root A (new) root string
#' @param ... A series of shoot strings to add to the specified root
#' @return A data table containing a Tracery-like grammar
#' @export

add_shoots <- function(grammar, new_root, ...) {
  rbind(grammar,
    data.table(
      root = new_root,
      shoot = c(...)
    )
  )
}



