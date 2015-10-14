#' Get Integral Speech
#'
#' @description Returns a data frame containing detailed information on every speech given in
#' a legislative session. All the parameters of the function are required. You can use the
#' listarDiscursosPlenario function to get values for the parameters.
#'
#' @param codSessao string, the code of the session(check listarDiscursosPlenario function for help)
#' @param numOrador integer, the number of legislator in the session(check listarDiscursosPlenario
#' function for help)
#' @param numQuarto integer, the number of the room where the speech is stored (check
#' listarDiscursosPlenario function for help)
#' @param numInsercao, the number of the speech in the session (check listarDiscursosPlenario
#' function for help)
#'
#' @return A a data frame containing detailed information on every speech given in
#' a legislative session.
#'
#' @author Leonardo Sangali Barone; Alexia Aslan
#'
#' @import httr XML
#'
#' @examples
#'
#' codSessao = "022.3.54.O"; numOrador=1 ;
#' numQuarto=11 ; numInsercao=0
#' discurso <- obterInteiroTeorDiscursosPlenario(codSessao, numOrador, numQuarto, numInsercao)
#' print(discurso)
#'
#' @rdname obterInteiroTeorDiscursosPlenario
#'
#' @export

obterInteiroTeorDiscursosPlenario <- function(codSessao,
                                              numOrador,
                                              numQuarto,
                                              numInsercao){
  parsedOutput <- xmlParse(GET('http://www.camara.gov.br/SitCamaraWS/SessoesReunioes.asmx/obterInteiroTeorDiscursosPlenario?',
                               query = list(codSessao = codSessao,
                                            numOrador = numOrador,
                                            numQuarto = numQuarto,
                                            numInsercao = numInsercao)))
  return(xmlToDataFrame(getNodeSet(parsedOutput, "//sessao"), stringsAsFactors = F))
}
