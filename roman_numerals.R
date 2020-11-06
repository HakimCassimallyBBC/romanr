library(stringr)

### For each letter, see if it is bigger than previous numbers
### If yes, add number to total
### If no, subtract number from total
set_rules <- function(later_letters, number, bigger_characters, total){
    if (str_detect(later_letters, paste0('[', bigger_characters,']'))) {
      new_total = total - number
    } else {
      new_total = total + number
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
  
  if (str_detect(string, 'V{4}|D{4}|L{4}')){
    stop("Do not repeat V, D, or L.")
  }
  
  for (i in 1:num_chars) {
    ch <- substr(string, i, i)
    later_letters <- substr(string, i+1, num_chars)
    
    if (ch == 'I') {
      total <- set_rules(later_letters, 1, 'VXLCDM', total)
    } else if (ch == 'V') {
      total <- set_rules(later_letters, 5, 'XLCDM', total)
    } else if (ch == 'X') {
      total <- set_rules(later_letters, 10, 'LCDM', total)
    } else if (ch == 'L') {
      total <- set_rules(later_letters, 50, 'CDM', total)
    } else if (ch == 'C') {
      total <- set_rules(later_letters, 100, 'DM', total)
    } else if (ch == 'D') {
      total <- set_rules(later_letters, 500, 'M', total)
    } else if (ch == 'M') {
      total = total + 1000
    }
  }
 return(total)
}

### Some examples
unroman('III')
unroman('XIX')
unroman('DCCVI')
unroman('MMMLXII')
unroman('cat')
unroman('IIII')
