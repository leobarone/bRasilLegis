#' XML Attributes to Data Frame
#'
#' @description Returns the attribute values of a node set as a data frame.
#'
#' @param doc XMLInternalDocument, a xml document object.
#' @param xpath The xml path of the node set containing the attributes.
#'
#' @return A data frame containing attribute values
#'
#' @author Leonardo Sangali Barone; Alexia Aslan
#'
#' @note This is an auxiliary function used in several other functions of the bRasilLeg package
#'
#' @import httr XML dplyr
#'
#' @rdname xmlAttributesToDataFrame
#' @export

xmlAttributesToDataFrame <- function(doc, xpath){
  return(as.data.frame(t(xpathSApply(doc, xpath, xmlAttrs)), stringsAsFactors = F))
}
