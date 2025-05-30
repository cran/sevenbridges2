# nolint start
#' @title R6 Class representing an Upload job
#'
#' @description
#' R6 Class representing a resource for managing files' uploads.
#'
#' @importFrom R6 R6Class
#'
#' @export
Upload <- R6::R6Class(
  # nolint end
  "Upload",
  portable = FALSE,
  public = list(
    #' @field URL List of URL endpoints for this resource.
    URL = list(
      "init" = "upload/multipart",
      "upload_job" = "upload/multipart/{self$upload_id}",
      "upload_complete_all" = "upload/multipart/{self$upload_id}/complete"
    ),
    #' @field upload_id Upload ID received after upload initialization.
    upload_id = NULL,
    #' @field path Relative or absolute path to the file on the local disk.
    path = NULL,
    #' @field project Project's identifier (character).
    project = NULL,
    #' @field parent The ID of the folder to which the item is being uploaded.
    #' Should not be used together with 'project'.
    parent = NULL,
    #' @field filename File name. By default it will be the same as the name of
    #' the file you want to upload. However, it can be changed to new name.
    filename = NULL,
    #' @field overwrite If `TRUE` will overwrite file on the server.
    overwrite = NULL,
    #' @field file_size File size.
    file_size = NULL,
    #' @field part_size Size of part in bytes.
    part_size = NULL,
    #' @field part_length Number of parts to upload.
    part_length = NULL,
    #' @field parts List of parts to be uploaded (class `Part`).
    parts = NULL,
    #' @field initialized If `TRUE`, upload has been initialized.
    initialized = NULL,
    #' @field auth Authentication object.
    auth = NULL,

    # Initialize Upload object -----------------------------------------------
    #' @description Create a new Upload object.
    #'
    #' @param path Path to the file on the local disc.
    #' @param project Project's identifier (character).
    #' @param parent The ID of the folder to which the item is being uploaded.
    #' @param filename New file name. Optional.
    #' @param overwrite If true will overwrite file on the server.
    #' @param file_size File size.
    #' @param part_size Size of a single part in bytes.
    #' @param initialized If `TRUE`, upload has been initialized.
    #' @param auth Seven Bridges Authentication object.
    initialize = function(path = NA, project = NA, parent = NA,
                          filename = NA, overwrite = FALSE, file_size = NA,
                          part_size = getOption("sevenbridges2")$RECOMMENDED_PART_SIZE, # nolint
                          initialized = FALSE, auth = NA) {
      self$upload_id <- NULL
      self$path <- normalizePath(path)
      self$project <- project
      self$parent <- parent
      self$filename <- filename
      self$overwrite <- overwrite

      check_upload_params(size = file_size, part_size = part_size)
      self$part_size <- part_size
      self$file_size <- file_size
      self$part_length <- ifelse(self$file_size == 0, 1,
        as.integer(
          ceiling(self$file_size / self$part_size)
        )
      )

      self$initialized <- initialized
      self$auth <- auth
      self$parts <- private$generate_parts()
    },

    # nocov start
    # Print Upload object ----------------------------------------------------
    #' @description Print method for Upload class.
    #'
    #' @importFrom purrr discard
    #' @importFrom glue glue
    #' @importFrom cli cli_h1 cli_li cli_ul cli_end cli_bullets
    #'
    #' @examples
    #' \dontrun{
    #'  upload_object <- Upload$new(
    #'                     path = "path/to/my/file.txt",
    #'                     project = project_object,
    #'                     auth = auth
    #'                    )
    #'
    #'  # Print the upload object information
    #'  upload_object$print(name = name)
    #' }
    #'
    print = function() {
      x <- as.list(self)

      x <- purrr::discard(x, .p = is.function)
      x <- purrr::discard(x, .p = is.environment)
      x <- purrr::discard(x, .p = is.null)
      x <- purrr::discard(x, .p = is.list)

      string <- glue::glue("{names(x)}: {x}")

      cli::cli_h1("Upload")
      cli::cli_li(string)
      # Close container elements
      cli::cli_end()
    }, # nocov end

    # Initialize multipart file upload ---------------------------------------
    #' @description Initialize a new multipart file upload.
    #'
    #' @importFrom glue glue glue_col
    #' @importFrom rlang abort
    #'
    #' @examples
    #' \dontrun{
    #'  upload_object <- Upload$new(
    #'                     path = "path/to/my/file.txt",
    #'                     project = project_object,
    #'                     auth = auth
    #'                    )
    #'
    #'  # Initialize multipart file upload object
    #'  upload_object$init()
    #' }
    init = function() {
      if (self$initialized) {
        rlang::abort("Upload has already been initialized.")
      }
      # nocov start
      body <- list(
        "name" = self$filename,
        "size" = self$file_size,
        "part_size" = self$part_size
      )
      if (!is_missing(self$project)) {
        body[["project"]] <- self$project
      } else if (!is_missing(self$parent)) {
        body[["parent"]] <- self$parent
      }

      res <- self$auth$api(
        path = glue::glue(self$URL[["init"]]),
        method = "POST",
        query = list(overwrite = self$overwrite),
        body = body
      )

      self$upload_id <- res$upload_id

      if (self$part_size != res$part_size) {
        rlang::inform(
          glue::glue_col(
            "Part size has been set to {blue {res$part_size}} bytes."
          )
        )
      }
      self$part_size <- res$part_size
      check_upload_params(size = self$file_size, part_size = self$part_size)

      self$part_length <- ifelse(self$file_size == 0, 1,
        as.integer(
          ceiling(self$file_size / self$part_size)
        )
      )
      self$parts <- private$generate_parts()
      self$initialized <- TRUE

      rlang::inform(
        glue::glue_col(
          "New upload job is initialized with upload_id:\n {green {self$upload_id}}." # nolint
        )
      )
      return(self)
    }, # nocov end

    # Get details of multipart file upload ------------------------------------
    #' @description Get the details of an active multipart upload.
    #'
    #' @param list_parts If `TRUE`, also return a list of parts
    #' that have been reported as completed for this multipart upload.
    #' Please bear in mind that the output could be heavy for printing if
    #' there are lot of parts.
    #'
    #' @importFrom checkmate assert_logical
    #' @importFrom glue glue
    #'
    #' @examples
    #' \dontrun{
    #'  upload_object <- Upload$new(
    #'                     path = "path/to/my/file.txt",
    #'                     project = project_object,
    #'                     auth = auth
    #'                    )
    #'
    #'  # Get upload job status information
    #'  upload_object$info()
    #' }
    info = function(list_parts = FALSE) {
      if (!self$initialized) {
        rlang::abort("Upload has not been initialized yet.")
      }
      checkmate::assert_logical(list_parts)

      # nocov start
      res <- self$auth$api(
        path = glue::glue(self$URL[["upload_job"]]),
        method = "GET",
        query = list(list_parts = list_parts)
      )


      fields_to_show <- c(
        "upload_id", "project", "parent",
        "name", "initiated", "part_size",
        "uploaded_parts_count"
      )
      to_print <- c(
        res[fields_to_show],
        "total_number_of_parts" = self$part_length
      )

      if (list_parts) {
        c(to_print, "parts" = res[["parts"]])
      } else {
        to_print
      }
    }, # nocov end

    # Start multipart file upload --------------------------------------------
    #' @description Start the file upload
    #'
    #' @importFrom rlang abort
    #' @importFrom httr PUT headers
    #'
    #' @examples
    #' \dontrun{
    #'  upload_object <- Upload$new(
    #'                     path = "path/to/my/file.txt",
    #'                     project = project_object,
    #'                     auth = auth
    #'                    )
    #'
    #'  # Initialize multipart file upload object
    #'  upload_object$init()
    #'
    #'  # Start upload process
    #'  upload_object$start()
    #' }
    #'
    #' @return \code{\link{File}} object.
    start = function() {
      if (!self$initialized) {
        rlang::abort("Upload has not been initialized yet.")
      }
      # nocov start
      N <- self$part_length
      pb <- txtProgressBar(min = 0, max = N, style = 3)
      .start <- Sys.time()
      con <- file(self$path, "rb")

      for (i in 1:N) {
        current_part <- self$parts[[i]]
        current_part <- current_part$upload_info_part(self$upload_id)
        url <- current_part$url

        res <- httr::PUT(
          url = url,
          body = readBin(con, "raw", current_part$part_size)
        )
        current_part$etag <- httr::headers(res)$etag

        current_part$upload_complete_part(self$upload_id)
        self$parts[[i]] <- current_part
        setTxtProgressBar(pb, i)
      }
      close(pb)

      res <- private$upload_complete_all()
      close(con)

      .end <- Sys.time()
      .diff <- .end - .start
      rlang::inform(
        paste0(
          "File uploading complete in: ",
          ceiling(as.numeric(.diff)), " ", attr(.diff, "unit")
        )
      )
      rlang::inform(
        paste0(
          "Estimated upload speed: ",
          ceiling(self$file_size / 1024 / 1024 / as.numeric(.diff)),
          " Mb/", attr(.diff, "unit")
        )
      )

      # Return newly uploaded file
      return(asFile(res, auth = self$auth))
    }, # nocov end

    # Abort multipart file upload --------------------------------------------
    #' @description Abort the multipart upload
    #' This call aborts an ongoing upload.
    #'
    #' @importFrom glue glue glue_col
    #' @importFrom rlang abort
    #'
    #' @examples
    #' \dontrun{
    #'  upload_object <- Upload$new(
    #'                     path = "path/to/my/file.txt",
    #'                     project = project_object,
    #'                     auth = auth
    #'                    )
    #'
    #'  # Abort upload process
    #'  upload_object$abort()
    #' }
    abort = function() {
      if (!self$initialized) {
        rlang::abort("Upload has not been initialized yet.")
      }
      # nocov start
      res <- self$auth$api(
        path = glue::glue(self$URL[["upload_job"]]),
        method = "DELETE"
      )

      rlang::inform(
        glue::glue_col("The upload process with the following ID {green {upload_id}} has been aborted.") # nolint
      )

      # Reset fields that will enable
      # the user to initialize the upload again
      self$upload_id <- NULL
      self$parts <- private$generate_parts()
      self$initialized <- FALSE
    } # nocov end
  ),
  private = list(
    # Helper method that returns list of objects of class `Part` -------------
    generate_parts = function() {
      if (self$part_length > 1) {
        # nolint start
        last_part_size <- self$file_size - self$part_size * (self$part_length - 1)
        # nolint end
        vector_of_part_sizes <- c(
          rep(self$part_size, (self$part_length - 1)),
          last_part_size
        )
      } else {
        vector_of_part_sizes <- self$part_size
      }
      part_numbers <- seq_len(self$part_length)
      parts <- lapply(part_numbers, function(idx) {
        Part$new(
          part_number = idx,
          part_size = vector_of_part_sizes[idx],
          auth = self$auth
        )
      })
      return(parts)
    },

    # nocov start
    # Complete a multipart upload --------------------------------------------
    # This call must be issued to report the completion of a file upload.
    upload_complete_all = function() {
      all_parts <- lapply(self$parts, function(part) {
        list(
          part_number = part$part_number,
          response = list(headers = list(ETag = part$etag))
        )
      })
      body <- list(parts = all_parts)
      res <- self$auth$api(
        path = glue::glue(self$URL[["upload_complete_all"]]),
        method = "POST",
        body = body
      )

      res
    } # nocov end
  )
)


