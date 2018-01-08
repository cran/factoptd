\name{factoptd}
\alias{factoptd}
\alias{factoptd.default}
\alias{print.factoptd}
\title{
Factorial optimal designs for two-colour cDNA microarray experiments
}
\description{
Used to compute factorial A-, D- or E-optimal designs for two-colour cDNA microarray experiments.}
\usage{
factoptd(narys, Optcrit = "", desvect,...)


\method{factoptd}{default}(narys, Optcrit = "", desvect,...)
\method{print}{factoptd}(x, ...)
}
\arguments{
  \item{narys}{
integer, specifying number of arrays. 
}
  \item{desvect}{
matrix, specifying design vectors (see Debusho, Haines and Gemechu (2014) for more details).
}
  \item{Optcrit}{
character, specifying the optimality criteria to be used. \code{Optcrit} takes the letter \code{"A"}, \code{"D"} and \code{"E"} for factorial \code{A-}, \code{D-} and \code{E-}optimal designs, respectively.
}
  \item{x}{
the object to be printed.
}
  \item{\dots}{
not used.
}
}
\details{
\code{factoptd} computes factorial optimal  designs for the two-colour cDNA microarray experiments  for a given design vectors and number of arrays by making use to the complete enumeration methods proposed in Debusho, Haines and Gemechu (2014).

}
\value{
Returns resultant factorial A-, D- or E-optimal design(s) with their corresponding score value. Specifically: 


\item{call}{the method call.}         
\item{b}{number of arrays.}
\item{desvect}{Design vestors}
\item{Optcrit}{optimality criteria.} 
\item{tnfd}{Total number of resultant  optimal factorial design(s)}
\item{optfctd}{obtained factorial optimal design. Each row of \code{optfctd} represents different designs allocation/"frequency" vectors.}
\item{optscv}{score value of the optimality criteria \code{'Optcrit'} of the resultant factorial optimal design(s), \code{'optfctd'}.}

NB: The function \code{factoptd} also saves the summary of the resultant factorial optimal  design(s) in .csv format in the R session's temporary directory. 
}
\references{
Debusho, L. K., Gemechu, D. B. and Haines, L. M. (2014). Optimal Factorial Designs for Two-Colour Microarray Experiments:  Properties Of Admissible Designs, A-, D- And E-Optimality Criteria.  Peer-reviewed Proceedings of the Annual Conference of the South African Statistical Association for 2014 (SASA 2014), Rhodes University, Grahmstown, South Africa. pp 17 - 24, ISBN: 978-1-86822-659-7.}
\author{
Dibaba Bayisa Gemechu, Legesse Kassa Debusho, and Linda Haines
}

\examples{
  
  ##To obtain factorial A-optimal  design for a given
  ##design vector using 9 slides/arrays, set
  
  narys <- 9  #Number of arrays

  desvect = rbind(c(0,2,-2),c(-2,0,-2),
                c(-2,2,0),c(0,2,2),
                c(-2,0,2),c(-2,-2,0)) #Design vector

  Optcrit <- "A"   #Optimality criteria


  factoptdA <- factoptd(narys = 9, Optcrit = "A", desvect = 
                  rbind(c(0,2,-2),c(-2,0,-2),c(-2,2,0),c(0,2,2),c(-2,0,2),c(-2,-2,0)))

  
  print(factoptdA)

}

\keyword{Factorial A-optimal designs}
\keyword{Factorial D-optimal designs}
\keyword{Factorial E-optimal designs}
\keyword{Microarray experiment} 
