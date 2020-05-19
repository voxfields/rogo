#' Grow Branch
#'
#' Generate text by growing shoots from a specified root.
#'
#' @param grammar A data table containing a Tracery-like grammar
#' @param a_root A root string to seed a shoot
#' @return A string
#' @export

grow_branch <- function(grammar, a_root) {
  if (str_detect(a_root, "\\.")) {
    modifiers <- str_split(a_root, "\\.")[[1]]
    a_root <- modifiers[1]
    modifiers <- modifiers[-1]
    shoot <- grammar[grammar$root == a_root][sample(.N, 1)]$shoot
    if (!str_detect(shoot, "#.+#")) {
      if ('s' %in% modifiers) {
        tail_char <- str_sub(shoot, -1)
        if (tail_char %in% c('s', 'h', 'x', 'y')) {
          if (tail_char == 's' | tail_char == 'h' | tail_char == 'x') {
            shoot <- paste0(shoot, 'es')
          }
          if (tail_char == 'y') {
            if (str_extract(str_sub(shoot, -2), "^[aeiouAEIOU]")) {
              shoot <- paste0(shoot, "s")
            }
            else {
              shoot <- paste0(str_sub(shoot, 0, nchar(shoot) - 1), "ies")
            }
          }
        }
        else {
          shoot <- paste0(shoot, "s")
        }
      }
      if ('ed' %in% modifiers) {
        tail_char <- str_sub(shoot, -1)
        if (tail_char %in% c('s', 'h', 'x', 'y', 'e')) {
          if (tail_char == 's' | tail_char == 'h' | tail_char == 'x') {
            shoot <- paste0(shoot, 'ed')
          }
          if (tail_char == 'e') {
            shoot <- paste0(shoot, "d")
          }
          if (tail_char == 'y') {
            if (str_extract(str_sub(shoot, -2), "^[aeiouAEIOU]")) {
              shoot <- paste0(str_sub(shoot, 0, nchar(shoot) - 1), "ied")
            }
            else {
              shoot <- paste0(shoot, "ed")
            }
          }
        }
        else {
          shoot <- paste0(shoot, "ed")
        }
      }
      if ("cap" %in% modifiers) {
        shoot <- paste0(toupper(str_sub(shoot, 1, 1)), str_sub(shoot,2))
      }
      if ("inQuotes" %in% modifiers) {
        shoot <- paste0('"', shoot, '"')
      }
      if ("a" %in% modifiers) {
        if (!is.na(str_extract(str_sub(shoot, 1), "^[aeiouAEIOU]"))) {
          shoot <- paste0("an ", shoot)
        }
        else {
          shoot <- paste0("a ", shoot)
        }
      }
      return(shoot)
    }
  }
  else {
    return(grammar[grammar$root == a_root][sample(.N, 1)]$shoot)
  }
}

.datatable.aware = TRUE