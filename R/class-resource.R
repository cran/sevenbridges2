#' @title R6 Class Representing a Resource
#'
#' @description
#' Base class for describing a resource.
#'
#' @details This is a base class for describing a resource on the platform:
#'  Projects, Tasks, Volumes, Files, Apps etc.
#'
#' @importFrom R6 R6Class
Resource <- R6::R6Class(
  "Resource",
  portable = FALSE,
  lock_objects = FALSE,
  public = list(
    #' @field auth Seven Bridges Authentication object.
    auth = NULL,

    #' @field URL List of URL endpoints for this resource.
    URL = list(),

    # Initialize Resource object ----------------------------------------------
    #' @description Create a new Resource object.
    #'
    #' @param auth Seven Bridges Authentication object.
    initialize = function(auth = NA) {
      self$auth <- auth
    },

    # Generic query function ----------------------------------------------
    #' @description Generic query implementation that is used by the resources.
    #'
    #' @param ... Parameters that will be passed to core `api()` function.
    query = function(...) {
      args <- list(...)

      if (is_missing(args$path)) {
        rlang::abort("Please provide path parameter!")
      }
      path <- args$path

      # Remove path, it is not needed for query parameters
      args[["path"]] <- NULL

      # Remove advance_access, it is not needed for query parameters
      adv_access <- extract_common_query_params(args, "advance_access")
      limit <- extract_common_query_params(args, "limit")
      offset <- extract_common_query_params(args, "offset")
      fields <- extract_common_query_params(args, "fields")
      args[c("advance_access", "limit", "offset", "fields")] <- NULL

      # nocov start
      res <- self$auth$api(
        path = path,
        method = "GET",
        query = args,
        advance_access = adv_access,
        limit = limit,
        offset = offset,
        fields = fields
      )

      return(res) # nocov end
    },

    # Generic get function ----------------------------------------------
    #' @description Generic get implementation that fetches a single resource
    #'  from the server.
    #'
    #' @param cls Resource class object.
    #' @param id Object id.
    #' @param ... Other arguments that can be passed to core `api()` function
    #'  like 'fields', etc.
    #'
    #' @importFrom rlang abort
    #' @importFrom glue glue
    #' @importFrom checkmate assert_string
    get = function(cls, id, ...) {
      if (is_missing(cls)) {
        rlang::abort("Please provide cls parameter!")
      }
      if (is_missing(id)) {
        rlang::abort("Please provide id parameter!")
      } else {
        checkmate::assert_string(id, null.ok = FALSE)
      }

      if (is.null(cls[["auth"]])) {
        rlang::abort("Your cls parameter doesn't have field auth!")
      }
      auth <- cls$auth

      if (is.null(cls$URL[["get"]])) {
        rlang::abort("Unable to retrieve resource!")
      }

      url <- cls$URL$get
      path <- glue::glue(url)

      # nocov start
      res <- self$auth$api(
        path = path,
        method = "GET",
        ...
      )

      return(res) # nocov end
    },

    # Generic delete function ------------------------------------------------
    #' @description Generic implementation to delete a resource
    #'  from the server.
    #'
    #' @param cls Resource class object.
    #' @param id Object id.
    #' @param ... Other arguments that can be passed to core `api()` function.
    #'
    #' @importFrom rlang abort
    #' @importFrom glue glue
    delete = function(id, ...) {
      if (is.null(self[["URL"]][["delete"]])) {
        rlang::abort("Resource cannot be deleted!")
      }
      if (is_missing(id)) {
        rlang::abort("Please provide id parameter!")
      }

      url <- self$URL[["delete"]]
      path <- glue::glue("{url}/{id}")

      # nocov start
      res <- self$auth$api(
        path = path,
        method = "DELETE",
        ...
      )

      return(res)
      # nocov end
    }
  )
)
