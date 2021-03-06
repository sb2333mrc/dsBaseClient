#'
#' @title ds.listOpals list all Opal objects in the analytic environment
#' @description ds.listOpals calls the internal DataSHIELD function getOpals() which identifies
#' all Opal objects in the analytic environment.
#' @details ds.listOpals calls the internal DataSHIELD function getOpals() which identifies
#' all Opal objects in the analytic environment. If there are no Opal servers in the analytic
#' environment ds.listOpalsIreminds the user that they have to login to a valid set of Opal
#' login objects, if they wish to use DataSHIELD. If there is only one set of Opals, ds.listOpals
#' copies that one set and names the copy 'default.opals'. This default set will then be used by
#' default by all subsequent calls to client-side functions. If there is more than one set of Opals
#' in the analytic environment, ds.listOpals tells the user that they can either explicitly specify the
#' Opals to be used by each client-side function by providing an explicit "datasources=" argument
#' for each call, or can alternatively use the ds.setDefaultOpals function to specify a default
#' set of Opals to be used by all client-side calls unless over-ruled by the 'datasources=' argument.
#' @keywords internal
#' @return Lists all of the sets of Opals currently found in the analytic environment and advises
#' the user how best to respond depending whether there are zero, one or multiple Opals detected.
#' @author Burton, PR. 28/9/16
#' @export
#'

ds.listOpals<-function(){
  .Deprecated("DSI::datashield.connections")
  datashield.connections()
}
#ds.listOpals
