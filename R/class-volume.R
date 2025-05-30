# nolint start
#' @title R6 Class representing a Volume
#'
#' @description
#' R6 Class representing a resource for managing volumes.
#'
#' @importFrom R6 R6Class
#' @export
Volume <- R6::R6Class(
  # nolint end
  "Volume",
  inherit = Item,
  portable = FALSE,
  public = list(
    #' @field URL List of URL endpoints for this resource.
    URL = list(
      "get" = "storage/volumes/{id}",
      "volume" = "storage/volumes/{self$id}",
      "list" = "storage/volumes/{self$id}/list",
      "volume_file" = "storage/volumes/{self$id}/object",
      "members" = "storage/volumes/{self$id}/members",
      "member_username" = "storage/volumes/{self$id}/members/{username}",
      "member_permissions" = "storage/volumes/{self$id}/members/{username}/permissions" # nolint
    ),
    #' @field id Volume ID, constructed from `{division}/{volume_name}` or \cr
    #'  `{volume_owner}/{volume_name}`.
    id = NULL,
    #' @field name The name of the volume. It must be unique from all
    #'  other volumes for this user. Required if `from_path` parameter
    #'  is not provided.
    name = NULL,
    #' @field description The description of the volume.
    description = NULL,
    #' @field access_mode Signifies whether this volume should be used
    #'  for read-write (RW) or read-only (RO) operations. The access mode is
    #'  consulted independently of the credentials granted to Seven Bridges
    #'  when the volume was created, so it is possible to use a read-write
    #'  credentials to register both read-write and read-only volumes using it.
    #'  Default: `"RW"`.
    access_mode = NULL,
    #' @field service This object in form of string more closely describes the
    #'  mapping of the volume to the cloud service where the data is stored.
    service = NULL,
    #' @field created_on The date and time this volume was created.
    created_on = NULL,
    #' @field modified_on The date and time this volume was last modified.
    modified_on = NULL,
    #' @field active If a volume is deactivated, this field will be
    #'  set to `FALSE`.
    active = NULL,

    # Initialize Volume object ----------------------------------------------
    #' @description Create a new Volume object.
    #' @param res Response containing Volume object info.
    #' @param ... Other response arguments.
    initialize = function(res = NA, ...) {
      # Initialize Item class
      super$initialize(...)

      self$id <- res$id
      self$name <- res$name
      self$description <- res$description
      self$access_mode <- res$access_mode
      self$service <- res$service
      self$created_on <- res$created_on
      self$modified_on <- res$modified_on
      self$active <- res$active
    },

    # nocov start
    # Print Volume object ----------------------------------------------------
    #' @description Print method for Volume class.
    #'
    #' @importFrom purrr discard
    #' @importFrom glue glue_col
    #' @importFrom cli cli_h1 cli_li cli_end
    #'
    #' @examples
    #' \dontrun{
    #' # x is API response when volume is requested
    #' volume_object <- Volume$new(
    #'                     res = x,
    #'                     href = x$href,
    #'                     auth = auth,
    #'                     response = attr(x, "response")
    #'                    )
    #'
    #'  # Print volume object
    #'  volume_object$print()
    #' }
    #'
    print = function() {
      x <- as.list(self)

      # Extract all except 'raw'
      x$raw <- NULL

      x <- purrr::discard(x, .p = is.function)
      x <- purrr::discard(x, .p = is.environment)
      x <- purrr::discard(x, .p = is.null)

      # Extract type, bucket and prefix from service to print
      x <- append(x, x$service[c("type", "bucket", "prefix")])

      # Remove lists
      x <- purrr::discard(x, .p = is.list)

      # Remove copy_of field if it's empty (NA)
      x <- purrr::discard(x, .p = is.na)

      string <- glue::glue_col("{green {names(x)}}: {x}")

      cli::cli_h1("Volume")

      cli::cli_li(string)

      # Close container elements
      cli::cli_end()
    },

    # Reload Volume object ----------------------------------------------------
    #' @description Reload Volume object information.
    #'
    #' @param ... Other arguments that can be passed to core `api()` function
    #'  like 'fields', etc.
    #'
    #' @examples
    #' \dontrun{
    #' # x is API response when volume is requested
    #' volume_object <- Volume$new(
    #'                     res = x,
    #'                     href = x$href,
    #'                     auth = auth,
    #'                     response = attr(x, "response")
    #'                    )
    #'
    #'  # Reload volume object
    #'  volume_object$reload()
    #' }
    #'
    #' @return \code{\link{Volume}} object.
    reload = function(...) {
      super$reload(
        cls = self,
        advance_access = TRUE,
        ...
      )
      rlang::inform("Volume object is refreshed!")
    },
    # nocov end

    # Update volume ----------------------------------------------------------
    #' @description Update a volume.
    #'  This function updates the details of a specific volume.
    #'
    #' @param description The new description of the volume.
    #' @param access_mode Signifies whether this volume should be used
    #'  for read-write (RW) or read-only (RO) operations. The access mode is
    #'  consulted independently of the credentials granted to Seven Bridges
    #'  when the volume was created, so it is possible to use a read-write
    #'  credentials to register both read-write and read-only volumes using it.
    #'  Default: `"RW"`.
    #' @param service This object in form of string more closely describes the
    #'  mapping of the volume to the cloud service where the data is stored.
    #'
    #' @importFrom checkmate assert_character assert_list
    #'
    #' @examples
    #' \dontrun{
    #' # x is API response when volume is requested
    #' volume_object <- Volume$new(
    #'                     res = x,
    #'                     href = x$href,
    #'                     auth = auth,
    #'                     response = attr(x, "response")
    #'                    )
    #'
    #'  # Update volume object
    #'  volume_object$update(description = description)
    #' }
    #'
    #' @return \code{\link{Volume}} object.
    update = function(description = NULL, access_mode = NULL,
                      service = NULL) {
      checkmate::assert_character(description, null.ok = TRUE)
      checkmate::assert_character(access_mode, null.ok = TRUE)
      if (!is_missing(access_mode) && !(access_mode %in% c("RW", "RO"))) {
        rlang::abort("Access mode must be RW or RO.")
      }
      checkmate::assert_list(service,
        any.missing = FALSE, all.missing = FALSE,
        null.ok = TRUE
      )
      # nocov start
      body <- list(
        description = description,
        service = service,
        access_mode = access_mode
      )
      body <- body[!sapply(body, is.null)]

      path <- glue::glue(self$URL[["volume"]])

      res <- self$auth$api(
        path = path,
        method = "PATCH",
        body = body,
        advance_access = TRUE
      )

      self$initialize(
        res = res,
        href = res$href,
        auth = self$auth,
        response = attr(res, "response")
      )
    }, # nocov end

    # Deactivate volume -------------------------------------------------------
    #' @description Deactivate volume.
    #'  Once deactivated, you cannot import from, export to, or browse within a
    #'  volume. As such, the content of the files imported from this volume
    #'  will no longer be accessible on the Platform. However, you can update
    #'  the volume and manage members. \cr
    #'  Note that you cannot deactivate the volume if you have running imports
    #'  or exports unless you force the operation using the query parameter
    #'  force=TRUE.
    #'  Note that to delete a volume, first you must deactivate it and delete
    #'  all files which have been imported from the volume to the Platform.
    #'
    #' @param ... Other query parameters or arguments that can be passed to
    #'  core `api()` function like 'force'.
    #'  Use it within query parameter, like `query = list(force = TRUE)`.
    #'
    #' @importFrom rlang abort inform
    #' @importFrom glue glue glue_col
    #'
    #' @examples
    #' \dontrun{
    #' # x is API response when volume is requested
    #' volume_object <- Volume$new(
    #'                     res = x,
    #'                     href = x$href,
    #'                     auth = auth,
    #'                     response = attr(x, "response")
    #'                    )
    #'
    #'  # Deactivate volume
    #'  volume_object$deactivate()
    #' }
    #'
    deactivate = function(...) {
      if (!self$active) {
        rlang::abort(
          glue::glue("The volume {self$name} is already deactivated.")
        )
      }
      path <- glue::glue(self$URL[["volume"]]) # nocov start

      res <- self$auth$api(
        path = path,
        method = "PATCH",
        body = list("active" = FALSE),
        advance_access = TRUE,
        ...
      )

      rlang::inform(glue::glue("The volume {self$name} has been ", glue::glue_col("{red deactivated}."))) # nolint

      self$active <- FALSE

      return(self)
    }, # nocov end

    # Reactivate volume -------------------------------------------------------
    #' @description Reactivate volume.
    #'  This function reactivates the previously deactivated volume by updating
    #'  the `active` field of the volume to `TRUE`.
    #'
    #' @param ... Other query parameters or arguments that can be passed to
    #'  core `api()` function like 'force'.
    #'  Use it within query parameter, like `query = list(force = TRUE)`.
    #'
    #' @importFrom rlang abort inform
    #' @importFrom glue glue glue_col
    #'
    #' @examples
    #' \dontrun{
    #' # x is API response when volume is requested
    #' volume_object <- Volume$new(
    #'                     res = x,
    #'                     href = x$href,
    #'                     auth = auth,
    #'                     response = attr(x, "response")
    #'                    )
    #'
    #'  # Deactivate volume
    #'  volume_object$deactivate()
    #'
    #'  # Reactivate volume
    #'  volume_object$reactivate()
    #' }
    #'
    #' @return \code{\link{Volume}} object.
    reactivate = function(...) {
      if (self$active) {
        rlang::abort(
          glue::glue("The volume {self$name} is already active.")
        )
      }
      path <- glue::glue(self$URL[["volume"]]) # nocov start

      res <- self$auth$api(
        path = path,
        method = "PATCH",
        body = list("active" = TRUE),
        advance_access = TRUE,
        ...
      )

      rlang::inform(glue::glue("The volume {self$name} has been ", glue::glue_col("{green reactivated}."))) # nolint

      self$active <- TRUE

      return(self)
    }, # nocov end

    # Delete volume ----------------------------------------------------------
    #' @description Delete volume.
    #'  This call deletes a volume you've created to refer to storage on
    #'  Amazon Web Services, Google Cloud Storage, Azure or Ali cloud.
    #'  To be able to delete a volume, you first need to deactivate it and then
    #'  delete all files on the Platform that were previously imported from
    #'  the volume.
    #'
    #' @importFrom rlang abort inform
    #' @importFrom glue glue glue_col
    #'
    #' @examples
    #' \dontrun{
    #' # x is API response when volume is requested
    #' volume_object <- Volume$new(
    #'                     res = x,
    #'                     href = x$href,
    #'                     auth = auth,
    #'                     response = attr(x, "response")
    #'                    )
    #'
    #'  # Delete volume
    #'  volume_object$delete()
    #' }
    #'
    delete = function() {
      if (self$active) {
        rlang::abort(
          glue::glue("The volume {self$name} must be deactivated first in order to be able to delete it.") # nolint
        )
      }
      path <- glue::glue(self$URL[["volume"]]) # nocov start

      res <- self$auth$api(
        path = path,
        method = "DELETE",
        advance_access = TRUE
      )

      rlang::inform(glue::glue("The volume {self$name} has been ", glue::glue_col("{red deleted}."))) # nolint

      self$initialize(
        res = NULL,
        href = NULL,
        auth = NULL,
        response = attr(res, "response")
      )
    }, # nocov end

    # List volume contents ----------------------------------------------------
    #' @description List volume contents.
    #'  This call lists the contents of a specific volume.
    #'
    #' @param prefix This is parent parameter in volume context. If specified,
    #'  the content of the parent directory on the current volume is listed.
    #' @param limit The maximum number of collection items to return
    #'  for a single request. Minimum value is `1`.
    #'  The maximum value is `100` and the default value is `50`.
    #'  This is a pagination-specific attribute.
    #' @param link Link to use in the next chunk of results. Contains limit and
    #'  continuation_token. If provided it will overwrite other arguments'
    #'  values passed.
    #' @param continuation_token Continuation token received to use for next
    #'  chunk of results. Behaves similarly like offset parameter.
    #' @param ... Other arguments that can be passed to core `api()` function
    #'  like 'fields' for example. With fields parameter you can specify a
    #'  subset of fields to include in the response.
    #'  You can use: `href`, `location`, `volume`, `type`, `metadata`, `_all`.
    #'  Default: `_all`.
    #'
    #' @importFrom checkmate assert_character
    #' @importFrom glue glue
    #'
    #' @examples
    #' \dontrun{
    #' # x is API response when volume is requested
    #' volume_object <- Volume$new(
    #'                     res = x,
    #'                     href = x$href,
    #'                     auth = auth,
    #'                     response = attr(x, "response")
    #'                    )
    #'
    #'  # List volume contents
    #'  volume_object$list_contents()
    #' }
    #'
    #' @return \code{\link{VolumeContentCollection}} object containing
    #' list of \code{\link{VolumeFile}} and \code{\link{VolumePrefix}} objects.
    list_contents = function(prefix = NULL,
                             limit = getOption("sevenbridges2")$limit,
                             link = NULL,
                             continuation_token = NULL,
                             ...) {
      checkmate::assert_character(prefix,
        len = 1, null.ok = TRUE,
        typed.missing = TRUE
      )
      checkmate::assert_character(link,
        len = 1, null.ok = TRUE,
        typed.missing = TRUE
      )
      checkmate::assert_character(continuation_token,
        len = 1, null.ok = TRUE,
        typed.missing = TRUE
      )

      path <- glue::glue(self$URL[["list"]]) # nocov start

      res <- self$auth$api(
        url = link,
        path = path,
        query = list(prefix = prefix, continuation_token = continuation_token),
        method = "GET",
        advance_access = TRUE,
        limit = limit,
        ...
      )

      return(asVolumeContentCollection(res, auth = self$auth))
    }, # nocov end

    # Get volume file info ----------------------------------------------------
    #' @description Get volume file information.
    #'  This function returns the specific Volume File.
    #'
    #' @param location Volume file id, which is represented as file
    #'  location.
    #' @param link Link to the file resource received from listing volume's
    #'  contents. Cannot be used together with location.
    #' @param ... Other arguments that can be passed to core `api()` function
    #'  like 'fields', etc.
    #'
    #' @importFrom checkmate assert_character
    #' @importFrom rlang abort
    #' @importFrom glue glue
    #'
    #' @examples
    #' \dontrun{
    #' # x is API response when volume is requested
    #' volume_object <- Volume$new(
    #'                     res = x,
    #'                     href = x$href,
    #'                     auth = auth,
    #'                     response = attr(x, "response")
    #'                    )
    #'
    #'  # Get volume file
    #'  volume_object$get_file(location = location)
    #' }
    #'
    #' @return \code{\link{VolumeFile}} object.
    get_file = function(location = NULL, link = NULL, ...) {
      checkmate::assert_character(location,
        len = 1, null.ok = TRUE,
        typed.missing = TRUE
      )
      checkmate::assert_character(link,
        len = 1, null.ok = TRUE,
        typed.missing = TRUE
      )
      if (!is_missing(location) && !is_missing(link)) {
        rlang::abort("Please provide either location or link, not both.")
      }
      if (is_missing(location) && is_missing(link)) {
        rlang::abort("Empty arguments are not allowed. Please provide either location or link.") # nolint
      }
      # nocov start
      if (!is_missing(link)) {
        link <- glue::glue(link, "&fields=_all")
      }

      path <- glue::glue(self$URL[["volume_file"]])

      res <- self$auth$api(
        url = link,
        path = path,
        query = list(location = location),
        method = "GET",
        advance_access = TRUE,
        ...
      )

      return(asVolumeFile(res, auth = self$auth))
      # nocov end
    },

    # List volume members ----------------------------------------------------
    #' @description List members of a volume.
    #'  This function returns the members of a specific volume.
    #'
    #' @param limit The maximum number of collection items to return
    #'  for a single request. Minimum value is `1`.
    #'  The maximum value is `100` and the default value is `50`.
    #'  This is a pagination-specific attribute.
    #' @param offset The zero-based starting index in the entire collection
    #'  of the first item to return. The default value is `0`.
    #'  This is a pagination-specific attribute.
    #' @param ... Other parameters that can be passed to core `api()` function
    #'  like 'fields', etc.
    #'
    #' @importFrom glue glue
    #'
    #' @examples
    #' \dontrun{
    #' # x is API response when volume is requested
    #' volume_object <- Volume$new(
    #'                     res = x,
    #'                     href = x$href,
    #'                     auth = auth,
    #'                     response = attr(x, "response")
    #'                    )
    #'
    #'  # List volume members
    #'  volume_object$list_members()
    #' }
    #'
    #' @return \code{\link{Collection}} containing \code{\link{Member}}
    #'  objects.
    list_members = function(limit = getOption("sevenbridges2")$limit,
                            offset = getOption("sevenbridges2")$offset,
                            ...) {
      # nocov start
      path <- glue::glue(self$URL[["members"]])

      res <- self$auth$api(
        path = path,
        method = "GET",
        advance_access = TRUE,
        limit = limit,
        offset = offset,
        ...
      )

      res$items <- asMemberList(res, auth = self$auth)

      return(asCollection(res, auth = self$auth))
      # nocov end
    },

    # Add volume members ----------------------------------------------------
    #' @description Add member to a volume.
    #'  This function adds members to the specified volume.
    #'
    #' @param user The Seven Bridges Platform username of the person
    #'  you want to add to the volume or object of class Member containing
    #'  user's username.
    #' @param permissions List of permissions granted to the user being added.
    #'  Permissions include listing the contents of a volume, importing files
    #'  from the volume to the Platform, exporting files from the Platform to
    #'  the volume, and admin privileges. \cr
    #'  It can contain fields: 'read', 'copy', 'write' and 'admin' with
    #'  logical fields - TRUE if certain permission is allowed to the user, or
    #'  FALSE if it's not.
    #'  Example:
    #'  ```{r}
    #'    permissions = list(read = TRUE, copy = TRUE, write = FALSE,
    #'    admin = FALSE)
    #'  ```
    #'
    #' @examples
    #' \dontrun{
    #' # x is API response when volume is requested
    #' volume_object <- Volume$new(
    #'                     res = x,
    #'                     href = x$href,
    #'                     auth = auth,
    #'                     response = attr(x, "response")
    #'                    )
    #'
    #'  # Add volume member
    #'  volume_object$add_member(
    #'                 user = user,
    #'                 permissions = list(read = TRUE, copy = FALSE)
    #'               )
    #' }
    #'
    #' @return \code{\link{Member}} object.
    add_member = function(user,
                          permissions = list(
                            read = TRUE,
                            copy = FALSE,
                            write = FALSE,
                            admin = FALSE
                          )) {
      username <- check_and_transform_id(user,
        class_name = "Member",
        field_name = "username"
      )
      # nocov start
      res <- self$private$add_member_general(username,
        permissions,
        type = "USER"
      )

      return(asMember(res, auth = self$auth))
      # nocov end
    },

    # Add team to a volume (Enterprise users) --------------------------------
    #' @description Add a specific team as a member to a volume.
    #'  Only Enterprise users that are part of some division can add teams
    #'  to a volume created within that division.
    #'
    #' @param team The Seven Bridges Platform ID of a team
    #'  you want to add to the volume or object of class Team containing
    #'  team's ID. Team must be created within a division where the volume is
    #'  created too.
    #' @param permissions List of permissions granted to the team being added.
    #'  Permissions include listing the contents of a volume, importing files
    #'  from the volume to the Platform, exporting files from the Platform to
    #'  the volume, and admin privileges. \cr
    #'  It can contain fields: 'read', 'copy', 'write' and 'admin' with
    #'  logical fields - TRUE if certain permission is allowed to the team, or
    #'  FALSE if it's not.
    #'  Example:
    #'  ```{r}
    #'    permissions = list(read = TRUE, copy = TRUE, write = FALSE,
    #'    admin = FALSE)
    #'  ```
    #'
    #' @examples
    #' \dontrun{
    #' # x is API response when volume is requested
    #' volume_object <- Volume$new(
    #'                     res = x,
    #'                     href = x$href,
    #'                     auth = auth,
    #'                     response = attr(x, "response")
    #'                    )
    #'
    #'  # Add volume member
    #'  volume_object$add_member_team(
    #'                 team = <team-id>,
    #'                 permissions = list(read = TRUE, copy = FALSE)
    #'               )
    #' }
    #'
    #' @return \code{\link{Member}} object.
    add_member_team = function(team,
                               permissions = list(
                                 read = TRUE,
                                 copy = FALSE,
                                 write = FALSE,
                                 admin = FALSE
                               )) {
      team <- check_and_transform_id(team,
        class_name = "Team",
        field_name = "id"
      )
      # nocov start
      res <- self$private$add_member_general(team, permissions, type = "TEAM")

      return(asMember(res, auth = self$auth))
      # nocov end
    },
    # Add division to a volume (Enterprise users) -----------------------
    #' @description Add a specific division as a member to a volume.
    #'  Only Enterprise users (with Enterprise accounts) can add divisions to a
    #'  volume that is created with that Enterprise account (not within other
    #'  divisions).
    #'
    #' @param division The Seven Bridges Platform ID of a division
    #'  you want to add to the volume or object of class Division containing
    #'  division's ID.
    #' @param permissions List of permissions granted to the division being
    #'  added. Permissions include listing the contents of a volume, importing
    #'  files from the volume to the Platform, exporting files from the
    #'  Platform to the volume, and admin privileges. \cr
    #'  It can contain fields: 'read', 'copy', 'write' and 'admin' with
    #'  logical fields - TRUE if certain permission is allowed to the division,
    #'  or FALSE if it's not.
    #'  Example:
    #'  ```{r}
    #'    permissions = list(read = TRUE, copy = TRUE, write = FALSE,
    #'    admin = FALSE)
    #'  ```
    #'
    #' @examples
    #' \dontrun{
    #' # x is API response when volume is requested
    #' volume_object <- Volume$new(
    #'                     res = x,
    #'                     href = x$href,
    #'                     auth = auth,
    #'                     response = attr(x, "response")
    #'                    )
    #'
    #'  # Add volume member
    #'  volume_object$add_member_division(
    #'                 division = <division-id>,
    #'                 permissions = list(read = TRUE, copy = FALSE)
    #'               )
    #' }
    #'
    #' @return \code{\link{Member}} object.
    add_member_division = function(division,
                                   permissions = list(
                                     read = TRUE,
                                     copy = FALSE,
                                     write = FALSE,
                                     admin = FALSE
                                   )) {
      division <- check_and_transform_id(division,
        class_name = "Division",
        field_name = "id"
      )
      # nocov start
      res <- self$private$add_member_general(division,
        permissions,
        type = "DIVISION"
      )

      return(asMember(res, auth = self$auth))
      # nocov end
    },
    # Remove volume members ---------------------------------------------------
    #' @description Remove member from a volume.
    #'  This function removes members from the specified volume.
    #'
    #' @param member The Seven Bridges Platform username of the person
    #'  you want to remove from the volume, or team ID or division ID
    #'  (for Enterprise users only) or object of class Member containing
    #'  member's ID.
    #'
    #' @importFrom glue glue glue_col
    #'
    #' @examples
    #' \dontrun{
    #' # x is API response when volume is requested
    #' volume_object <- Volume$new(
    #'                     res = x,
    #'                     href = x$href,
    #'                     auth = auth,
    #'                     response = attr(x, "response")
    #'                    )
    #'
    #'  # Remove volume member
    #'  volume_object$remove_member(member = member)
    #' }
    #'
    remove_member = function(member) {
      username <- check_and_transform_id(member,
        class_name = "Member",
        field_name = "id"
      )
      # nocov start
      path <- glue::glue(self$URL[["member_username"]])

      res <- self$auth$api(
        path = path,
        method = "DELETE",
        advance_access = TRUE
      )

      rlang::inform(glue_col("Member {green {username}} was successfully removed from the {green {id}} volume.")) # nolint
      # nocov end
    },

    # Get volume member details ---------------------------------------------
    #' @description Get member's details.
    #'  This function returns member's information.
    #'
    #' @param member The Seven Bridges Platform username of the person
    #'  you want to get information about, or team ID or division ID
    #'  (for Enterprise users only) or object of class Member containing
    #'  member's ID.
    #' @param ... Other arguments that can be passed to core `api()` function
    #'  like 'fields', etc.
    #'
    #' @importFrom glue glue
    #'
    #' @examples
    #' \dontrun{
    #' # x is API response when volume is requested
    #' volume_object <- Volume$new(
    #'                     res = x,
    #'                     href = x$href,
    #'                     auth = auth,
    #'                     response = attr(x, "response")
    #'                    )
    #'
    #'  # Get volume member
    #'  volume_object$get_member(member = member)
    #' }
    #'
    #' @return \code{\link{Member}} object.
    get_member = function(member, ...) {
      username <- check_and_transform_id(member,
        class_name = "Member",
        field_name = "id"
      )
      # nocov start
      path <- glue::glue(self$URL[["member_username"]])

      res <- self$auth$api(
        path = path,
        method = "GET",
        advance_access = TRUE,
        ...
      )

      return(asMember(res, auth = self$auth))
      # nocov end
    },

    # Modify volume member's permissions --------------------------------------
    #' @description Modify volume member's permissions.
    #'  This function modifies the permissions for a member of a specific
    #'  volume. Note that this does not overwrite all previously set
    #'  permissions for the member.
    #'
    #' @param member The Seven Bridges Platform username of the person
    #'  you want to modify permissions for or team ID or division ID
    #'  (for Enterprise users only) or object of class Member containing
    #'  member's ID.
    #' @param permissions List of specific (or all) permissions you want to
    #'  update for the member of the volume.
    #'  Permissions include listing the contents of a volume, importing files
    #'  from the volume to the Platform, exporting files from the Platform to
    #'  the volume, and admin privileges.
    #'  It can contain fields: 'read', 'copy', 'write' and 'admin' with
    #'  logical fields - TRUE if certain permission is allowed to the user, or
    #'  FALSE if it's not.
    #'  Example:
    #'  ```{r}
    #'    permissions = list(read = TRUE, copy = TRUE, write = FALSE,
    #'    admin = FALSE)
    #'  ```
    #'
    #' @importFrom checkmate assert_list
    #' @importFrom glue glue glue_col
    #'
    #' @examples
    #' \dontrun{
    #' # x is API response when volume is requested
    #' volume_object <- Volume$new(
    #'                     res = x,
    #'                     href = x$href,
    #'                     auth = auth,
    #'                     response = attr(x, "response")
    #'                    )
    #'
    #'  # Modify volume member permissions
    #'  volume_object$modify_member_permissions(
    #'                     member = member,
    #'                     permission = list(read = TRUE, copy = TRUE)
    #'                   )
    #' }
    #'
    #' @return \code{\link{Permission}} object.
    modify_member_permissions = function(member,
                                         permissions = list(
                                           read = TRUE,
                                           copy = FALSE,
                                           write = FALSE,
                                           admin = FALSE
                                         )) {
      username <- check_and_transform_id(member,
        class_name = "Member",
        field_name = "id"
      )
      checkmate::assert_list(permissions,
        null.ok = FALSE, max.len = 4,
        types = "logical"
      )
      checkmate::assert_subset(names(permissions),
        empty.ok = FALSE,
        choices = c("read", "copy", "write", "admin")
      )
      # nocov start
      body <- flatten_query(permissions)

      path <- glue::glue(self$URL[["member_permissions"]])

      res <- self$auth$api(
        path = path,
        method = "PATCH",
        body = body,
        advance_access = TRUE
      )

      rlang::inform(glue::glue_col("Member {green {username}}'s permissions have been {green updated} to:")) # nolint

      return(asPermission(res, auth = self$auth))
      # nocov end
    },

    # nocov start
    # List import jobs of this volume --------------------------------------
    #' @description This call lists import jobs initiated by particular user
    #'  from this volume.
    #'
    #' @param project String project id or Project object. List all volume
    #'  imports to this project. Optional.
    #' @param state String. The state of the import job. Possible values are:
    #'  \itemize{
    #'    \item `PENDING`: the import is queued;
    #'    \item `RUNNING`: the import is running;
    #'    \item `COMPLETED`: the import has completed successfully;
    #'    \item `FAILED`: the import has failed.
    #'  }
    #'  Example: `state = c("RUNNING", "FAILED")`
    #' @param limit The maximum number of collection items to return
    #'  for a single request. Minimum value is `1`.
    #'  The maximum value is `100` and the default value is `50`.
    #'  This is a pagination-specific attribute.
    #' @param offset The zero-based starting index in the entire collection
    #'  of the first item to return. The default value is `0`.
    #'  This is a pagination-specific attribute.
    #' @param ... Other arguments that can be passed to core `api()` function
    #'  like 'fields', etc.
    #'
    #' @examples
    #' \dontrun{
    #' # x is API response when volume is requested
    #' volume_object <- Volume$new(
    #'                     res = x,
    #'                     href = x$href,
    #'                     auth = auth,
    #'                     response = attr(x, "response")
    #'                    )
    #'
    #'  # List volume imports
    #'  volume_object$list_imports(
    #'                     project = project,
    #'                     state = c("RUNNING", "FAILED")
    #'                   )
    #' }
    #'
    #' @return \code{\link{Collection}} containing list of
    #' \code{\link{Import}} job objects.
    list_imports = function(project = NULL, state = NULL,
                            limit = getOption("sevenbridges2")$limit,
                            offset = getOption("sevenbridges2")$offset,
                            ...) {
      self$auth$imports$query(
        volume = self,
        project = project,
        state = state,
        limit = limit,
        offset = offset,
        ...
      )
    },

    # List export jobs of this volume --------------------------------------
    #' @description This call lists export jobs initiated by a user into this
    #'  volume.
    #'  Note that when you export a file from a project on the Platform into a
    #'  volume, you write to your cloud storage bucket.
    #'
    #' @param state The state of the export job. Possible values are:
    #'  \itemize{
    #'    \item `PENDING`: the export is queued;
    #'    \item `RUNNING`: the export is running;
    #'    \item `COMPLETED`: the export has completed successfully;
    #'    \item `FAILED`: the export has failed.
    #'  }
    #'  Example: `state = c("RUNNING", "FAILED")`
    #' @param limit The maximum number of collection items to return
    #'  for a single request. Minimum value is `1`.
    #'  The maximum value is `100` and the default value is `50`.
    #'  This is a pagination-specific attribute.
    #' @param offset The zero-based starting index in the entire collection
    #'  of the first item to return. The default value is `0`.
    #'  This is a pagination-specific attribute.
    #' @param ... Other arguments that can be passed to core `api()` function
    #'  like 'fields', etc.
    #'
    #' @examples
    #' \dontrun{
    #' # x is API response when volume is requested
    #' volume_object <- Volume$new(
    #'                     res = x,
    #'                     href = x$href,
    #'                     auth = auth,
    #'                     response = attr(x, "response")
    #'                    )
    #'
    #'  # List volume exports
    #'  volume_object$list_exports(state = c("RUNNING", "FAILED"))
    #' }
    #'
    #' @return \code{\link{Collection}} containing list of
    #' \code{\link{Export}} job objects.
    list_exports = function(state = NULL,
                            limit = getOption("sevenbridges2")$limit,
                            offset = getOption("sevenbridges2")$offset,
                            ...) {
      self$auth$exports$query(
        volume = self,
        state = state,
        limit = limit,
        offset = offset,
        ...
      )
    } # nocov end
  ),
  private = list(
    # Private general method to add members to a volume ----------------------
    # This is a utility function used in public methods add_member,
    # add_member_team and add_member_division that allow users of different
    # roles (regular and Enterprise) to add members to the specified volume.
    # Users can add regular users, teams or divisions which can be specified
    # with 'type' parameter (allowed values are USER, TEAM or DIVISION).
    #' @importFrom checkmate assert_string assert_list assert_subset
    #' @importFrom glue glue
    add_member_general = function(member,
                                  permissions = list(
                                    read = TRUE,
                                    copy = FALSE,
                                    write = FALSE,
                                    admin = FALSE
                                  ),
                                  type) {
      checkmate::assert_string(member, null.ok = FALSE)
      checkmate::assert_list(permissions,
        null.ok = FALSE, len = 4,
        types = "logical"
      )
      checkmate::assert_subset(names(permissions),
        empty.ok = FALSE,
        choices = c("read", "copy", "write", "admin")
      )
      checkmate::assert_subset(type,
        empty.ok = FALSE,
        choices = c("USER", "TEAM", "DIVISION")
      )
      # nocov start
      path <- glue::glue(self$URL[["members"]])

      body <- list(
        username = member,
        permissions = permissions,
        type = type
      )

      res <- self$auth$api(
        path = path,
        method = "POST",
        body = body,
        advance_access = TRUE
      )

      return(res)
    } # nocov end
  )
)

# nocov start
# Helper functions for creating Volume objects --------------------------------
asVolume <- function(x = NULL, auth = NULL) {
  Volume$new(
    res = x,
    href = x$href,
    auth = auth,
    response = attr(x, "response")
  )
}

asVolumeList <- function(x, auth) {
  obj <- lapply(x$items, asVolume, auth = auth)
  obj
}
# nocov end
