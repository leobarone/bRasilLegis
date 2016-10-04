#' List Legislator Attendance
#'
#' @description Returns a data frame with information on a specific legislator's attendance
#' at sessions between an initial and a final date. The maximum difference between initial
#' and final date allowed by the web service is 7 days. The inputs for this
#' functions are of class character and in the format dd/mm/yyyy. All the three parameters
#' are required.
#'
#' @param dataIni string of format dd/mm/yyyy, the initial date.
#' @param dataFim string of format dd/mm/yyyy, the initial date.
#' @param numMatriculaParlamentar integer, the legislator "matricula" number (check
#' obterDeputados function for help).
#'
#' @return A data frame with information on a specific legislator's attendance at sessions.
#'
#' @author Leonardo Sangali Barone; Alexia Aslan
#'
#' @import httr XML dplyr
#'
#' @examples
#'
#' dataInicial = "10/04/2012"; dataFinal = "17/04/2012"; matricula = 371
#' presenca <- listarPresencasParlamentar(dataInicial, dataFinal, matricula)
#' head(presenca)
#'
#' @rdname listarPresencasParlamentar
#' @export

listarPresencasParlamentar <- function(dataIni,
                                       dataFim,
                                       numMatriculaParlamentar){

  parsedOutput <- xmlParse(GET('http://www.camara.gov.br/SitCamaraWS/sessoesreunioes.asmx/ListarPresencasParlamentar?',
                               query = list(dataIni = dataIni,
                                            dataFim = dataFim,
                                            numMatriculaParlamentar = numMatriculaParlamentar)))

  parlamentar <- xmlToDataFrame(getNodeSet(parsedOutput, "//parlamentar"), stringsAsFactors = F)[,1:5]
  sessao <- xmlToDataFrame(getNodeSet(parsedOutput, "//sessao"), stringsAsFactors = F)
  output <- merge(parlamentar, sessao)
  output$data <- substr(output$descricao, nchar(output$descricao) - 9, nchar(output$descricao))
  return(output)
}
