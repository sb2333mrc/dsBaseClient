#'
#' @title Constructs a list of objects in the server-side
#' @description This is similar to the R function \code{list}.
#' @details If the objects to coerce into a list are for example vectors held in a matrix
#' or a data frame the names of the elements in the list are the names of columns.
#' 
#' Server function called: \code{listDS}
#' @param x a character string specifying the names of the objects to coerce into a list.
#' @param newobj 	a character string that provides the name for the output variable 
#' that is stored on the data servers. Default \code{list.newobj}.
#' @param datasources a list of \code{\link{DSConnection-class}} 
#' objects obtained after login. If the \code{datasources} argument is not specified
#' the default set of connections will be used: see \code{\link{datashield.connections_default}}.
#' @return \code{ds.list} returns a list of objects for each study that is stored on the server-side.  
#' @author DataSHIELD Development Team
#' @export
#' @examples
#' \dontrun{
#'   ## Version 6, for version 5 see the Wiki
#'   
#'   # connecting to the Opal servers
#' 
#'   require('DSI')
#'   require('DSOpal')
#'   require('dsBaseClient')
#'
#'   builder <- DSI::newDSLoginBuilder()
#'   builder$append(server = "study1", 
#'                  url = "http://192.168.56.100:8080/", 
#'                  user = "administrator", password = "datashield_test&", 
#'                  table = "CNSIM.CNSIM1", driver = "OpalDriver")
#'   builder$append(server = "study2", 
#'                  url = "http://192.168.56.100:8080/", 
#'                  user = "administrator", password = "datashield_test&", 
#'                  table = "CNSIM.CNSIM2", driver = "OpalDriver")
#'   builder$append(server = "study3",
#'                  url = "http://192.168.56.100:8080/", 
#'                  user = "administrator", password = "datashield_test&", 
#'                  table = "CNSIM.CNSIM3", driver = "OpalDriver")
#'   logindata <- builder$build()
#'   
#'   connections <- DSI::datashield.login(logins = logindata, assign = TRUE, symbol = "D") 
#'   
#'  # combine the 'LAB_TSC' and 'LAB_HDL' variables into a list
#'  myobjects <- c('D$LAB_TSC', 'D$LAB_HDL')
#'  ds.list(x = myobjects,
#'          newobj = "new.list",
#'          datasources = connections)
#'   
#'   # clear the Datashield R sessions and logout
#'   datashield.logout(connections)
#' }
#'
ds.list = function(x=NULL, newobj=NULL, datasources=NULL){

  # look for DS connections
  if(is.null(datasources)){
    datasources <- datashield.connections_find()
  }

  if(is.null(x)){
    stop("x=NULL. Please provide the names of the objects to coerce into a list!", call.=FALSE)
  }

  # the input variable might be given as column table (i.e. D$object)
  # or just as a vector not attached to a table (i.e. object)
  # we have to make sure the function deals with each case
  xnames <- extract(x)
  varnames <- xnames$elements
  obj2lookfor <- xnames$holders

  # check if the input object(s) is(are) defined in all the studies
  for(i in 1:length(varnames)){
    if(is.na(obj2lookfor[i])){
      defined <- isDefined(datasources, varnames[i])
    }else{
      defined <- isDefined(datasources, obj2lookfor[i])
    }
  }

  # call the internal function that checks the input object(s) is(are) of the same class in all studies.
  for(i in 1:length(x)){
    typ <- checkClass(datasources, x[i])
  }

  # create a name by default if user did not provide a name for the new variable
  if(is.null(newobj)){
    newobj <- "list.newobj"
  }

  # get the names of the list elements if the user has not specified any
  if(is.null(names)){
    names <- varnames
  }

  # call the server side function that does the job
  cally <-  paste0("listDS(list(",paste(x,collapse=","),"), list('",paste(varnames,collapse="','"),"'))")
  DSI::datashield.assign(datasources, newobj, as.symbol(cally))

  # check that the new object has been created and display a message accordingly
  finalcheck <- isAssigned(datasources, newobj)

}
