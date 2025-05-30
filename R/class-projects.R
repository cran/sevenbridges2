# nolint start
#' @title R6 Class representing projects endpoints.
#'
#' @description
#' R6 Class representing a Projects resource.
#'
#' @importFrom R6 R6Class
#'
#' @export
Projects <- R6::R6Class(
  # nolint end
  "Projects",
  inherit = Resource,
  portable = FALSE,
  public = list(
    #' @field URL List of URL endpoints for this resource.
    URL = list(
      "query" = "projects",
      "get" = "projects/{id}",
      "create" = "projects",
      "delete" = "projects"
    ),

    # Initialize Projects object ----------------------------------------------
    #' @description Create new Projects resource object.
    #'
    #' @param ... Other response arguments.
    initialize = function(...) {
      # Initialize Resource class
      super$initialize(...)
    },

    # List projects -----------------------------------------------------------
    #' @description A method to list all projects available to a particular
    #'  user. If the username is not provided, all projects available to the
    #'  currently authenticated user will be listed.
    #'  Otherwise, projects will be listed for the user whose username
    #'  is provided.
    #'  Please keep in mind that this way you will only be able to list
    #'  projects you are a member of. \cr \cr
    #'  More details on how to query projects, you can find in our
    # nolint start
    #'  [documentation](https://docs.sevenbridges.com/reference/list-all-your-projects).
    # nolint end
    #'
    #' @param name Project's name.
    #' @param owner The username of the owner whose projects you want to query.
    #' @param tags A list of project tags used to filter the query results.
    #'  Each tag should be provided as a string within the list, and tags may
    #'  include spaces. For example, both "my_tag_1" and "tag with spaces" are
    #'  valid tag values. The method will return only projects that have all
    #'  the specified tags.
    #' @param limit The maximum number of collection items to return
    #'  for a single request. Minimum value is `1`.
    #'  The maximum value is `100` and the default value is `50`.
    #'  This is a pagination-specific attribute.
    #' @param offset The zero-based starting index in the entire collection
    #'  of the first item to return. The default value is `0`.
    #'  This is a pagination-specific attribute.
    #' @param ... Other arguments that can be passed to core `api()` function
    #'  like other query parameters or 'fields', etc.
    #'
    #' @importFrom checkmate assert_string
    #'
    #' @examples
    #' \dontrun{
    #'  projects_object <- Projects$new(auth = auth)
    #'
    #'  # Query projects
    #'  projects_object$query(name = name)
    #' }
    #'
    #' @return \code{\link{Collection}} of \code{\link{Project}} objects.
    query = function(name = NULL,
                     owner = NULL,
                     tags = NULL,
                     limit = getOption("sevenbridges2")$limit,
                     offset = getOption("sevenbridges2")$offset,
                     ...) {
      # Check input parameters
      if (!is_missing(name)) {
        checkmate::assert_string(name, null.ok = TRUE)
        # Transform into a list with name 'name'
        name_list <- list("name" = lapply(name, c))
        name <- transform_multiple_vals(name_list)
      }
      checkmate::assert_string(owner, null.ok = TRUE)
      if (!is_missing(tags)) {
        check_tags(tags)
        # Transform into a list with name 'tags'
        tags_list <- list("tags" = lapply(tags, c))
        tags <- transform_multiple_vals(tags_list)
      }

      # nocov start
      if (!is_missing(owner)) {
        path <- glue::glue(self$URL[["query"]], "/", owner)
      } else {
        path <- self$URL[["query"]]
      }

      res <- super$query(
        path = path,
        name = name,
        tags = tags,
        limit = limit,
        offset = offset,
        ...
      )

      res$items <- asProjectList(res, auth = self$auth)

      return(asCollection(res, auth = self$auth))
    },

    # Get project -----------------------------------------------------------
    #' @description This call creates a Project object containing the details
    #'  of a specified project.
    #'
    #' @param id Project ID. It consists of project owner's username or
    #'  if you are using Enterprise, then the Division name and project's
    #'  short name in form of \cr
    #'  `<owner_username>/<project-short-name>` or \cr
    #'  `<division-name>/<project-short-name>`.
    #'
    #' @param ... Other arguments that can be passed to core `api()` function
    #'  like 'fields', etc.
    #'
    #' @examples
    #' \dontrun{
    #'  projects_object <- Projects$new(auth = auth)
    #'
    #'  # Get project by id
    #'  projects_object$get(id = id)
    #' }
    #'
    #' @return \code{\link{Project}} object.
    get = function(id, ...) {
      res <- super$get(
        cls = self,
        id = id,
        ...
      )
      return(asProject(res, auth = self$auth))
    }, # nocov end

    # Delete project ----------------------------------------------------------
    #' @description Method that allows you to delete a project from the
    #'  platform. It can only be successfully made if you have admin status for
    #'  the project. \cr
    #'  Projects are specified by their IDs, which you can obtain
    #'  by using \code{Projects$query()} to list projects or by getting a
    #'  single project using \code{Projects$get()}.
    #'  Please be careful when using this method and note that calling it will
    #'  permanently delete the project from the platform.
    #'
    #' @param project \code{\link{Project}} object or project ID.
    #' @param ... Other arguments that can be passed to core `api()` function
    #' as 'fields', etc.
    #'
    #' @examples
    #' \dontrun{
    #'  projects_object <- Projects$new(auth = auth)
    #'
    #'  # Delete a project
    #'  projects_object$delete(project = project)
    #' }
    #'
    #' @importFrom glue glue
    delete = function(project, ...) {
      id <- check_and_transform_id(project, "Project")
      # nocov start
      res <- super$delete(
        id = id,
        ...
      )

      rlang::inform(
        message = glue::glue("Project {id} has been deleted.")
      )
    },
    # nocov end

    # Create new project ------------------------------------------------------
    #' @description A method for creating a new project.
    #'
    #' @param name The name of the project you are creating.
    #' @param billing_group The Billing object or ID of the billing group for
    #'  the project.
    #' @param description Description of the project.
    #' @param tags The list of project tags.
    #' @param locked Set this field to `TRUE` to lock down a project.
    #'  Locking down a project prevents any Seven Bridges team member from
    #'  viewing any information about the task.
    #' @param controlled Set this field to `TRUE` to define this project as
    #'  controlled i.e. one which will contain controlled data. Set `FALSE` to
    #'  define the project as open i.e. one which will contain open data.
    #' @param location Specify the location for this project:
    #'  `aws:us-east-1` or `aws:us-west-2`.
    #' @param use_interruptible_instances Defines the use of
    # nolint start
    #'  [spot instances](https://docs.sevenbridges.com/docs/about-spot-instances).
    # nolint end
    #' @param use_memoization Set to `FALSE` by default. Set to `TRUE` to
    #'  enable
    #'  [memoization](https://docs.sevenbridges.com/docs/about-memoization).
    #' @param use_elastic_disk Set to `TRUE` to enable
    #'  [Elastic disk](https://docs.sevenbridges.com/page/elastic-disk).
    #' @param intermediate_files A list defining the retention period for
    #'  intermediate files. Expected elements:
    #'  \itemize{
    #'    \item `retention` - Specifies that intermediate files should be
    #'      retained for a limited amount of time.
    #'      The value is always `LIMITED`.
    #'    \item `duration` - Specifies intermediate files retention period in
    #'      hours. The minimum value is `1`. The maximum value is `120` and the
    #'      default value is `24`.
    #'  }
    #' @param ... Other arguments that can be passed to core `api()` function
    #'  like 'fields', etc.
    #'
    #' @importFrom rlang inform abort
    #' @importFrom glue glue
    #' @importFrom checkmate assert_string test_character
    #'
    #' @examples
    #' \dontrun{
    #'  projects_object <- Projects$new(auth = auth)
    #'
    #'  # Create a project
    #'  projects_object$create(
    #'                     name = name,
    #'                     billing_group = billing_group,
    #'                     description = description
    #'                   )
    #' }
    #'
    #' @return \code{\link{Project}} object.
    create = function(name,
                      billing_group = NULL,
                      description = name,
                      tags = NULL,
                      locked = FALSE,
                      controlled = FALSE,
                      location = NULL,
                      use_interruptible_instances = TRUE,
                      use_memoization = FALSE,
                      use_elastic_disk = FALSE,
                      intermediate_files = list(
                        "retention" = "LIMITED",
                        "duration" = 24
                      ),
                      ...) {
      if (is_missing(name)) {
        rlang::abort("You must provide at least a name for the project you want to create.") # nolint
      }
      checkmate::assert_string(name, null.ok = FALSE)
      checkmate::assert_string(description, null.ok = TRUE)
      if (!is_missing(billing_group)) {
        billing_group <- check_and_transform_id(billing_group, "Billing")
      }
      check_tags(tags)
      checkmate::assert_logical(locked)
      checkmate::assert_logical(controlled)
      checkmate::assert_string(location, null.ok = TRUE)
      checkmate::assert_logical(use_interruptible_instances)
      checkmate::assert_logical(use_memoization)
      checkmate::assert_logical(use_elastic_disk)
      checkmate::assert_list(intermediate_files)
      # nocov start
      body <- list(
        "name" = name,
        "description" = description,
        "tags" = tags,
        "billing_group" = billing_group,
        "settings" = list(
          "locked" = locked,
          "controlled" = controlled,
          "location" = location,
          "use_interruptible_instances" = use_interruptible_instances,
          "use_memoization" = use_memoization,
          "use_elastic_disk" = use_elastic_disk,
          "intermediate_files" = intermediate_files
        )
      )

      res <- self$auth$api(
        path = self$URL[["create"]],
        body = body,
        method = "POST",
        ...
      )

      rlang::inform(
        glue::glue_col(
          "New project {green {name}} has been created on the {green {self$platform}} platform." # nolint
        )
      )
      return(asProject(res, auth = self$auth))
    } # nocov end
  )
)
