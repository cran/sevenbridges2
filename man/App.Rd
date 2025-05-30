% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/class-app.R
\name{App}
\alias{App}
\title{R6 Class representing an app}
\description{
R6 Class representing a resource for managing apps.
}
\examples{

## ------------------------------------------------
## Method `App$print`
## ------------------------------------------------

\dontrun{
 # x is API response when app is requested
 app_object <- App$new(
   res = x,
   href = x$href,
   auth = auth,
   response = attr(x, "response")
 )
 app_object$print()
}

## ------------------------------------------------
## Method `App$reload`
## ------------------------------------------------

\dontrun{
 # x is API response when app is requested
 app_object <- App$new(
   res = x,
   href = x$href,
   auth = auth,
   response = attr(x, "response")
 )
 app_object$reload()
}

## ------------------------------------------------
## Method `App$copy`
## ------------------------------------------------

\dontrun{
 # x is API response when app is requested
 app_object <- App$new(
   res = x,
   href = x$href,
   auth = auth,
   response = attr(x, "response")
 )
 app_object$copy(project)
}


## ------------------------------------------------
## Method `App$get_revision`
## ------------------------------------------------

\dontrun{
 # x is API response when app is requested
 app_object <- App$new(
   res = x,
   href = x$href,
   auth = auth,
   response = attr(x, "response")
 )
 app_object$get_revision()
}


## ------------------------------------------------
## Method `App$create_revision`
## ------------------------------------------------

\dontrun{
 # x is API response when app is requested
 app_object <- App$new(
   res = x,
   href = x$href,
   auth = auth,
   response = attr(x, "response")
 )
 # Create App object using raw CWL
 app_object$create_revision(raw)
}


## ------------------------------------------------
## Method `App$sync`
## ------------------------------------------------

\dontrun{
 # x is API response when app is requested
 app_object <- App$new(
   res = x,
   href = x$href,
   auth = auth,
   response = attr(x, "response")
 )

  app_object$sync()
}


## ------------------------------------------------
## Method `App$create_task`
## ------------------------------------------------

\dontrun{
 # x is API response when app is requested
 app_object <- App$new(
   res = x,
   href = x$href,
   auth = auth,
   response = attr(x, "response")
 )
 # Create a DRAFT task
 app_object$create_task(project = project)
}

}
\section{Super class}{
\code{\link[sevenbridges2:Item]{sevenbridges2::Item}} -> \code{App}
}
\section{Public fields}{
\if{html}{\out{<div class="r6-fields">}}
\describe{
\item{\code{URL}}{List of URL endpoints for this resource.}

\item{\code{id}}{Character used as an app ID - short app name.}

\item{\code{project}}{Project ID if any, when returned by an API call.}

\item{\code{name}}{App name.}

\item{\code{revision}}{App's revision number.}

\item{\code{copy_of}}{The original application of which this is a copy.}

\item{\code{latest_revision}}{App's latest revision number.}

\item{\code{raw}}{App's raw CWL (JSON or YAML).}
}
\if{html}{\out{</div>}}
}
\section{Methods}{
\subsection{Public methods}{
\itemize{
\item \href{#method-App-new}{\code{App$new()}}
\item \href{#method-App-print}{\code{App$print()}}
\item \href{#method-App-reload}{\code{App$reload()}}
\item \href{#method-App-copy}{\code{App$copy()}}
\item \href{#method-App-get_revision}{\code{App$get_revision()}}
\item \href{#method-App-create_revision}{\code{App$create_revision()}}
\item \href{#method-App-sync}{\code{App$sync()}}
\item \href{#method-App-input_matrix}{\code{App$input_matrix()}}
\item \href{#method-App-output_matrix}{\code{App$output_matrix()}}
\item \href{#method-App-create_task}{\code{App$create_task()}}
\item \href{#method-App-clone}{\code{App$clone()}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-App-new"></a>}}
\if{latex}{\out{\hypertarget{method-App-new}{}}}
\subsection{Method \code{new()}}{
Create a new App object.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{App$new(res = NA, ...)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{res}}{Response containing App object information.}

\item{\code{...}}{Other response arguments.}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
A new \code{App} object.
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-App-print"></a>}}
\if{latex}{\out{\hypertarget{method-App-print}{}}}
\subsection{Method \code{print()}}{
Print method for App class.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{App$print()}\if{html}{\out{</div>}}
}

\subsection{Examples}{
\if{html}{\out{<div class="r example copy">}}
\preformatted{\dontrun{
 # x is API response when app is requested
 app_object <- App$new(
   res = x,
   href = x$href,
   auth = auth,
   response = attr(x, "response")
 )
 app_object$print()
}
}
\if{html}{\out{</div>}}

}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-App-reload"></a>}}
\if{latex}{\out{\hypertarget{method-App-reload}{}}}
\subsection{Method \code{reload()}}{
Reload App object information.
Suitable also for loading raw CWL in the 'raw' field, if it's not
already populated.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{App$reload(...)}\if{html}{\out{</div>}}
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
\code{\link{App}} object.
}
\subsection{Examples}{
\if{html}{\out{<div class="r example copy">}}
\preformatted{\dontrun{
 # x is API response when app is requested
 app_object <- App$new(
   res = x,
   href = x$href,
   auth = auth,
   response = attr(x, "response")
 )
 app_object$reload()
}
}
\if{html}{\out{</div>}}

}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-App-copy"></a>}}
\if{latex}{\out{\hypertarget{method-App-copy}{}}}
\subsection{Method \code{copy()}}{
A method that copies the current app to the
specified project.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{App$copy(project, name = NULL, strategy = "clone", use_revision = FALSE, ...)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{project}}{Project object or project ID. If you opt for the latter,
remember that the project ID should be specified in
\verb{<project_owner>/<project-name>} format, e.g. \cr
\code{rfranklin/my-project}, or as \verb{<division>/<project-name>}
depending on the account \cr type.}

\item{\code{name}}{The new name for the app in the target project (optional).}

\item{\code{strategy}}{The method for copying the app. Supported strategies:
\itemize{
\item \code{clone} - copy all revisions; get updates from the same app as
the copied app (default)
\item \code{direct}: copy latest revision; get updates from the copied app
\item \code{clone_direct}: copy all revisions; get updates from the copied
app
\item \code{transient}: copy latest revision; get updates from the same
app as the copied app.
}}

\item{\code{use_revision}}{Parameter specifying which app's revision should be
copied. If set to \code{FALSE} (default), the latest revision of the app
will be copied.}

\item{\code{...}}{Other arguments that can be passed to core \code{api()} function
like 'fields', etc.}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
Copied \code{\link{App}} object.
}
\subsection{Examples}{
\if{html}{\out{<div class="r example copy">}}
\preformatted{\dontrun{
 # x is API response when app is requested
 app_object <- App$new(
   res = x,
   href = x$href,
   auth = auth,
   response = attr(x, "response")
 )
 app_object$copy(project)
}

}
\if{html}{\out{</div>}}

}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-App-get_revision"></a>}}
\if{latex}{\out{\hypertarget{method-App-get_revision}{}}}
\subsection{Method \code{get_revision()}}{
Get app's revision.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{App$get_revision(revision = self$revision, in_place = FALSE, ...)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{revision}}{Revision of the app.}

\item{\code{in_place}}{If \code{TRUE}, replace current app object with new for
specified app revision.}

\item{\code{...}}{Other arguments that can be passed to core \code{api()} function
like 'fields', etc.}
}
\if{html}{\out{</div>}}
}
\subsection{Details}{
This call allows you to obtain a particular revision of an
app, which is not necessarily the most recent version.
}

\subsection{Returns}{
\code{\link{App}} object.
}
\subsection{Examples}{
\if{html}{\out{<div class="r example copy">}}
\preformatted{\dontrun{
 # x is API response when app is requested
 app_object <- App$new(
   res = x,
   href = x$href,
   auth = auth,
   response = attr(x, "response")
 )
 app_object$get_revision()
}

}
\if{html}{\out{</div>}}

}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-App-create_revision"></a>}}
\if{latex}{\out{\hypertarget{method-App-create_revision}{}}}
\subsection{Method \code{create_revision()}}{
Create a new app revision.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{App$create_revision(
  raw = NULL,
  from_path = NULL,
  raw_format = c("JSON", "YAML"),
  in_place = FALSE,
  ...
)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{raw}}{A list containing a raw CWL for the app revision you are
about to create. To generate such a list, you might want to load some
existing JSON / YAML file. In case that your CWL file is in JSON
format, please use the \code{fromJSON} function from the \code{jsonlite} package
to minimize potential problems with parsing the JSON file. If you want
to load a CWL file in YAML format, it is highly recommended to use the
\code{read_yaml} function from the \code{yaml} package. Keep in mind that this
parameter should not be used together with the \code{file_path} parameter.}

\item{\code{from_path}}{A path to a file containing the raw CWL for the app
(JSON or YAML). This parameter should not be used together with the
\code{raw} parameter.}

\item{\code{raw_format}}{The type of format used (JSON or YAML).}

\item{\code{in_place}}{If \code{TRUE}, replace current app object with newly
created revision.}

\item{\code{...}}{Other arguments that can be passed to core \code{api()} function
like 'fields', etc.}
}
\if{html}{\out{</div>}}
}
\subsection{Details}{
This call creates a new revision for an existing app. It adds a new CWL
app description, and stores it as the named revision for the specified
app. The revision number must not already exist and should follow the
sequence of previously created revisions. \cr \cr
More documentation about how to create the app via API can be found
\href{https://docs.sevenbridges.com/reference/add-an-app-using-raw-cwl}{here}.
}

\subsection{Returns}{
\code{\link{App}} object.
}
\subsection{Examples}{
\if{html}{\out{<div class="r example copy">}}
\preformatted{\dontrun{
 # x is API response when app is requested
 app_object <- App$new(
   res = x,
   href = x$href,
   auth = auth,
   response = attr(x, "response")
 )
 # Create App object using raw CWL
 app_object$create_revision(raw)
}

}
\if{html}{\out{</div>}}

}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-App-sync"></a>}}
\if{latex}{\out{\hypertarget{method-App-sync}{}}}
\subsection{Method \code{sync()}}{
Synchronize a copied app with its parent app.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{App$sync(...)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{...}}{Other arguments that can be passed to core \code{api()} function
like 'fields', etc.}
}
\if{html}{\out{</div>}}
}
\subsection{Details}{
This call synchronizes a copied app with the source app from which it
has been copied.
}

\subsection{Returns}{
\code{\link{App}} object.
}
\subsection{Examples}{
\if{html}{\out{<div class="r example copy">}}
\preformatted{\dontrun{
 # x is API response when app is requested
 app_object <- App$new(
   res = x,
   href = x$href,
   auth = auth,
   response = attr(x, "response")
 )

  app_object$sync()
}

}
\if{html}{\out{</div>}}

}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-App-input_matrix"></a>}}
\if{latex}{\out{\hypertarget{method-App-input_matrix}{}}}
\subsection{Method \code{input_matrix()}}{
Get an input matrix for the app, listing expected inputs
(required or optional) along with their types, descriptions, etc.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{App$input_matrix()}\if{html}{\out{</div>}}
}

\subsection{Returns}{
Data frame.
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-App-output_matrix"></a>}}
\if{latex}{\out{\hypertarget{method-App-output_matrix}{}}}
\subsection{Method \code{output_matrix()}}{
Get an output matrix for the app, listing expected outputs
of tasks that run this app, along with their types, descriptions, etc.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{App$output_matrix()}\if{html}{\out{</div>}}
}

\subsection{Returns}{
Data frame.
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-App-create_task"></a>}}
\if{latex}{\out{\hypertarget{method-App-create_task}{}}}
\subsection{Method \code{create_task()}}{
This call creates a new task. You can create either a
single task or a batch task by using the app's default batching,
override batching, or disable batching completely. A parent task is a
task that specifies criteria by which to batch its inputs into a series
of further sub-tasks, called child tasks. The documentation on
\href{https://docs.sevenbridges.com/docs/about-batch-analyses}{batching tasks}
for more details on batching criteria.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{App$create_task(
  project,
  revision = NULL,
  name = NULL,
  description = NULL,
  execution_settings = NULL,
  inputs = NULL,
  output_location = NULL,
  batch = NULL,
  batch_input = NULL,
  batch_by = NULL,
  use_interruptible_instances = NULL,
  action = NULL,
  ...
)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{project}}{The ID string of a project or a Project object where you
want to create the task in.}

\item{\code{revision}}{The app
\href{https://docs.sevenbridges.com/docs/app-versions}{revision (version)}
number.}

\item{\code{name}}{The name of the task.}

\item{\code{description}}{An optional description of the task.}

\item{\code{execution_settings}}{Named list with detailed task execution
parameters. Detailed task execution parameters:
\itemize{
\item \code{instance_type}: Possible value is the specific instance type,
e.g. \code{"instance_type" = "c4.2xlarge;ebs-gp2;2000"};
\item \code{max_parallel_instances}: Maximum number of instances
running at the same time. Takes any integer value equal to or
greater than 1, e.g. \code{"max_parallel_instances" = 2.};
\item \code{use_memoization}: Set to \code{FALSE} by default. Set to \code{TRUE}
to enable
\href{https://docs.sevenbridges.com/docs/about-memoization}{memoization};
\item \code{use_elastic_disk}: Set to \code{TRUE} to enable
\href{https://docs.sevenbridges.com/page/elastic-disk}{Elastic Disk}.
}

Here is an example:

\if{html}{\out{<div class="sourceCode r">}}\preformatted{execution_settings <- list(
  "instance_type" = "c4.2xlarge;ebs-gp2;2000",
  "max_parallel_instances" = 2,
  "use_memoization" = TRUE,
  "use_elastic_disk" = TRUE
  )
}\if{html}{\out{</div>}}}

\item{\code{inputs}}{List of objects. See the section on
\href{https://docs.sevenbridges.com/docs/the-api#section-inputs}{specifying task inputs}
for information on creating task input objects. Here is an example with
various input types:

\if{html}{\out{<div class="sourceCode r">}}\preformatted{inputs <- list(
  "input_file"= "<file_id/file_object>",
  "input_directory" = "<folder_id/folder_object>",
  "input_array_string" = list("<string_elem_1>", "<string_elem_2>"),
  "input_boolean" = TRUE,
  "input_double" = 54.6,
  "input_enum" = "enum_1",
  "input_float" = 11.2,
  "input_integer" = "asdf",
  "input_long" = 4212,
  "input_string" = "test_string",
  "input_record" = list(
    "input_record_field_file" = "<file_id/file_object>",
    "input_record_field_integer" = 42
   )
  )
}\if{html}{\out{</div>}}}

\item{\code{output_location}}{The output location list allows you to
define the exact location where your task outputs will be stored.
The location can either be defined for the entire project using the
main_location parameter, or individually per each output node, by
setting the nodes_override parameter to true and defining individual
output node locations within nodes_location.
See below for more details.
\itemize{
\item \code{main_location} - Defines the output location for all
output nodes in the task. Can be a string path within the project
in which the task is created, for example \cr
\verb{/Analysis/<task_id>_<task_name>/}
or a path on an attached volume, \cr such as
\verb{volumes://volume_name/<project_id>/html}.
Parts of the path enclosed in angle brackets <> are tokens that are
dynamically replaced with corresponding values during task
execution.
\item \code{main_location_alias}: The string location (path) in the
project that will point to the actual location where the outputs
are stored. Used if main_location is defined as a volume path
(starting with volumes://), to provide an easy way of accessing
output data directly from project files.
\item \code{nodes_override}: Enables defining of output locations
for output nodes individually through nodes_location (see below).
Set to \code{TRUE} to be able to define individual locations per output
node. Default: \code{FALSE}.
Even if nodes_override is set to \code{TRUE}, it is not necessary to
define output locations for each of the output nodes individually.
Data from those output nodes that don't have their locations
explicitly defined through nodes_location is either placed in
main_location (if defined) or at the project files root if a main
output location is not defined for the task.
\item \code{nodes_location}: List of output paths for individual
task output nodes in the following format for each output node: \cr
\verb{<output-node-id> = list(} \cr
\verb{"output_location" = "<output-path>",} \cr
\code{"output_location_alias" = "<alias-path>"} \cr
\verb{)} \cr
Example:

\if{html}{\out{<div class="sourceCode r">}}\preformatted{b64html = list(
 "output_location" = "volumes://outputs/tasks/mar-19",
 "output_location_alias" = "/rfranklin/tasks/picard"
)
}\if{html}{\out{</div>}}

\if{html}{\out{<div class="sourceCode">}}\preformatted{ In the example above, b64html is the ID of the output node for
 which you want to define the output location, while the parameters
 are defined as follows:
}\if{html}{\out{</div>}}

\itemize{
\item \code{output_location} - Can be a path within the project in which
the task is created, for example \cr
\verb{/Analysis/<task_id>_<task_name>/}
or a path on an attached volume, \cr such as
\verb{volumes://volume_name/<project_id>/html}. Also accepts tokens.
\item \code{output_location_alias} - The location (path) in the project
that will point to the exact location where the output is stored.
Used if output_location is defined as a volume path
(starting with volumes://).
}
}}

\item{\code{batch}}{This is set to \code{FALSE} by default. Set to \code{TRUE} to
create a batch task and specify the \code{batch_input} and \code{batch-by}
criteria as described below.}

\item{\code{batch_input}}{The ID of the input on which you wish to batch.
You would typically batch on the input consisting of a list of files.
If this parameter is omitted, the default batching criteria defined for
the app will be used.}

\item{\code{batch_by}}{Batching criteria in form of list. For example:

\if{html}{\out{<div class="sourceCode r">}}\preformatted{batch_by = list(
  type = "CRITERIA",
  criteria = list("metadata.condition")
)
}\if{html}{\out{</div>}}}

\item{\code{use_interruptible_instances}}{This field can be \code{TRUE} or \code{FALSE}.
Set this field to \code{TRUE} to allow the use of
\href{https://docs.sevenbridges.com/docs/about-spot-instances}{spot instances}.}

\item{\code{action}}{If set to \code{run}, the task will be run immediately upon
creation.}

\item{\code{...}}{Other arguments that can be passed to core \code{api()} function
like 'fields', etc.}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
\code{\link{Task}} object.
}
\subsection{Examples}{
\if{html}{\out{<div class="r example copy">}}
\preformatted{\dontrun{
 # x is API response when app is requested
 app_object <- App$new(
   res = x,
   href = x$href,
   auth = auth,
   response = attr(x, "response")
 )
 # Create a DRAFT task
 app_object$create_task(project = project)
}

}
\if{html}{\out{</div>}}

}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-App-clone"></a>}}
\if{latex}{\out{\hypertarget{method-App-clone}{}}}
\subsection{Method \code{clone()}}{
The objects of this class are cloneable with this method.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{App$clone(deep = FALSE)}\if{html}{\out{</div>}}
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
