#' Transform votes and legislator information into object suitable for rollcall analysis.
#'
#' @description Returns either an n-by-m matrix of n deputies voting on m rollcalls,
#' or a rollcall object. The former is suitable for use with with the MCMCpack
#' package, while the latter is suitable for the pscl and wnominate packages.
#'
#' @param year integer, the year(s) for which the data is requested. Sequences
#' may be joined with ':' and multiple non-contiguous years may be concatenated
#' in the usual fashion. See examples.
#'
#' @param pscl logical, default 'TRUE'. The function by default returns
#' a rollcall object for use with the pcsl package or the wnominate package.
#' @param legis.data logical. If 'TRUE', a data frame of legislator characteristics
#' (party, state, name) is returned.
#'
#' @return Either rollcall object or a matrix of votes.
#'
#' @author Robert McDonnell; Leonardo Sangali Barone
#'
#' @import httr XML pscl dplyr tibble
#'
#' @examples
#'
#' # Return a rollcall object from the votes during 2012 to 2015, with legislator
#' data included
#' Votes <- voteToRollcall(2012:2015, legis.data = TRUE)
#' str(Votes)
#'
#' # Return a vote matrix of the votes in 2003
#' Votes2003 <- voteToRollcall(2003, pscl = FALSE)
#' @seealso \code{\link[pscl]{rollcall}}, \url{https://cran.r-project.org/web/packages/MCMCpack/index.html}
#' @rdname voteToRollcall
#'
#' @export


voteToRollcall <- function(year, pscl = TRUE, legis.data = FALSE){
  year_now <- as.character(Sys.Date())
  year_now <- strsplit(year_now, "[\\-]")[[1]][[1]]
  if(any(year > year_now)){
    return(cat("Error: data is not available for one or more of the years requested.\n"))
  }
  if(pscl == FALSE & legis.data == TRUE){
    return(cat("Error: Legislator data only available for rollcall object\n"))
  }
  if (!require("pacman")) install.packages("pacman")
  library(pacman)
  pacman::p_load(char=c("dplyr"), install=TRUE)
  pacman::p_load(char=c("tibble"), install=TRUE)
  pacman::p_load(char=c("pscl"), install=TRUE)


  votes <- data_frame()

  yaynay <- function(var){
    var <- gsub("Abstenção      ", NA, var)
    var <- gsub("Não            ", "0", var)
    var <- gsub("Obstrução      ", NA, var)
    var <- gsub("Art. 17        ", NA, var)
    var <- gsub("Sim            ", "1", var)
    var <- as.numeric(var)
  }

    for (i in year){
        cat(paste("Getting vote and legislator data...(", i, ")\n", sep=""))

      props <- listarProposicoesVotadasEmPlenario(i)
      vote_code <- unique(props$codProposicao)

      proposals <- data_frame()
      for (code in vote_code){
        proposals <- suppressWarnings(bind_rows(proposals,
                                                obterProposicaoPorID(code)))
      }

      vote_name <- proposals$nomeProposicao[proposals$idProposicaoPrincipal == "\n  "]
      vote_type <- substr(vote_name, 1, regexpr(" ", vote_name) - 1)
      vote_name <- unique(vote_name[vote_type != "REQ"])
      vote_type <- substr(vote_name, 1, regexpr(" ", vote_name) - 1)
      vote_number <- substr(vote_name,
                            regexpr(" ", vote_name) + 1,
                            regexpr("/", vote_name) - 1)
      vote_year <- substr(vote_name, regexpr("/", vote_name) + 1,
                          regexpr("/", vote_name) + 4)

      vote_df <- data_frame()


      for (j in 1:length(vote_year)){
        vote_df <- suppressWarnings(bind_rows(vote_df,
                           obterVotacaoProposicao(vote_type[j],
                                                  vote_number[j],
                                                  vote_year[j])
        ))
        vote_df$ano_votacao <- i
      }
      votes <- suppressWarnings(bind_rows(votes, vote_df))
    }
    votes$vote <- suppressWarnings(yaynay(votes$Voto))
    votes$rollcall <- paste(votes$Tipo, votes$Numero, sep ="")
    votes$rollcall <- paste(votes$rollcall, votes$Ano, sep="/")

    legislatorId <- votes$ideCadastro
    voteId <- votes$rollcall
    vote <- votes$vote

    nameID <- unique(legislatorId)
    n <- length(unique(nameID))
    m <- length(unique(voteId))

    rollCallMatrix <- matrix(NA, n, m)
    name_row <- match(legislatorId, nameID)
    name_col <- unique(voteId)
    name_col <- match(voteId, name_col)

    cat("Creating matrix of votes...\n")
    for(k in 1:length(legislatorId)){
      rollCallMatrix[name_row[k], name_col[k]] <- vote[k]
    }

    rollCallMatrix <- matrix(as.numeric(unlist(rollCallMatrix)), nrow=nrow(rollCallMatrix))
    dimnames(rollCallMatrix) <- list(unique(nameID), unique(voteId))

    legisData <- data.frame(ID=unique(nameID),
                            Name = votes$Nome[match(unique(nameID),
                                                    votes$ideCadastro)],
                            Party = votes$Partido[match(unique(nameID),
                                                        votes$ideCadastro)],
                            State = votes$UF[match(unique(nameID),
                                                   votes$ideCadastro)],
                            row.names = NULL, stringsAsFactors = FALSE)
    legisData$FullID = paste(legisData$Name, legisData$Party, sep = ":")

    if(pscl == FALSE & legis.data == FALSE) {
      cat("Returning matrix of votes and legislators\n")
      return(rollCallMatrix)
    } else if(pscl == TRUE & legis.data == FALSE){
      cat("Returning rollcall object\n")
      rollcallObj_1 <- rollcall(rollCallMatrix)
      return(rollcallObj_1)
    } else if(pscl == TRUE & legis.data == TRUE){

        rollCallObject <- rollcall(data=rollCallMatrix,
                                   legis.names=legisData$FullID,
                                   vote.names=unique(votes$rollcall),
                                   legis.data=legisData)

        cat("Returning rollcall object and legislator data\n")
        return(rollCallObject)
    }
}
