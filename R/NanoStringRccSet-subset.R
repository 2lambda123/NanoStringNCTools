setMethod("[", "NanoStringRccSet",
function(x, i, j, ..., drop = FALSE)
{
  x <- callNextMethod()
  weights <- signatureWeights(x)
  if (length(weights) > 0L) {
    genes <- featureData(x)[["GeneName"]]
    keep <- unlist(lapply(weights, function(y) all(names(y) %in% genes)))
    if (!all(keep)) {
      signatureWeights(x) <- weights[keep]
    }
  }
  x
})

setMethod("subset", "NanoStringRccSet",
function(x, subset, select, ...)
{
  kvs <- c(sData(x), fData(x))
  eval(substitute(with(kvs, x[subset, select])))
})

setGeneric("endogenousSubset", signature = "x",
           function(x, subset, select) standardGeneric("endogenousSubset"))
setMethod("endogenousSubset", "NanoStringRccSet",
          function(x, subset, select) {
            call <- match.call()
            call$x <- x[which(featureData(x)[["BarcodeClass"]] == "Endogenous"), ]
            call[[1L]] <- as.name("subset")
            eval(call, parent.frame())
          })

setGeneric("housekeepingSubset", signature = "x",
           function(x, subset, select) standardGeneric("housekeepingSubset"))
setMethod("housekeepingSubset", "NanoStringRccSet",
          function(x, subset, select) {
            call <- match.call()
            call$x <- x[which(featureData(x)[["BarcodeClass"]] == "Housekeeping"), ]
            call[[1L]] <- as.name("subset")
            eval(call, parent.frame())
          })

setGeneric("negativeControlSubset", signature = "x",
           function(x, subset, select) standardGeneric("negativeControlSubset"))
setMethod("negativeControlSubset", "NanoStringRccSet",
          function(x, subset, select) {
            call <- match.call()
            call$x <- x[which(featureData(x)[["BarcodeClass"]] == "Negative"), ]
            call[[1L]] <- as.name("subset")
            eval(call, parent.frame())
          })

setGeneric("positiveControlSubset", signature = "x",
           function(x, subset, select) standardGeneric("positiveControlSubset"))
setMethod("positiveControlSubset", "NanoStringRccSet",
          function(x, subset, select) {
            call <- match.call()
            call$x <- x[which(featureData(x)[["BarcodeClass"]] == "Positive"), ]
            call[[1L]] <- as.name("subset")
            eval(call, parent.frame())
          })

setGeneric("controlSubset", signature = "x",
           function(x, subset, select) standardGeneric("controlSubset"))
setMethod("controlSubset", "NanoStringRccSet",
          function(x, subset, select) {
            call <- match.call()
            call$x <- x[which(featureData(x)[["IsControl"]]), ]
            call[[1L]] <- as.name("subset")
            eval(call, parent.frame())
          })

setGeneric("nonControlSubset", signature = "x",
           function(x, subset, select) standardGeneric("nonControlSubset"))
setMethod("nonControlSubset", "NanoStringRccSet",
          function(x, subset, select) {
            call <- match.call()
            call$x <- x[which(!featureData(x)[["IsControl"]]), ]
            call[[1L]] <- as.name("subset")
            eval(call, parent.frame())
          })

setGeneric("signatureSubset", signature = "x",
           function(x, subset, select) standardGeneric("signatureSubset"))
setMethod("signatureSubset", "NanoStringRccSet",
          function(x, subset, select) {
            genes <- unique(names(unlist(unname(signatureWeights(x)))))
            call <- match.call()
            call$x <- x[which(featureData(x)[["GeneName"]] %in% genes), ]
            call[[1L]] <- as.name("subset")
            eval(call, parent.frame())
          })