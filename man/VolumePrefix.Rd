% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/class-VolumePrefix.R
\name{VolumePrefix}
\alias{VolumePrefix}
\title{R6 Class representing a VolumePrefix}
\description{
R6 Class representing a resource for managing VolumePrefix objects.
}
\examples{

## ------------------------------------------------
## Method `VolumePrefix$print`
## ------------------------------------------------

\dontrun{
# x is API response when volume prefix is requested
volume_prefix_object <- VolumePrefix$new(
                    res = x,
                    href = x$href,
                    auth = auth,
                    response = attr(x, "response")
                   )

 # Print the Volume Prefix object
 volume_prefix_object$print()
}


## ------------------------------------------------
## Method `VolumePrefix$reload`
## ------------------------------------------------

\dontrun{
# x is API response when volume prefix is requested
volume_prefix_object <- VolumePrefix$new(
                    res = x,
                    href = x$href,
                    auth = auth,
                    response = attr(x, "response")
                   )

 # Reload volume prefix object
 volume_prefix_object$reload()
}


## ------------------------------------------------
## Method `VolumePrefix$list_contents`
## ------------------------------------------------

\dontrun{
# x is API response when volume prefix is requested
volume_prefix_object <- VolumePrefix$new(
                    res = x,
                    href = x$href,
                    auth = auth,
                    response = attr(x, "response")
                   )

 # List volume prefix object contents
 volume_prefix_object$list_contents()
}


## ------------------------------------------------
## Method `VolumePrefix$import`
## ------------------------------------------------

\dontrun{
# x is API response when volume prefix is requested
volume_prefix_object <- VolumePrefix$new(
                    res = x,
                    href = x$href,
                    auth = auth,
                    response = attr(x, "response")
                   )

 # List volume prefix object contents
 volume_prefix_object$import(destination_project = destination_project)
}

}
\section{Super class}{
\code{\link[sevenbridges2:Item]{sevenbridges2::Item}} -> \code{VolumePrefix}
}
\section{Public fields}{
\if{html}{\out{<div class="r6-fields">}}
\describe{
\item{\code{URL}}{List of URL endpoints for this resource.}

\item{\code{prefix}}{File/prefix name on the volume.}

\item{\code{volume}}{Volume id.}
}
\if{html}{\out{</div>}}
}
\section{Methods}{
\subsection{Public methods}{
\itemize{
\item \href{#method-VolumePrefix-new}{\code{VolumePrefix$new()}}
\item \href{#method-VolumePrefix-print}{\code{VolumePrefix$print()}}
\item \href{#method-VolumePrefix-reload}{\code{VolumePrefix$reload()}}
\item \href{#method-VolumePrefix-list_contents}{\code{VolumePrefix$list_contents()}}
\item \href{#method-VolumePrefix-import}{\code{VolumePrefix$import()}}
\item \href{#method-VolumePrefix-clone}{\code{VolumePrefix$clone()}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-VolumePrefix-new"></a>}}
\if{latex}{\out{\hypertarget{method-VolumePrefix-new}{}}}
\subsection{Method \code{new()}}{
Create a new VolumePrefix object.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{VolumePrefix$new(res = NA, ...)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{res}}{Response containing VolumePrefix object information.}

\item{\code{...}}{Other response arguments.}
}
\if{html}{\out{</div>}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-VolumePrefix-print"></a>}}
\if{latex}{\out{\hypertarget{method-VolumePrefix-print}{}}}
\subsection{Method \code{print()}}{
Print method for VolumePrefix class.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{VolumePrefix$print()}\if{html}{\out{</div>}}
}

\subsection{Examples}{
\if{html}{\out{<div class="r example copy">}}
\preformatted{\dontrun{
# x is API response when volume prefix is requested
volume_prefix_object <- VolumePrefix$new(
                    res = x,
                    href = x$href,
                    auth = auth,
                    response = attr(x, "response")
                   )

 # Print the Volume Prefix object
 volume_prefix_object$print()
}

}
\if{html}{\out{</div>}}

}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-VolumePrefix-reload"></a>}}
\if{latex}{\out{\hypertarget{method-VolumePrefix-reload}{}}}
\subsection{Method \code{reload()}}{
Reload the VolumePrefix object information.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{VolumePrefix$reload()}\if{html}{\out{</div>}}
}

\subsection{Examples}{
\if{html}{\out{<div class="r example copy">}}
\preformatted{\dontrun{
# x is API response when volume prefix is requested
volume_prefix_object <- VolumePrefix$new(
                    res = x,
                    href = x$href,
                    auth = auth,
                    response = attr(x, "response")
                   )

 # Reload volume prefix object
 volume_prefix_object$reload()
}

}
\if{html}{\out{</div>}}

}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-VolumePrefix-list_contents"></a>}}
\if{latex}{\out{\hypertarget{method-VolumePrefix-list_contents}{}}}
\subsection{Method \code{list_contents()}}{
List the contents of a volume folder.
This call lists the contents of a specific volume folder.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{VolumePrefix$list_contents(
  limit = getOption("sevenbridges2")$limit,
  continuation_token = NULL,
  ...
)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{limit}}{The maximum number of collection items to return
for a single request. Minimum value is \code{1}.
The maximum value is \code{100} and the default value is \code{50}.
This is a pagination-specific attribute.}

\item{\code{continuation_token}}{Continuation token received to use for next
chunk of results. Behaves similarly like offset parameter.}

\item{\code{...}}{Other arguments that can be passed to core \code{api()} function,
like 'fields' for example.
With fields parameter you can specify a subset of fields to include in
the response. You can use: \code{href}, \code{location}, \code{volume}, \code{type},
\code{metadata}, \verb{_all}. Default: \verb{_all}.}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
\code{\link{VolumeContentCollection}} object containing list of
\code{\link{VolumeFile}} and  \code{\link{VolumePrefix}} objects.
}
\subsection{Examples}{
\if{html}{\out{<div class="r example copy">}}
\preformatted{\dontrun{
# x is API response when volume prefix is requested
volume_prefix_object <- VolumePrefix$new(
                    res = x,
                    href = x$href,
                    auth = auth,
                    response = attr(x, "response")
                   )

 # List volume prefix object contents
 volume_prefix_object$list_contents()
}

}
\if{html}{\out{</div>}}

}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-VolumePrefix-import"></a>}}
\if{latex}{\out{\hypertarget{method-VolumePrefix-import}{}}}
\subsection{Method \code{import()}}{
This call lets you queue a job to import this file or
folder from a volume into a project on the Platform. \cr
Essentially, you are importing an item from your cloud storage provider
(Amazon Web Services, Google Cloud Storage, Azure or Ali Cloud) via the
volume onto the Platform. \cr
If successful, an alias will be created on the Platform. Aliases appear
on the Platform and can be copied, executed, and modified as such.
They refer back to the respective item on the given volume.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{VolumePrefix$import(
  destination_project = NULL,
  destination_parent = NULL,
  name = NULL,
  overwrite = FALSE,
  autorename = FALSE,
  preserve_folder_structure = NULL,
  ...
)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{destination_project}}{String destination project id or Project
object. Not required, but either \code{destination_project} or
\code{destination_parent} directory must be provided.}

\item{\code{destination_parent}}{String folder id or File object
(with \code{type = 'FOLDER'}). Not required, but either \code{destination_project}
or \code{destination_parent} directory must be provided.}

\item{\code{name}}{The name of the alias to create. This name should be unique
to the project.
If the name is already in use in the project, you should
use the \code{overwrite} query parameter in this call to force any item with
that name to be deleted before the alias is created.
If name is omitted, the alias name will default to the last segment of
the complete location (including the prefix) on the volume. \cr

Segments are considered to be separated with forward slashes /.
Allowed characters in file names are all alphanumeric and special
characters except forward slash (/), while folder names can contain
alphanumeric and special characters underscores (_), hyphens (-), and
dots (.).}

\item{\code{overwrite}}{Set to \code{TRUE} if you want to overwrite the item if
another one with the same name already exists at the destination.
Bear in mind that if used with folders import, the folder's content
(files with the same name) will be overwritten, not the whole folder.}

\item{\code{autorename}}{Set to \code{TRUE} if you want to automatically rename the
item (by prefixing its name with an underscore and number) if another
one with the same name already exists at the destination.
Bear in mind that if used with folders import, the folder content will
be renamed, not the whole folder.}

\item{\code{preserve_folder_structure}}{Set to \code{TRUE} if you want to keep the
exact source folder structure. The default value is \code{TRUE} if the item
being imported is a folder. Should not be used if you are importing a
file. Bear in mind that if you use \code{preserve_folder_structure = FALSE},
that the response will be the parent folder object containing imported
files alongside with other files if they exist.}

\item{\code{...}}{Other arguments that can be passed to core \code{api()} function
like 'fields', etc.}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
\code{\link{Import}} object.
}
\subsection{Examples}{
\if{html}{\out{<div class="r example copy">}}
\preformatted{\dontrun{
# x is API response when volume prefix is requested
volume_prefix_object <- VolumePrefix$new(
                    res = x,
                    href = x$href,
                    auth = auth,
                    response = attr(x, "response")
                   )

 # List volume prefix object contents
 volume_prefix_object$import(destination_project = destination_project)
}

}
\if{html}{\out{</div>}}

}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-VolumePrefix-clone"></a>}}
\if{latex}{\out{\hypertarget{method-VolumePrefix-clone}{}}}
\subsection{Method \code{clone()}}{
The objects of this class are cloneable with this method.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{VolumePrefix$clone(deep = FALSE)}\if{html}{\out{</div>}}
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
