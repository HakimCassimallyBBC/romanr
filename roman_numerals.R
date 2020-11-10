library(stringr)

### For each letter, see if it is bigger than previous numbers
### If yes, add number to total
### If no, subtract number from total
set_rules <- function(later_letters, letter, number, total){
  ordered_units <- c('I', 'V', 'X', 'L', 'C', 'D', 'M')
  unit_pos <- match(letter, ordered_units)
  smaller_units <- paste0('[', paste0(ordered_units[1:unit_pos], collapse = ""), ']')
  next_units <- paste0('[', paste0(ordered_units[(unit_pos+1):(unit_pos+2)], collapse = ""), ']')
  higher_units <- paste0('[', paste0(ordered_units[(unit_pos+3):7], collapse = ""), ']')
  
  if (str_detect(later_letters, higher_units)) {
    stop(paste0("You are trying to subtract ", letter, " in an impossible way."))
  }
  
  next_letter <- str_extract(later_letters, '^.{1}')
  if (is.na(next_letter)) {
    next_letter = ""
  }

  if (str_detect(next_letter, letter)) {
    if (str_detect(later_letters, next_units)) {
      stop(paste0("You can only use ", letter, " once to subtract."))
    }
  }
  
  if (str_detect(next_letter, smaller_units) | nchar(next_letter) == 0) {
    new_total = total + number
  } else if (str_detect(next_letter, next_units)) {
    if (str_detect(later_letters, letter)) {
      stop("You can't add and subtract the same letter.")
    } else {
      new_total = total - number
    }
  } else {
    stop("Something has gone wrong. ")
  }
}

### Function to translate from Roman numerals
unroman <- function(string){
  total <- 0
  num_chars <- nchar(string)
  
  if (str_detect(string, '[^IVXLCDM]')) {
    stop("Invalid characters used; only I V C L C D M are valid characters.")
  }
  
  if (str_detect(string, 'I{4}|X{4}|C{4}')) {
    stop("Do not repeat I, X or C more than 3 times consecutively.")
  }
  
  if (str_detect(string, 'V{2}|D{2}|L{2}')){
    stop("Do not repeat V, D, or L.")
  }
  
  for (i in 1:num_chars) {
    ch <- substr(string, i, i)
    later_letters <- substr(string, i+1, num_chars)
    
    if (ch == 'I') {
      total <- set_rules(later_letters, 'I', 1, total)
    } else if (ch == 'V') {
      total <- set_rules(later_letters, 'V', 5, total)
    } else if (ch == 'X') {
      total <- set_rules(later_letters, 'X', 10, total)
    } else if (ch == 'L') {
      total <- set_rules(later_letters, 'L', 50, total)
    } else if (ch == 'C') {
      total <- set_rules(later_letters, 'C', 100,  total)
    } else if (ch == 'D') {
      total <- set_rules(later_letters, 'D', 500, total)
    } else if (ch == 'M') {
      total = total + 1000
    }
  }
 return(total)
}


