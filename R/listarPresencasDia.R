#' List Legislators' Attendance in one day
#'
#' @description Returns a data frame with information on legislators attendance to sessions
#' in an specific day. The maximum difference between initial and final date allowed by the
#' web service allowed is 7 days. The inputs for this functions are of class character and
#' in the format dd/mm/yyyy.
#'
#' @param data string of format dd/mm/yyyy, the date if the sessions.
#' @param numLegislatura integer, the number specific legislature.
#' @param numMatriculaParlamentar integer, the legislator "matricula" number (check obterDeputados
#' function for help). This is a optional parameter and it's default is empty.
#' @param siglaPartido string, the political part of the proposition's author. This is a optional
#' parameter and it's default is empty.
#' @param siglaUF string, the state (Unidade da Federacao) of the proposition's author. This is
#' a optional parameter and it's default is empty.
#'
#' @return A data frame with information on legislators attendance to sessions in an specific day.
#'
#' @author Leonardo Sangali Barone; Alexia Aslan
#'
#' @import httr XML
#'
#' @examples
#'
#' dataSessao = "10/04/2012"
#' presencas <- listarPresencasDia(dataSessao)
#' head(presencas)
#'
#' @rdname listarPresencasDia
#' @export

listarPresencasDia <- function(data,
                               numLegislatura = "",
                               numMatriculaParlamentar = "",
                               siglaPartido = "",
                               siglaUF = ""){

  parsedOutput <- xmlParse(GET('http://www.camara.gov.br/SitCamaraWS/sessoesreunioes.asmx/ListarPresencasDia?',
                               query = list(data = data,
                                            dataFimnumLegislatura = numLegislatura,
                                            numMatriculaParlamentar = numMatriculaParlamentar,
                                            siglaPartido = siglaPartido,
                                            siglaUF = siglaUF)))

  dia <- xmlToDataFrame(getNodeSet(parsedOutput, "//dia"), stringsAsFactors = F)[,1:3]
  parlamentar <- xmlToDataFrame(getNodeSet(parsedOutput, "//parlamentar"), stringsAsFactors = F)[,1:7]
  output <- data.frame()

  for (i in 1:nrow(parlamentar)){
    sessao <- xmlToDataFrame(getNodeSet(parsedOutput,
                                        paste("//parlamentar[.//carteiraParlamentar/text() = '",
                                              parlamentar$carteiraParlamentar[i],
                                              "']//sessaoDia",
                                              sep = "")), stringsAsFactors = F)
    output <- rbind(output, merge(parlamentar[i,], sessao))
  }
  return(output)
}
