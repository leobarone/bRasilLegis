#' Get Parties Coalitions
#'
#' @description Returns a data frame containing details of the coalitions made by the parties with representation in
#' the Brazilian Chamber of Deputies. All the parameters are optional.
#'
#' @param idBloco string, the identification of the coalition(s).
#' This is an optional parameter, the default is empty.
#' @param numLegislatura integer, the number of the legislature.
#' This is an optional parameter, the default is empty.
#'
#' @return A data frame containing information of all or of the required coalition.
#'
#' @author Alexia Aslan <alexia.aslan[at]gmail.com>; Leonardo Sangali Barone <leobarone[at]gmail.com>;
#'
#' @examples
#'
#' # Return a data frame containing all the coalitions
#' blocos <- obterPartidosBlocoCD
#' print(blocos)
#'
#' @rdname obterPartidosBlocoCD
#'
#' @export


obterPartidosBlocoCD <- function (idBloco.param = "",
                                  numLegislatura.param = ""){
  parsedOutput <- xmlParse(GET('http://www.camara.gov.br/SitCamaraWS/Deputados.asmx/ObterPartidosBlocoCD?',
                                      query = list(idBloco = idBloco.param,
                                                   numLegislatura = numLegislatura.param)))
  bloco <- xmlToDataFrame(getNodeSet(parsedOutput, "//bloco"), stringsAsFactors = F)[,1:5]
  output <- data.frame()

  for (i in 1:nrow(bloco)){
    partidos <- xmlToDataFrame(getNodeSet(parsedOutput,
                                            paste("//bloco[.//idBloco/text() = '",
                                                  bloco$idBloco[i],
                                                  "']//partido",
                                                  sep = "")), stringsAsFactors = F)
    output <- rbind(output, merge(bloco[i,], partidos))
  }
  return(output)
}
