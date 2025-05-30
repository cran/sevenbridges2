# nolint start
#' @title R6 Class representing the apps endpoint
#'
#' @description
#' R6 Class representing the apps resource endpoint.
#'
#' @importFrom R6 R6Class
#'
#' @export
Apps <- R6::R6Class(
  "Apps",
  # nolint end
  inherit = Resource,
  portable = FALSE,
  public = list(
    #' @field URL List of URL endpoints for this resource.
    URL = list(
      "query" = "apps",
      "get" = "apps/{id}",
      "get_revision" = "apps/{id}/{revision}",
      "create_revision" = "apps/{id}/{revision}/raw",
      "copy" = "apps/{id}/actions/copy",
      "sync" = "apps/{id}/actions/sync",
      "raw" = "apps/{id}/raw"
    ),

    # Initialize Apps object --------------------------------------------------
    #' @description Create a new Apps resource object.
    #'
    #' @param ... Other response arguments.
    initialize = function(...) {
      # Initialize Resource class
      super$initialize(...)
    },

    # List apps --------------------------------------------------------------
    #' @description This call lists all the apps available to you.
    #'
    #' @param project Project ID string in the form
    #'  `<project_owner>/<project_short_name>` or \cr
    #'  `<division_name>/<project_short_name>` or Project object, \cr
    #'  to restrict the results to apps from that project only.
    #' @param visibility Set this to `public` to see all public apps on
    #'  the Seven Bridges Platform.
    #' @param query_terms A list of search terms used to filter apps based on
    #'  their details. Each term is case-insensitive and can relate to the
    #'  app's name, label, toolkit, toolkit version, category, tagline, or
    #'  description.
    #'  You can provide a single term (e.g., `list("Compressor")`) or multiple
    #'  terms (e.g., `list("Expression", "Abundance")`) to search for apps
    #'  that match all the specified terms. If a term matches any part of the
    #'  app's details, the app will be included in the results.
    #'  Search terms can also include phrases
    #'  (e.g., `list("Abundance estimates input")`), which will search for
    #'  exact matches within app descriptions or other fields.
    #' @param id Use this parameter to query apps based on their ID.
    #' @param limit The maximum number of collection items to return
    #'  for a single request. Minimum value is `1`.
    #'  The maximum value is `100` and the default value is `50`.
    #'  This is a pagination-specific attribute.
    #' @param offset The zero-based starting index in the entire collection
    #'  of the first item to return. The default value is `0`.
    #'  This is a pagination-specific attribute.
    #' @param fields Selector specifying a subset of fields to include in the
    #'  response. For querying apps, it is set to return all fields except
    #'  'raw' which stores CWL as a list. Be cautious when requesting all
    #'  fields, as this API request may take a long time to execute.
    #' @param ... Other arguments that can be passed to core `api()` function.
    #'
    #' @importFrom checkmate assert_list assert_string
    #' @importFrom utils URLencode
    #'
    #' @examples
    #' \dontrun{
    #'  apps_object <- Apps$new(
    #'    auth = auth
    #'  )
    #'
    #'  # List public apps
    #'  apps_object$query(visibility = "public")
    #' }
    #'
    #' @return \code{\link{Collection}} containing \code{\link{App}} objects.
    query = function(project = NULL,
                     visibility = c("private", "public"),
                     query_terms = NULL,
                     id = NULL,
                     limit = getOption("sevenbridges2")$limit,
                     offset = getOption("sevenbridges2")$offset,
                     fields = "!raw",
                     ...) {
      if (!is_missing(project)) {
        project <-
          check_and_transform_id(project, class_name = "Project")
      }

      visibility <- match.arg(visibility)

      checkmate::assert_list(query_terms,
        types = c("character"),
        null.ok = TRUE
      )

      checkmate::assert_string(id, null.ok = TRUE)

      # Collapse query terms to a URL-encoded string with space between values
      if (!is.null(query_terms)) {
        query_terms <- paste(
          lapply(query_terms, utils::URLencode,
            reserved = TRUE
          ),
          collapse = "%20"
        )
      }

      # nocov start
      res <- super$query(
        path = self$URL[["query"]],
        project = project,
        visibility = visibility,
        q = query_terms,
        id = id,
        offset = offset,
        limit = limit,
        fields = fields,
        ...
      )

      res$items <- asAppList(res, auth = self$auth)

      return(asCollection(res, auth = self$auth)) # nocov end
    },

    # Get app ----------------------------------------------------------------
    #' @description This call returns information about the specified app.
    #'  The app must be in a project you can access. It could be an app
    #'  uploaded to the Seven Bridges Platform by a project member or a public
    #'  app copied into the project. \cr
    #'  You can find more details about this operation in our
    # nolint start
    #'  [API documentation](https://docs.sevenbridges.com/reference/get-details-of-an-app).
    # nolint end
    #'
    #' @param id The full `<project_id>/<app_short_name>`
    #'  path for this API call is known as App ID. You can also get the App ID
    #'  for an app by making the call to list all apps available to you.
    #' @param revision The number of the app revision you want to get.
    #' @param ... Other arguments that can be passed to core `api()` function
    #'  like 'fields', etc.
    #'
    #' @importFrom checkmate assert_int
    #' @importFrom rlang abort
    #'
    #' @examples
    #' \dontrun{
    #'  apps_object <- Apps$new(
    #'    auth = auth
    #'  )
    #'
    #'  # Get app object
    #'  apps_object$get(id = "<some_id>")
    #' }
    #'
    #' @return \code{\link{App}} object.
    get = function(id, revision = NULL, ...) {
      if (is_missing(id)) {
        rlang::abort("App ID must be provided!")
      }

      checkmate::assert_string(id)
      checkmate::assert_int(revision, null.ok = TRUE, lower = 0)
      # nocov start
      id <- paste(c(id, revision), collapse = "/")
      res <- super$get(
        cls = self,
        id = id,
        ...
      )

      return(asApp(res, auth = self$auth)) # nocov end
    },

    # Copy app ----------------------------------------------------------------
    #' @description This call copies the specified app to the specified
    #'  project. The app must be in a project you can access. It could be an
    #'  app uploaded to the Seven Bridges Platform by a project member or a
    #'  public app copied into the project.
    #'
    #' @param app App object or the short name of the app you are copying.
    #'  Optionally, to copy a specific revision of the app, use the
    #'  `<app_short_name>/<revision_number>` format, for example
    #'  `rfranklin/my-project/bamtools-index-2-4-0/1`
    #' @param project The Project object or project ID you want to copy the app
    #'  to.
    #' @param name The new name the app will have in the target project.
    #'  If its name will not change, omit this key.
    #' @param strategy The method for copying the app. Can be one of:
    #'  \itemize{
    #'    \item `clone` : copy all revisions; get updates from the same app
    #'      as the copied app (default);
    #'    \item `direct`: copy latest revision; get updates from the copied
    #'      app;
    #'    \item `clone_direct`: copy all revisions; get updates from the
    #'      copied app;
    #'    \item `transient`: copy latest revision; get updates from the same
    #'      app as the copied app.
    #'  }
    #'  Read more about the strategies
    # nolint start
    #'  [here](https://docs.sevenbridges.com/reference/copy-an-app#methods-for-copying-an-app).
    # nolint end
    #' @param ... Other arguments that can be passed to core `api()` function
    #'  like 'fields', etc.
    #'
    #' @importFrom checkmate assert_string
    #' @importFrom rlang abort
    #' @importFrom glue glue
    #'
    #' @examples
    #' \dontrun{
    #'  apps_object <- Apps$new(
    #'    auth = auth
    #'  )
    #'  # Copy app object to a project
    #'  apps_object$copy(app = app, project = project)
    #' }
    #'
    #' @return Copied \code{\link{App}} object.
    copy = function(app,
                    project,
                    name = NULL,
                    strategy = c("clone", "direct", "clone_direct", "transient"), # nolint
                    ...) {
      if (is_missing(app)) {
        rlang::abort("App parameter must be provided!")
      }

      if (is_missing(project)) {
        rlang::abort("Project parameter must be provided!")
      }

      id <- check_and_transform_id(app, class_name = "App")

      project_id <-
        check_and_transform_id(project, class_name = "Project")

      strategy <- match.arg(strategy)

      checkmate::assert_string(name, null.ok = TRUE)
      # nocov start
      body <- list(
        project = project_id,
        name = name,
        strategy = strategy
      )

      path <- glue::glue(self$URL[["copy"]])

      res <- self$auth$api(
        path = path,
        method = "POST",
        body = body,
        ...
      )

      return(asApp(res, auth = self$auth)) # nocov end
    },

    # Create app using CWL ---------------------------------------------------
    #' @description This call allows you to add an app using raw CWL.
    #'
    #' @param raw The body of the request should be a CWL app description saved
    #'  as a `JSON` or `YAML` file. For a template of this description, try
    #'  making the call to get raw CWL for an app about an app already in one
    #'  of your projects. Shouldn't be used together with `from_path`
    #'  parameter.
    #' @param from_path File containing CWL app description. Shouldn't be used
    #'  together with raw parameter.
    #' @param project String project ID or Project object in which you want to
    #'  store the app.
    #' @param name A short name for the app (without any non-alphanumeric
    #'  characters or spaces)
    #' @param raw_format The type of format used (`JSON` or `YAML`).
    #' @param ... Other arguments that can be passed to core `api()` function
    #'  like 'fields', etc.
    #'
    #' @importFrom checkmate assert_string
    #' @importFrom jsonlite validate fromJSON
    #' @importFrom rlang abort
    #' @importFrom readr read_file
    #'
    #' @examples
    #' \dontrun{
    #'  apps_object <- Apps$new(
    #'    auth = auth
    #'  )
    #'
    #'  # Create new app object
    #'  apps_object$create(
    #'   raw = raw,
    #'   project = project,
    #'   name = name,
    #'   raw_format = "YAML"
    #'  )
    #' }
    #'
    #' @return \code{\link{App}} object.
    create = function(raw = NULL,
                      from_path = NULL,
                      project,
                      name,
                      raw_format = c("JSON", "YAML"),
                      ...) {
      if (is_missing(raw) && is_missing(from_path)) {
        rlang::abort("App raw body OR file path must be provided!")
      }

      if (!is.null(raw) && !is.null(from_path)) {
        rlang::abort("Either raw body OR file path should be provided!")
      }

      if (is_missing(project)) {
        rlang::abort("Project parameter must be provided!")
      }

      if (is_missing(name)) {
        rlang::abort("Name parameter must be provided!")
      }

      raw_format <- match.arg(raw_format)

      checkmate::assert_string(name, null.ok = FALSE)

      if (!is_missing(raw)) {
        # Check if raw parameter is a list
        checkmate::assert_list(raw)
        body <- raw
      }

      if (!is_missing(from_path)) {
        checkmate::assert_file_exists(x = from_path, .var.name = "from_path")
        raw_body <- readr::read_file(file = from_path)

        if (raw_format == "JSON") {
          jsonlite::validate(raw_body)
          body <-
            jsonlite::fromJSON(raw_body, simplifyDataFrame = FALSE)
        }

        if (raw_format == "YAML") {
          body <- yaml::yaml.load(raw_body)
        }
      }

      project_id <-
        check_and_transform_id(project, class_name = "Project")
      # nocov start
      id <- glue::glue("{project_id}/{name}")
      path <- glue::glue(self$URL[["raw"]])

      res <- self$auth$api(
        path = path,
        method = "POST",
        body = body,
        ...
      )

      app <- self$get(res$`sbg:id`)

      return(app) # nocov end
    }
  )
)
