% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/class-export.R
\name{Export}
\alias{Export}
\title{R6 Class representing an Export}
\description{
R6 Class representing a resource for managing volume export jobs.
}
\examples{

## ------------------------------------------------
## Method `Export$print`
## ------------------------------------------------

\dontrun{
# x is API response when export is requested
export_object <- Export$new(
                    res = x,
                    href = x$href,
                    auth = auth,
                    response = attr(x, "response")
                   )

 # Print export object
 export_object$print()
}


## ------------------------------------------------
## Method `Export$reload`
## ------------------------------------------------

\dontrun{
# x is API response when export is requested
export_object <- Export$new(
                    res = x,
                    href = x$href,
                    auth = auth,
                    response = attr(x, "response")
                   )

 # Reload export object
 export_object$reload()
}

}
\section{Super class}{
\code{\link[sevenbridges2:Item]{sevenbridges2::Item}} -> \code{Export}
}
\section{Public fields}{
\if{html}{\out{<div class="r6-fields">}}
\describe{
\item{\code{URL}}{List of URL endpoints for this resource.}

\item{\code{id}}{Export job string identifier.}

\item{\code{state}}{The state of the export job. Possible values are:
\itemize{
\item \code{PENDING}: the export is queued;
\item \code{RUNNING}: the export is running;
\item \code{COMPLETED}: the export has completed successfully;
\item \code{FAILED}: the export has failed.
}}

\item{\code{source}}{List containing the source file ID that is being exported
to the volume.}

\item{\code{destination}}{List containing the destination volume ID and
location (file name) on the volume where the file is being exported.}

\item{\code{overwrite}}{Indicates whether the exported file name was
overwritten if another file with the same name already existed on the
volume.}

\item{\code{started_on}}{Time when the export job started.}

\item{\code{finished_on}}{Time when the export job ended.}

\item{\code{properties}}{List of volume properties set.}

\item{\code{error}}{In case of error in the export job, standard API error is
returned here.}

\item{\code{result}}{File object that was exported.}
}
\if{html}{\out{</div>}}
}
\section{Methods}{
\subsection{Public methods}{
\itemize{
\item \href{#method-Export-new}{\code{Export$new()}}
\item \href{#method-Export-print}{\code{Export$print()}}
\item \href{#method-Export-reload}{\code{Export$reload()}}
\item \href{#method-Export-clone}{\code{Export$clone()}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-Export-new"></a>}}
\if{latex}{\out{\hypertarget{method-Export-new}{}}}
\subsection{Method \code{new()}}{
Create a new Export object.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{Export$new(res = NA, ...)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{res}}{Response containing Export job information.}

\item{\code{...}}{Other response arguments.}
}
\if{html}{\out{</div>}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-Export-print"></a>}}
\if{latex}{\out{\hypertarget{method-Export-print}{}}}
\subsection{Method \code{print()}}{
Print method for Export class.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{Export$print()}\if{html}{\out{</div>}}
}

\subsection{Examples}{
\if{html}{\out{<div class="r example copy">}}
\preformatted{\dontrun{
# x is API response when export is requested
export_object <- Export$new(
                    res = x,
                    href = x$href,
                    auth = auth,
                    response = attr(x, "response")
                   )

 # Print export object
 export_object$print()
}

}
\if{html}{\out{</div>}}

}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-Export-reload"></a>}}
\if{latex}{\out{\hypertarget{method-Export-reload}{}}}
\subsection{Method \code{reload()}}{
Refresh the Export object with updated information.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{Export$reload(...)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{...}}{Other arguments that can be passed to core \code{api()} function
like 'fields', etc.}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
\code{\link{Export}} object.
}
\subsection{Examples}{
\if{html}{\out{<div class="r example copy">}}
\preformatted{\dontrun{
# x is API response when export is requested
export_object <- Export$new(
                    res = x,
                    href = x$href,
                    auth = auth,
                    response = attr(x, "response")
                   )

 # Reload export object
 export_object$reload()
}

}
\if{html}{\out{</div>}}

}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-Export-clone"></a>}}
\if{latex}{\out{\hypertarget{method-Export-clone}{}}}
\subsection{Method \code{clone()}}{
The objects of this class are cloneable with this method.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{Export$clone(deep = FALSE)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{deep}}{Whether to make a deep clone.}
}
\if{html}{\out{</div>}}
}
}
}
