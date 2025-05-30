% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/class-file.R
\name{File}
\alias{File}
\title{R6 Class representing a File}
\description{
R6 Class representing a resource for managing files and folders.
}
\examples{

## ------------------------------------------------
## Method `File$print`
## ------------------------------------------------

\dontrun{
# x is API response when file is requested
file_object <- File$new(
                    res = x,
                    href = x$href,
                    auth = auth,
                    response = attr(x, "response")
                   )

 # Print file object
 file_object$print()
}


## ------------------------------------------------
## Method `File$detailed_print`
## ------------------------------------------------

\dontrun{
# x is API response when file is requested
file_object <- File$new(
                    res = x,
                    href = x$href,
                    auth = auth,
                    response = attr(x, "response")
                   )

 # Detailed print of file object
 file_object$detailed_print()
}


## ------------------------------------------------
## Method `File$reload`
## ------------------------------------------------

\dontrun{
# x is API response when file is requested
file_object <- File$new(
                    res = x,
                    href = x$href,
                    auth = auth,
                    response = attr(x, "response")
                   )

 # Reload file object
 file_object$reload()
}


## ------------------------------------------------
## Method `File$update`
## ------------------------------------------------

\dontrun{
# x is API response when file is requested
file_object <- File$new(
                    res = x,
                    href = x$href,
                    auth = auth,
                    response = attr(x, "response")
                   )

 # Update file object
 file_object$update(name = "new_name")
}


## ------------------------------------------------
## Method `File$add_tag`
## ------------------------------------------------

\dontrun{
# x is API response when file is requested
file_object <- File$new(
                    res = x,
                    href = x$href,
                    auth = auth,
                    response = attr(x, "response")
                   )

 # Add new tag to file object
 file_object$add_tag(tags = c("new_tag"))
}


## ------------------------------------------------
## Method `File$copy_to`
## ------------------------------------------------

\dontrun{
# x is API response when file is requested
file_object <- File$new(
                    res = x,
                    href = x$href,
                    auth = auth,
                    response = attr(x, "response")
                   )

 # Copy file object to project
 file_object$copy_to(project = project)
}


## ------------------------------------------------
## Method `File$get_download_url`
## ------------------------------------------------

\dontrun{
# x is API response when file is requested
file_object <- File$new(
                    res = x,
                    href = x$href,
                    auth = auth,
                    response = attr(x, "response")
                   )

 # Get download url for file object
 file_object$get_download_url()
}


## ------------------------------------------------
## Method `File$get_metadata`
## ------------------------------------------------

\dontrun{
# x is API response when file is requested
file_object <- File$new(
                    res = x,
                    href = x$href,
                    auth = auth,
                    response = attr(x, "response")
                   )

 # Get metadata for file object
 file_object$get_metadata()
}


## ------------------------------------------------
## Method `File$set_metadata`
## ------------------------------------------------

\dontrun{
# x is API response when file is requested
file_object <- File$new(
                    res = x,
                    href = x$href,
                    auth = auth,
                    response = attr(x, "response")
                   )

 # Set metadata for file object
 file_object$set_metadata(metadata_fields = list("field_1" = "value_1"))
}


## ------------------------------------------------
## Method `File$move_to_folder`
## ------------------------------------------------

\dontrun{
# x is API response when file is requested
file_object <- File$new(
                    res = x,
                    href = x$href,
                    auth = auth,
                    response = attr(x, "response")
                   )

 # Move file object to a project
 file_object$move_to_folder(parent = "parent-folder-id")
}


## ------------------------------------------------
## Method `File$list_contents`
## ------------------------------------------------

\dontrun{
# x is API response when file is requested
file_object <- File$new(
                    res = x,
                    href = x$href,
                    auth = auth,
                    response = attr(x, "response")
                   )

 # List folder's content
 file_object$list_contents()
}


## ------------------------------------------------
## Method `File$delete`
## ------------------------------------------------

\dontrun{
# x is API response when file is requested
file_object <- File$new(
                    res = x,
                    href = x$href,
                    auth = auth,
                    response = attr(x, "response")
                   )

 # Delete file object
 file_object$delete()
}


## ------------------------------------------------
## Method `File$download`
## ------------------------------------------------

\dontrun{
# x is API response when file is requested
file_object <- File$new(
                    res = x,
                    href = x$href,
                    auth = auth,
                    response = attr(x, "response")
                   )

 # Download file object
 file_object$download(directory_path = ".")
}


## ------------------------------------------------
## Method `File$submit_export`
## ------------------------------------------------

\dontrun{
 # x is API response when file is requested
 file_object <- File$new(
                    res = x,
                    href = x$href,
                    auth = auth,
                    response = attr(x, "response")
                   )

 # Export file object to a volume
 file_object$submit_export(
               destination_volume = volume,
               destination_location = location
             )
}

}
\section{Super class}{
\code{\link[sevenbridges2:Item]{sevenbridges2::Item}} -> \code{File}
}
\section{Public fields}{
\if{html}{\out{<div class="r6-fields">}}
\describe{
\item{\code{URL}}{List of URL endpoints for this resource.}

\item{\code{id}}{File ID.}

\item{\code{name}}{File name.}

\item{\code{size}}{File size.}

\item{\code{project}}{Project ID if any, where file/folder is located.}

\item{\code{created_on}}{Date file/folder was created on.}

\item{\code{modified_on}}{Date file/folder was modified on.}

\item{\code{storage}}{File/folder's storage type.}

\item{\code{origin}}{Task ID if file/folder is produced by some task execution.}

\item{\code{tags}}{List of tags associated with the file.}

\item{\code{metadata}}{List of metadata associated with the file.}

\item{\code{url}}{File download URL.}

\item{\code{parent}}{Parent folder ID.}

\item{\code{type}}{This can be of type \code{file} or \code{folder}.}

\item{\code{secondary_files}}{Secondary files linked to the file, if they
exist.}
}
\if{html}{\out{</div>}}
}
\section{Methods}{
\subsection{Public methods}{
\itemize{
\item \href{#method-File-new}{\code{File$new()}}
\item \href{#method-File-print}{\code{File$print()}}
\item \href{#method-File-detailed_print}{\code{File$detailed_print()}}
\item \href{#method-File-reload}{\code{File$reload()}}
\item \href{#method-File-update}{\code{File$update()}}
\item \href{#method-File-add_tag}{\code{File$add_tag()}}
\item \href{#method-File-copy_to}{\code{File$copy_to()}}
\item \href{#method-File-get_download_url}{\code{File$get_download_url()}}
\item \href{#method-File-get_metadata}{\code{File$get_metadata()}}
\item \href{#method-File-set_metadata}{\code{File$set_metadata()}}
\item \href{#method-File-move_to_folder}{\code{File$move_to_folder()}}
\item \href{#method-File-list_contents}{\code{File$list_contents()}}
\item \href{#method-File-delete}{\code{File$delete()}}
\item \href{#method-File-download}{\code{File$download()}}
\item \href{#method-File-submit_export}{\code{File$submit_export()}}
\item \href{#method-File-clone}{\code{File$clone()}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-File-new"></a>}}
\if{latex}{\out{\hypertarget{method-File-new}{}}}
\subsection{Method \code{new()}}{
Create a new File object.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{File$new(res = NA, ...)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{res}}{Response containing File object information.}

\item{\code{...}}{Other response arguments.}
}
\if{html}{\out{</div>}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-File-print"></a>}}
\if{latex}{\out{\hypertarget{method-File-print}{}}}
\subsection{Method \code{print()}}{
Print method for File class.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{File$print()}\if{html}{\out{</div>}}
}

\subsection{Examples}{
\if{html}{\out{<div class="r example copy">}}
\preformatted{\dontrun{
# x is API response when file is requested
file_object <- File$new(
                    res = x,
                    href = x$href,
                    auth = auth,
                    response = attr(x, "response")
                   )

 # Print file object
 file_object$print()
}

}
\if{html}{\out{</div>}}

}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-File-detailed_print"></a>}}
\if{latex}{\out{\hypertarget{method-File-detailed_print}{}}}
\subsection{Method \code{detailed_print()}}{
Detailed print method for File class.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{File$detailed_print()}\if{html}{\out{</div>}}
}

\subsection{Details}{
The call returns the file's name, its tags, and all of its
metadata. Apart from regular file fields there are some additional
fields:
\itemize{
\item \code{storage} field denotes the type of storage for the file
which can be either PLATFORM or VOLUME depending on where the file is
stored.
\item \code{origin} field denotes the task that produced the file, if it
was created by a task on the Seven Bridges Platform.
\item \code{metadata} field lists the metadata fields and values for the
file.
\item \code{tags} field lists the tags for the file. Learn more about
\href{https://docs.sevenbridges.com/docs/tag-your-files}{tagging your files}
on the Platform.
}
}

\subsection{Examples}{
\if{html}{\out{<div class="r example copy">}}
\preformatted{\dontrun{
# x is API response when file is requested
file_object <- File$new(
                    res = x,
                    href = x$href,
                    auth = auth,
                    response = attr(x, "response")
                   )

 # Detailed print of file object
 file_object$detailed_print()
}

}
\if{html}{\out{</div>}}

}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-File-reload"></a>}}
\if{latex}{\out{\hypertarget{method-File-reload}{}}}
\subsection{Method \code{reload()}}{
Reload File object information.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{File$reload(...)}\if{html}{\out{</div>}}
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
\code{\link{File}} object.
}
\subsection{Examples}{
\if{html}{\out{<div class="r example copy">}}
\preformatted{\dontrun{
# x is API response when file is requested
file_object <- File$new(
                    res = x,
                    href = x$href,
                    auth = auth,
                    response = attr(x, "response")
                   )

 # Reload file object
 file_object$reload()
}

}
\if{html}{\out{</div>}}

}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-File-update"></a>}}
\if{latex}{\out{\hypertarget{method-File-update}{}}}
\subsection{Method \code{update()}}{
Updates the name, the full set of metadata, and tags
for a specified file.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{File$update(name = NULL, metadata = NULL, tags = NULL, ...)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{name}}{The new name of the file.}

\item{\code{metadata}}{The metadata fields and their values that you want to
update. This is a named list of key-value pairs. The keys and values
are strings.}

\item{\code{tags}}{The tags you want to update, represented as unnamed list of
values to add as tags.}

\item{\code{...}}{Other arguments that can be passed to core \code{api()} function
like 'limit', 'offset', 'fields', etc.}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
Updated \code{\link{File}} object.
}
\subsection{Examples}{
\if{html}{\out{<div class="r example copy">}}
\preformatted{\dontrun{
# x is API response when file is requested
file_object <- File$new(
                    res = x,
                    href = x$href,
                    auth = auth,
                    response = attr(x, "response")
                   )

 # Update file object
 file_object$update(name = "new_name")
}

}
\if{html}{\out{</div>}}

}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-File-add_tag"></a>}}
\if{latex}{\out{\hypertarget{method-File-add_tag}{}}}
\subsection{Method \code{add_tag()}}{
This method allows you to tag files on the Platform.
You can tag your files on the Platform with keywords to make it easier
to identify and organize files you’ve imported from public datasets
or copied between projects. \cr
More details on how to use this call can be found
\href{https://docs.sevenbridges.com/reference/add-tags-to-a-file}{here}.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{File$add_tag(tags, overwrite = FALSE, ...)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{tags}}{The tags you want to update, represented as unnamed list of
values to add as tags.}

\item{\code{overwrite}}{Set to \code{TRUE} if you want to overwrite existing tags.
Default: \code{FALSE}.}

\item{\code{...}}{Additional parameters that can be passed to the method.}
}
\if{html}{\out{</div>}}
}
\subsection{Examples}{
\if{html}{\out{<div class="r example copy">}}
\preformatted{\dontrun{
# x is API response when file is requested
file_object <- File$new(
                    res = x,
                    href = x$href,
                    auth = auth,
                    response = attr(x, "response")
                   )

 # Add new tag to file object
 file_object$add_tag(tags = c("new_tag"))
}

}
\if{html}{\out{</div>}}

}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-File-copy_to"></a>}}
\if{latex}{\out{\hypertarget{method-File-copy_to}{}}}
\subsection{Method \code{copy_to()}}{
This call copies the specified file to a new project.
Files retain their metadata when copied, but may be assigned new names
in their target project. To make this call, you should have
\href{https://docs.sevenbridges.com/docs/set-permissions}{copy permission}
within the project you are copying from. \cr Note: If you want to copy
multiple files, the recommended way is to do it in bulk considering the
API rate limit
(\href{https://docs.sevenbridges.com/docs/api-rate-limit}{learn more}).
You can do that using \code{Auth$copy_files()} operation.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{File$copy_to(project, name = NULL, ...)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{project}}{The ID of the project or a Project object where you want
to copy the file to.}

\item{\code{name}}{The new name the file will have in the target project.
If its name will not change, omit this key.}

\item{\code{...}}{Other arguments that can be passed to core \code{api()} function
like 'fields', etc.}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
Copied \code{\link{File}} object.
}
\subsection{Examples}{
\if{html}{\out{<div class="r example copy">}}
\preformatted{\dontrun{
# x is API response when file is requested
file_object <- File$new(
                    res = x,
                    href = x$href,
                    auth = auth,
                    response = attr(x, "response")
                   )

 # Copy file object to project
 file_object$copy_to(project = project)
}

}
\if{html}{\out{</div>}}

}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-File-get_download_url"></a>}}
\if{latex}{\out{\hypertarget{method-File-get_download_url}{}}}
\subsection{Method \code{get_download_url()}}{
This method returns a URL that you can use to download
the specified file.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{File$get_download_url(...)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{...}}{Other arguments that can be passed to core \code{api()} function
like 'fields', etc.}
}
\if{html}{\out{</div>}}
}
\subsection{Examples}{
\if{html}{\out{<div class="r example copy">}}
\preformatted{\dontrun{
# x is API response when file is requested
file_object <- File$new(
                    res = x,
                    href = x$href,
                    auth = auth,
                    response = attr(x, "response")
                   )

 # Get download url for file object
 file_object$get_download_url()
}

}
\if{html}{\out{</div>}}

}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-File-get_metadata"></a>}}
\if{latex}{\out{\hypertarget{method-File-get_metadata}{}}}
\subsection{Method \code{get_metadata()}}{
This call returns the metadata values for the specified
file.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{File$get_metadata(...)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{...}}{Other arguments that can be passed to core \code{api()} function
like 'fields', etc.}
}
\if{html}{\out{</div>}}
}
\subsection{Examples}{
\if{html}{\out{<div class="r example copy">}}
\preformatted{\dontrun{
# x is API response when file is requested
file_object <- File$new(
                    res = x,
                    href = x$href,
                    auth = auth,
                    response = attr(x, "response")
                   )

 # Get metadata for file object
 file_object$get_metadata()
}

}
\if{html}{\out{</div>}}

}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-File-set_metadata"></a>}}
\if{latex}{\out{\hypertarget{method-File-set_metadata}{}}}
\subsection{Method \code{set_metadata()}}{
This call changes the metadata values for the specified
file. \cr
More details about how to modify metadata, you can find in the
\href{https://docs.sevenbridges.com/reference/modify-a-files-metadata}{API documentation}.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{File$set_metadata(metadata_fields, overwrite = FALSE, ...)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{metadata_fields}}{Enter a list of key-value pairs of metadata
fields and metadata values.}

\item{\code{overwrite}}{Set to \code{TRUE} if you want to overwrite existing tags.
Default: \code{FALSE}.}

\item{\code{...}}{Other arguments that can be passed to core \code{api()} function
like 'fields', etc.}
}
\if{html}{\out{</div>}}
}
\subsection{Examples}{
\if{html}{\out{<div class="r example copy">}}
\preformatted{\dontrun{
# x is API response when file is requested
file_object <- File$new(
                    res = x,
                    href = x$href,
                    auth = auth,
                    response = attr(x, "response")
                   )

 # Set metadata for file object
 file_object$set_metadata(metadata_fields = list("field_1" = "value_1"))
}

}
\if{html}{\out{</div>}}

}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-File-move_to_folder"></a>}}
\if{latex}{\out{\hypertarget{method-File-move_to_folder}{}}}
\subsection{Method \code{move_to_folder()}}{
This call moves a file from one folder to another.
Moving of files is only allowed within the same project.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{File$move_to_folder(parent, name = NULL)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{parent}}{The ID of target folder or a File object which must
be of type \code{FOLDER}.}

\item{\code{name}}{Specify a new name for a file in case you want to rename it.
If you want to use the same name, omit this key.}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
Moved \code{\link{File}} object.
}
\subsection{Examples}{
\if{html}{\out{<div class="r example copy">}}
\preformatted{\dontrun{
# x is API response when file is requested
file_object <- File$new(
                    res = x,
                    href = x$href,
                    auth = auth,
                    response = attr(x, "response")
                   )

 # Move file object to a project
 file_object$move_to_folder(parent = "parent-folder-id")
}

}
\if{html}{\out{</div>}}

}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-File-list_contents"></a>}}
\if{latex}{\out{\hypertarget{method-File-list_contents}{}}}
\subsection{Method \code{list_contents()}}{
List folder contents.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{File$list_contents(
  limit = getOption("sevenbridges2")$limit,
  offset = getOption("sevenbridges2")$offset,
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

\item{\code{offset}}{The zero-based starting index in the entire collection
of the first item to return. The default value is \code{0}.
This is a pagination-specific attribute.}

\item{\code{...}}{Other arguments that can be passed to core \code{api()} function
like 'fields', etc.}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
\code{\link{Collection}} of \code{\link{File}} objects.
}
\subsection{Examples}{
\if{html}{\out{<div class="r example copy">}}
\preformatted{\dontrun{
# x is API response when file is requested
file_object <- File$new(
                    res = x,
                    href = x$href,
                    auth = auth,
                    response = attr(x, "response")
                   )

 # List folder's content
 file_object$list_contents()
}

}
\if{html}{\out{</div>}}

}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-File-delete"></a>}}
\if{latex}{\out{\hypertarget{method-File-delete}{}}}
\subsection{Method \code{delete()}}{
Delete method for File objects.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{File$delete()}\if{html}{\out{</div>}}
}

\subsection{Examples}{
\if{html}{\out{<div class="r example copy">}}
\preformatted{\dontrun{
# x is API response when file is requested
file_object <- File$new(
                    res = x,
                    href = x$href,
                    auth = auth,
                    response = attr(x, "response")
                   )

 # Delete file object
 file_object$delete()
}

}
\if{html}{\out{</div>}}

}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-File-download"></a>}}
\if{latex}{\out{\hypertarget{method-File-download}{}}}
\subsection{Method \code{download()}}{
Download method for File objects. It allows downloading a
platform file to your local computer. To specify the destination for
your download, you should provide the path to the destination directory
as \code{directory_path} parameter.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{File$download(
  directory_path,
  filename = self$name,
  method = "curl",
  retry_count = getOption("sevenbridges2")$default_retry_count,
  retry_timeout = getOption("sevenbridges2")$default_retry_timeout
)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{directory_path}}{Path to the destination directory of a new file.}

\item{\code{filename}}{Full name for the new file, including its extension. By
default, the name field of File object will be used.}

\item{\code{method}}{Method to be used for downloading files. By default, this
parameter is set to \code{curl}.}

\item{\code{retry_count}}{Number of retries if error occurs during download.}

\item{\code{retry_timeout}}{Number of seconds between two retries.}
}
\if{html}{\out{</div>}}
}
\subsection{Examples}{
\if{html}{\out{<div class="r example copy">}}
\preformatted{\dontrun{
# x is API response when file is requested
file_object <- File$new(
                    res = x,
                    href = x$href,
                    auth = auth,
                    response = attr(x, "response")
                   )

 # Download file object
 file_object$download(directory_path = ".")
}

}
\if{html}{\out{</div>}}

}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-File-submit_export"></a>}}
\if{latex}{\out{\hypertarget{method-File-submit_export}{}}}
\subsection{Method \code{submit_export()}}{
This call lets you queue a job to export this file from a
project on the Platform into a volume. The file selected for export
must not be a public file or an alias. Aliases are objects stored in
your cloud storage bucket which have been made available on the
Platform.
The volume you are exporting to must be configured for read-write
access. To do this, set the \code{access_mode} parameter to \code{RW} when
creating or modifying a volume.  \cr

Essentially, the call writes to your cloud storage bucket via the
volume. If this call is successful, the original project file will
become an alias to the newly exported object on the volume. The source
file will be deleted from the Platform and, if no more copies of this
file exist, it will no longer count towards your total storage price
on the Platform.  \cr
In summary, once you export a file from the Platform to a volume,
it is no longer part of the storage on the Platform and
cannot be exported again. \cr

Read more about this operation in our documentation
\href{https://docs.sevenbridges.com/reference/start-an-export-job-v2}{here}.
\cr
If you want to export multiple files, the recommended way is to do it
in bulk considering the API rate limit
(\href{https://docs.sevenbridges.com/docs/api-rate-limit}{learn more})
(bulk operations will be implemented in next releases).
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{File$submit_export(
  destination_volume,
  destination_location,
  overwrite = FALSE,
  copy_only = FALSE,
  properties = NULL,
  ...
)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{destination_volume}}{Volume id or Volume object you want to
export files into. Required.}

\item{\code{destination_location}}{Volume-specific location to which the
file will be exported.
This location should be recognizable to the underlying cloud service as
a valid key or path to a new file. Please note that if this volume has
been configured with a prefix parameter, the value of prefix will be
prepended to location before attempting to create the file on the
volume.

If you would like to export the file into some folder on the volume,
please add folder name as prefix before file name in form
\verb{<folder-name>/<file-name>}.}

\item{\code{overwrite}}{Set to \code{TRUE} if you want to overwrite the item that
already exists at the destination. Default: \code{FALSE}.}

\item{\code{copy_only}}{If \code{TRUE}, file will be copied to a volume but
source file will remain on the Platform.}

\item{\code{properties}}{Named list of additional volume properties, like:
\itemize{
\item \code{sse_algorithm} - S3 server-side encryption to use when
exporting to this bucket. Supported values:
\code{AES256} (SSE-S3 encryption), \code{aws:kms}, \code{null}
(no server-side encryption). Default: \code{AES256}.
\item \code{sse_aws_kms_key_Id}: Applies to type: \code{s3}.
If AWS KMS encryption is used, this should be set to the required
KMS key. If not set and \code{aws:kms} is set as \code{sse_algorithm},
default KMS key is used.
\item \code{aws_canned_acl}: S3 canned ACL to apply on the object
on during export. Supported values: any one of
\href{https://docs.aws.amazon.com/AmazonS3/latest/userguide/acl-overview.html#canned-acl}{S3 canned ACLs};
\code{null} (do not apply canned ACLs). Default: \code{null}.
}}

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
 # x is API response when file is requested
 file_object <- File$new(
                    res = x,
                    href = x$href,
                    auth = auth,
                    response = attr(x, "response")
                   )

 # Export file object to a volume
 file_object$submit_export(
               destination_volume = volume,
               destination_location = location
             )
}

}
\if{html}{\out{</div>}}

}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-File-clone"></a>}}
\if{latex}{\out{\hypertarget{method-File-clone}{}}}
\subsection{Method \code{clone()}}{
The objects of this class are cloneable with this method.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{File$clone(deep = FALSE)}\if{html}{\out{</div>}}
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
