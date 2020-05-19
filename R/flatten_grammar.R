#' Flatten Grammar
#'
#' Generate text from a specified origin and grammar.
#'
#' @param grammar A data table containing a Tracery-like grammar
#' @param origin A root string to begin flattening
#' @return A data table containing a Tracery-like grammar
#' @export

flatten_grammar <- function(grammar, origin){
  template <- grammar[grammar$root == origin][sample(.N, 1)]$shoot
  while (str_detect(template, "#[a-zA-Z_\\.]+#")) {
    roots <- str_replace_all(
              str_extract_all(template, "#[a-zA-Z_\\.]+#")[[1]], "#", "")
    for (a_root in roots){
      if (! str_split(a_root, "\\.")[[1]][1] %in% grammar$root) {
        template <- str_replace_all(template, paste0("#", a_root, "#"),
                                              paste0("$", a_root, "$"))
      }
      else {
      template <- str_replace(template, paste0("#", a_root, "#"),
                            grow_branch(grammar, a_root))
      }
    }
  }
  return(template)
}
