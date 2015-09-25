#' Get Leadership
#'
#' @description Returns a data frame containing leaders and vice-leaders of parties/coalitions in
#' the Brazilian Chamber of Deputies. There are no required parameters.
#'
#' @return A data frame containing leaders and vice-leaders of parties/coalitions.
#'
#' @author Alexia Aslan <alexia.aslan[at]gmail.com>; Leonardo Sangali Barone <leobarone[at]gmail.com>;
#'
#' @examples
#'
#' # Return a data frame containing the learders and vice-leaders of parties/coalitions in office
#' lideres <- obterLideresBancadas()
#' print(lideres)
#'
#' @rdname obterLideresBancadas
#'
#' @export

obterLideresBancadas <- function(){
  parsedOutput <- xmlParse(GET('http://www.camara.gov.br/SitCamaraWS/Deputados.asmx/ObterLideresBancadas?'))
  bancada <- xmlAttributesToDataFrame(parsedOutput, "//bancada")
  names(bancada)[2] <- "nome.bancada"
  output <- data.frame()
  for (i in 1:nrow(bancada)){
    lideres <- xmlToDataFrame(getNodeSet(parsedOutput, paste("//bancada[@sigla = '", bancada$sigla[i], "']/*", sep = '')), stringsAsFactors = F)
    lideres$posicao <- "vice-lider"; lideres$posicao[1] <- "lider"
    lideres[1]
    output <- rbind(output, merge(bancada[i,], lideres))
  }
  return(output)
}
