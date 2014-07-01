\name{getPooledMean}
\alias{getPooledMean}
\title{Gets a pooled statistical mean}
\usage{
getPooledMean(dtsources, x)
}
\arguments{
  \item{dtsources}{a list of opal object(s) obtained after
  login in to opal servers; these objects hold also the
  data assign to R, as \code{dataframe}, from opal
  datasources.}

  \item{x}{a character, the name of a numeric vector}
}
\value{
a pooled mean
}
\description{
This is an internal function.
}
\details{


This function is called to avoid calling the client
function 'ds.mean' which may stop the process due to some
checks not required when computing a mean inside a
function.
}
\keyword{internal}