# nolint start
#' @title R6 Class representing a part of the uploading file
#'
#' @description
#' R6 Class representing a resource for managing parts of the files' uploads.
#'
#' @importFrom R6 R6Class
#'
#' @export
Part <- R6::R6Class(
  # nolint end
  "Part",
  portable = FALSE,
  public = list(
    #' @field URL List of URL endpoints for this resource.
    URL = list(
      "part_info" = "upload/multipart/{upload_id}/part/{self$part_number}",
      "complete_part" = "upload/multipart/{upload_id}/part"
    ),
    #' @field part_number Part number.
    part_number = NULL,
    #' @field part_size Part size.
    part_size = NULL,
    #' @field url The URL to which to make the HTTP part upload request.
    url = NULL,
    #' @field expires ISO 8601 combined date and time representation
    #'  in Coordinated Universal Time (UTC) by when the HTTP
    #'  part upload request should be made.
    expires = NULL,
    #' @field headers A map of headers and values that should be
    #'  set when making the HTTP part upload request.
    headers = NULL,
    #' @field success_codes A list of status codes returned by
    #'  the HTTP part upload request that should be recognized as success.
    #'  A successful part upload request should be reported back
    #'  to the API in a call to report an uploaded file part by
    #'  passing the information collected from the report object.
    success_codes = NULL,
    #' @field report Report object.
    report = NULL,
    #' @field etag ETag received after starting a part upload.
    etag = NULL,
    #' @field auth Authentication object.
    auth = NULL,
    #' @field response Response object.
    response = NULL,

    # Initialize Part object --------------------------------------------------
    #' @description Create a new Part object.
    #'
    #' @param part_number Part number.
    #' @param part_size Part size.
    #' @param url The URL to which to make the HTTP part upload request.
    #' @param expires Combined date and time representation
    #'  in UTC by when the HTTP part upload request should be made.
    #' @param headers A map of headers and values that should be
    #'  set when making the HTTP part upload request.
    #' @param success_codes A list of status codes returned by
    #'  the HTTP part upload request that should be recognized as success.
    #' @param report Report object.
    #' @param etag ETag received after starting a part upload.
    #' @param auth Seven Bridges Authentication object.
    initialize = function(part_number = NA, part_size = NA,
                          url = NA, expires = NA, headers = NA,
                          success_codes = NA, report = NA,
                          etag = NA, auth = NA) {
      self$part_number <- part_number
      self$part_size <- part_size
      self$url <- url
      self$expires <- expires
      self$headers <- headers
      self$success_codes <- success_codes
      self$report <- report
      self$etag <- etag
      self$auth <- auth
    },

    # nocov start
    # Print Part object ----------------------------------------------------
    #' @description Print method for Part class.
    #'
    #' @importFrom purrr discard
    #' @importFrom glue glue
    #' @importFrom cli cli_h1 cli_li cli_ul cli_end cli_bullets
    #'
    #' @examples
    #' \dontrun{
    #'  upload_part_object <- Part$new(
    #'                         part_number = part_number,
    #'                         part_size = part_size,
    #'                         auth = auth
    #'                       )
    #'
    #'  # Print upload part information
    #'  upload_part_object$print()
    #' }
    print = function() {
      x <- as.list(self)

      x <- purrr::discard(x, .p = is.function)
      x <- purrr::discard(x, .p = is.environment)
      x <- purrr::discard(x, .p = is.null)
      x <- purrr::discard(x, .p = is.list)

      string <- glue::glue("{names(x)}: {x}")

      cli::cli_h1("Part")
      cli::cli_li(string)
      # Close container elements
      cli::cli_end()
    }, # nocov end

    # Get upload part info ----------------------------------------------------
    #' @description Get upload part info.
    #'
    #' @param upload_id Upload object or ID of the upload process to which the
    #'  part belongs.
    #'
    #' @importFrom glue glue
    #'
    #' @examples
    #' \dontrun{
    #'  upload_part_object <- Part$new(
    #'                         part_number = part_number,
    #'                         part_size = part_size,
    #'                         auth = auth
    #'                       )
    #'
    #'  # Get upload part status information
    #'  upload_part_object$upload_info_part(upload_id = upload_id)
    #' }
    upload_info_part = function(upload_id) {
      upload_id <- check_and_transform_id(upload_id, "Upload")
      # nocov start
      res <- self$auth$api(
        path = glue::glue(self$URL[["part_info"]]),
        method = "GET"
      )
      self$url <- res$url
      self$etag <- res$etag
      self$expires <- res$expires
      self$success_codes <- res$success_codes
      self$headers <- res$headers
      self$report <- res$report
      self$response <- attr(res, "response")
      self
    }, # nocov end

    # Report about uploaded part --------------------------------------------
    #' @description Report an uploaded part.
    #'
    #' @param upload_id Upload object or ID of the upload process that part
    #'  belongs to.
    #'
    #' @importFrom glue glue
    #'
    #' @examples
    #' \dontrun{
    #'  upload_part_object <- Part$new(
    #'                         part_number = part_number,
    #'                         part_size = part_size,
    #'                         auth = auth
    #'                       )
    #'
    #'  # Report an uploaded part
    #'  upload_part_object$upload_complete_part(upload_id = upload_id)
    #' }
    upload_complete_part = function(upload_id) {
      upload_id <- check_and_transform_id(upload_id, "Upload")
      # nocov start
      body <- list(
        part_number = self$part_number,
        response = list(headers = list(ETag = self$etag))
      )

      res <- self$auth$api(
        path = glue::glue(self$URL[["complete_part"]]),
        method = "POST",
        body = body
      )
    } # nocov end
  )
)
