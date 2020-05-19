#' Read Grammar
#'
#' Read in a CSV contianing a grammar.
#'
#' @param filename A CSV containing a Tracery-like grammar
#' @return A data table containing a Tracery-like grammar
#' @export

read_grammar <- function(filename) {
  fread(filename,sep=",", header= TRUE, select = c("root", "shoot"))
}
