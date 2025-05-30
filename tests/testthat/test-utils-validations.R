testthat::test_that("Function check_tags throws an error if the provided tags
                    argument is not a list", {
  # nolint start
  testthat::expect_error(
    check_tags(tags = "test_tag"),
    regexp = "Tags parameter must be an unnamed list of tags. For example: tags <- list('my_tag_1', 'my_tag_2')",
    fixed = TRUE
  )
  # nolint end
})

testthat::test_that("Function check_settings throws error when expected", {
  # Check if the function throws an error if settings argument is not a list
  testthat::expect_error(
    check_settings(settings = "test_string"),
    regexp = "Settings must be provided as a list.",
    fixed = TRUE
  )
  # Check if it throws an appropriate error if the provided settings list
  # contains an element with invalid name
  testthat::expect_error(
    check_settings(settings = list(
      locked = FALSE,
      controlled = FALSE,
      width = 10L
    )),
    regexp = "Argument width is not a valid settings field.",
    fixed = TRUE
  )

  # Check if the function check_settings throws an error when settings list
  # elements have invalid types
  valid_input_names <- c(
    "locked", "controlled", "use_interruptible_instances",
    "use_memoization", "allow_network_access",
    "use_elastic_disk", "location", "intermediate_files"
  )

  settings_field_types <- list(
    locked = "logical",
    controlled = "logical",
    use_interruptible_instances = "logical",
    use_memoization = "logical",
    allow_network_access = "logical",
    location = "character",
    intermediate_files = "list"
  )

  for (field in names(settings_field_types)) {
    # provide settings as a list with a field containing some invalid value
    # (for example, integer)
    input_list <- list()
    input_list[[field]] <- 10L
    # nolint start
    testthat::expect_error(
      check_settings(settings = input_list),
      regexp = glue::glue("Assertion on '{field}' failed: Must be of type '{settings_field_types[field]}' (or 'NULL'), not 'integer'."),
      fixed = TRUE
    )
    # nolint end

    if (field == "intermediate_files") {
      # check error message if retention field is not valid (not character)
      input_intermediate_files <- list(
        intermediate_files = list(retention = 15L)
      )
      # nolint start
      testthat::expect_error(
        check_settings(settings = input_intermediate_files),
        regexp = glue::glue("Assertion on 'intermediate_files$retention' failed: Must be of type 'character' (or 'NULL'), not '{typeof(input_intermediate_files$intermediate_files$retention)}'."),
        fixed = TRUE
      )
      # nolint end

      # check error message if duration field is not valid (not character)
      input_intermediate_files <- list(
        intermediate_files =
          list(duration = "24")
      )
      # nolint start
      testthat::expect_error(
        check_settings(settings = input_intermediate_files),
        regexp = glue::glue("Assertion on 'intermediate_files$duration' failed: Must be of type 'integer' (or 'NULL'), not '{typeof(input_intermediate_files$intermediate_files$duration)}'."),
        fixed = TRUE
      )
      # nolint end
    }
  }
})

test_that("check_limit function passes when limit is valid", {
  testthat::expect_silent(check_limit(limit = 5L))
  testthat::expect_silent(check_limit(limit = 56))
})

test_that("check_limit function throws error when limit is not valid", {
  negative_limit <- list(limit = -1)
  string_limit <- list(limit = "limit")
  big_limit <- list(limit = 1500)

  testthat::expect_error(
    do.call(check_limit, negative_limit),
    regexp = "Limit must be integer number between 1 and 100.",
    fixed = TRUE
  )
  testthat::expect_error(
    do.call(check_limit, string_limit),
    regexp = "Limit must be integer number between 1 and 100.",
    fixed = TRUE
  )
  testthat::expect_error(
    do.call(check_limit, big_limit),
    regexp = "Limit must be integer number between 1 and 100.",
    fixed = TRUE
  )
})

test_that("check_offset function passes when offset is valid", {
  testthat::expect_silent(check_offset(offset = 1L))
  testthat::expect_silent(check_offset(offset = 90))
})

test_that("check_offset function throws error when offset is not valid", {
  negative_offset <- list(offset = -10)
  string_offset <- list(offset = "offset")

  testthat::expect_error(
    do.call(check_offset, negative_offset),
    regexp = "Offset must be integer number >= 0.",
    fixed = TRUE
  )
  testthat::expect_error(
    do.call(check_offset, string_offset),
    regexp = "Offset must be integer number >= 0.",
    fixed = TRUE
  )
})

test_that("check_folder_name function works", {
  testthat::expect_silent(check_folder_name(name = "New_folder"))
  testthat::expect_silent(check_folder_name(name = "MyFolder"))
})

test_that("check_folder_name function throws error when expected", {
  missing_name <- list(name = NULL)
  int_name <- list(name = 123)
  invalid_start_name <- list(name = "__inputs")
  spaces_in_name <- list(name = "Another new folder")

  testthat::expect_error(
    do.call(check_folder_name, missing_name),
    regexp = "Please provide the folder's name.",
    fixed = TRUE
  )
  testthat::expect_error(
    do.call(check_folder_name, int_name),
    regexp = "Assertion on 'name' failed: Must be of type 'string', not 'double'.", # nolint
    fixed = TRUE
  )
  testthat::expect_error(
    do.call(check_folder_name, invalid_start_name),
    regexp = "The folder name cannot start with \"__\"",
    fixed = TRUE
  )
  testthat::expect_error(
    do.call(check_folder_name, spaces_in_name),
    regexp = "The folder name cannot contain spaces.",
    fixed = TRUE
  )
})

test_that("check_metadata function throws error when metadata is not valid", {
  missing_metadata <- list(metadata = list(NULL))
  string_metadata <- list(metadata = "test")
  int_metadata <- list(metadata = 123)
  # nolint start
  msg <- "Metadata parameter must be a named list of key-value pairs. For example: metadata <- list(metadata_key_1 = 'metadata_value_1', metadata_key_2 = 'metadata_value_2')"
  # nolint end
  testthat::expect_error(
    do.call(check_metadata, missing_metadata),
    regexp = msg,
    fixed = TRUE
  )
  testthat::expect_error(
    do.call(check_metadata, string_metadata),
    regexp = msg,
    fixed = TRUE
  )
  testthat::expect_error(
    do.call(check_metadata, int_metadata),
    regexp = msg,
    fixed = TRUE
  )
})

test_that("transform_multiple_vals function works", {
  # Test with metadata example
  metadata_values <- list(
    metadata.disease_type = "Acute Myeloma",
    metadata.sample_id = "some-id",
    metadata.metadata_field = c("some other value1", "some-value2")
  )
  transformed_metadata <- transform_multiple_vals(metadata_values)
  testthat::expect_equal(length(names(transformed_metadata)), 4)

  testthat::expect_true(names(transformed_metadata)[3] == names(transformed_metadata)[4]) # nolint
  testthat::expect_equal(transformed_metadata[[1]], "Acute%20Myeloma")
  testthat::expect_equal(transformed_metadata[[2]], metadata_values[[2]])
  testthat::expect_equal(transformed_metadata[[3]], "some%20other%20value1")

  # Test with tags example
  tags_values <- list(tags = list("index files", "suggested"))

  transformed_tags <- transform_multiple_vals(tags_values)
  testthat::expect_equal(length(names(transformed_tags)), 2)
  testthat::expect_equal(transformed_tags[[1]], "index%20files")
  testthat::expect_equal(transformed_tags[[2]], "suggested")
})

test_that("check_download_path function throws error when parameters are not valid", { # nolint
  # Negative test use case for directory_path parameter
  testthat::expect_error(
    check_download_path(
      directory_path = "non-existent-directory"
    ),
    "Destination directory non-existent-directory does not exist."
  )

  # Negative test use cases for filename parameter
  # 1) is_missing returns TRUE
  filename_invalid_values <- c(NA, NULL)
  for (filename in filename_invalid_values) {
    testthat::expect_error(
      check_download_path(directory_path = tempdir(), filename = filename),
      "The filename parameter is missing."
    )
  }
  # 2) is_missing returns FALSE, but the filename parameter value is not valid
  filename_invalid_values <- list(
    15L,
    c("test_file_1.txt", "test_file_2.txt"),
    list("test_file.txt")
  )
  for (filename in filename_invalid_values) {
    testthat::expect_error(
      check_download_path(directory_path = tempdir(), filename = filename),
      "The filename parameter should be a length-one string."
    )
  }
})

test_that("check_retry_count function throws error when count is invalid", {
  # Negative test use cases for count parameter
  invalid_retry_count <- c(-1, "retry", 0, FALSE)
  for (retry_count in invalid_retry_count) {
    testthat::expect_error(
      check_retry_params(
        input = retry_count,
        parameter_to_validate = "count"
      ),
      "retry_count parameter must be a positive integer number."
    )
  }
})

test_that("check_retry_params function throws error when timeout is not valid", { # nolint
  # Negative test use cases for timeout parameter
  invalid_retry_timeout <- c(-1, "retry", 0, FALSE)
  for (retry_timeout in invalid_retry_timeout) {
    testthat::expect_error(
      check_retry_params(
        input = retry_timeout,
        parameter_to_validate = "timeout"
      ),
      "retry_timeout parameter must be a positive integer number."
    )
  }
})

test_that("check_app_copy_strategy function throws error when provided strategy is invalid", { # nolint
  # Negative test use cases for missing strategy parameter
  testthat::expect_error(
    check_app_copy_strategy(
      strategy = NULL
    ),
    "Please provide the copy strategy"
  )

  # Negative test use case for invalid strategy parameter
  # Valid values: clone, direct_clone, direct, transient
  supported_app_copy_strategies <- getOption("sevenbridges2")$APP_COPY_STRATEGIES # nolint

  invalid_strategy_param <- "test_strategy"

  testthat::expect_error(
    check_app_copy_strategy(
      strategy = invalid_strategy_param
    ),
    label = "The provided copy strategy (test_strategy) is not supported. Please use one of the following strategies: clone, direct, clone_direct, transient" # nolint
  )
})


test_that("check_file_path function throws error when provided file_path parameter is not valid", { # nolint
  # Negative test use case for invalid file_path parameter
  invalid_file_path <- "/path/to/nonexisting-file.cwl"

  testthat::expect_error(
    check_file_path(
      file_path = invalid_file_path
    ),
    label = "File {magenta /path/to/nonexisting-file.cwl} does not exist."
  )
})

test_that("check_volume_params works", {
  # Pass invalid args, volume_type
  testthat::expect_error(check_volume_params(args = NULL))
  testthat::expect_error(check_volume_params(
    args = list("arg1" = "arg1"),
    volume_type = "some-other-type"
  ))

  # Test with valid params
  valid_args <- list(
    name = "volume_name",
    bucket = "bucket_name",
    prefix = "",
    access_mode = "RW",
    description = NULL,
    properties = list("some-property" = "value"),
    endpoint = "some-endpoint",
    root_url = "some-url",
    credentials = list("key" = "just-string")
  )
  testthat::expect_no_error(check_volume_params(args = valid_args))

  # Create invalid params list
  invalid_args <- list(
    name = 123,
    bucket = list("some-name"),
    container = list("some-container"),
    prefix = NA,
    access_mode = "some-other",
    description = FALSE,
    properties = c("some-property" = "value"),
    endpoint = list("some-endpoint"),
    root_url = TRUE,
    credentials = "just-string"
  )

  # Pass invalid name
  testthat::expect_error(check_volume_params(args = invalid_args["name"]))
  # Pass invalid bucket (volume_type = s3)
  testthat::expect_error(
    check_volume_params(args = c(valid_args["name"], invalid_args["bucket"]))
  )
  # Pass invalid container (volume_type = azure)
  testthat::expect_error(
    check_volume_params(
      volume_type = "azure",
      args = c(valid_args["name"], invalid_args["container"])
    )
  )
  # Pass invalid prefix
  testthat::expect_error(
    check_volume_params(args = c(
      valid_args["name"],
      valid_args["bucket"],
      invalid_args["prefix"]
    ))
  )
  # Pass invalid access_mode
  testthat::expect_error(
    check_volume_params(args = c(
      valid_args["name"],
      valid_args["bucket"],
      invalid_args["access_mode"]
    ))
  )
  # Pass invalid description
  testthat::expect_error(
    check_volume_params(args = c(
      valid_args["name"],
      valid_args["bucket"],
      invalid_args["description"]
    ))
  )
  # Pass invalid properties
  testthat::expect_error(
    check_volume_params(args = c(
      valid_args["name"],
      valid_args["bucket"],
      invalid_args["properties"]
    ))
  )
  # Pass invalid endpoint
  testthat::expect_error(
    check_volume_params(args = c(
      valid_args["name"],
      valid_args["bucket"],
      invalid_args["endpoint"]
    ))
  )
  # Pass invalid root_url
  testthat::expect_error(
    check_volume_params(args = c(
      valid_args["name"],
      valid_args["bucket"],
      invalid_args["root_url"]
    ))
  )
})

test_that("transform_configuration_param works", {
  # Provide configuration as valid list
  config_list <- list(
    "field1" = "value1",
    "field2" = 123,
    "field3" = list(
      "subfield" = "subfield-value"
    ),
    "field4" = "something"
  )
  transformed_str <- transform_configuration_param(configuration = config_list)
  testthat::expect_type(transformed_str, "character")
  testthat::expect_true(startsWith(transformed_str, prefix = "{\n"))

  # Provide configuration as path to JSON file
  config_json_path <- testthat::test_path(
    file.path("test_data", "volumes_configuration_params.json")
  )

  testthat::skip_on_ci()
  transformed_str <- transform_configuration_param(configuration = config_json_path) # nolint
  testthat::expect_type(transformed_str, "character")
  testthat::expect_true(startsWith(transformed_str, prefix = "{\n"))
})

test_that("transform_configuration_param throws error when needed", {
  # Provide configuration as NULL
  testthat::expect_error(
    transform_configuration_param(configuration = NULL),
    regexp = "Invalid configuration parameter! \n Please provide a string path to the JSON file or a named list.", # nolint
    fixed = TRUE
  )

  # Provide configuration as empty list
  testthat::expect_error(
    transform_configuration_param(configuration = list()),
    regexp = "Invalid configuration parameter! \n Please provide a string path to the JSON file or a named list.", # nolint
    fixed = TRUE
  )

  # Provide configuration as unnamed list
  testthat::expect_error(
    transform_configuration_param(configuration = list("unnamed list")),
    regexp = "Invalid configuration parameter! \n Please provide a string path to the JSON file or a named list.", # nolint
    fixed = TRUE
  )

  # Provide configuration as invalid json path
  config_path <- file.path("unnoun", "path", "to", "file.json")
  testthat::expect_error(
    transform_configuration_param(configuration = config_path)
  )

  # Provide configuration as non-string type
  testthat::expect_error(
    transform_configuration_param(configuration = c("field1", "field2"))
  )
})

test_that("check_upload_params throws error when needed", {
  too_big_size <- getOption("sevenbridges2")$MAXIMUM_OBJECT_SIZE + 1
  too_big_part_size <- getOption("sevenbridges2")$MAXIMUM_PART_SIZE + 1
  too_small_part_size <- getOption("sevenbridges2")$MINIMUM_PART_SIZE - 1

  # Setup test parameters for test
  test_no_size <- list(size = NULL, part_size = 1000)
  test_bad_size <- list(size = "Bad_size", part_size = 1000)
  test_negative_size <- list(size = -5, part_size = 1000)
  test_too_big_size <- list(size = too_big_size, part_size = 1000)

  test_no_part_size <- list(size = 1000, part_size = NULL)
  test_bad_part_size <- list(size = 1000, part_size = "Bad_size")
  test_negative_part_size <- list(size = 1000, part_size = -1000)
  test_too_big_part_size <- list(size = 1000, part_size = too_big_part_size)
  test_too_small_part_size <- list(size = 1000, part_size = too_small_part_size)

  # Edge case for part length
  part_size <- getOption("sevenbridges2")$MINIMUM_PART_SIZE
  size <- (part_size * getOption("sevenbridges2")$MAXIMUM_TOTAL_PARTS) + getOption("sevenbridges2")$MINIMUM_PART_SIZE # nolint
  test_bad_part_length <- list(size = size, part_size = part_size)

  # Fails when no size is provided
  testthat::expect_error(do.call(check_upload_params, test_no_size))

  # Fails when bad size is provided
  testthat::expect_error(do.call(check_upload_params, test_bad_size))

  # Fails when negative size is provided
  testthat::expect_error(do.call(check_upload_params, test_negative_size))

  # Fails when too big size is provided
  testthat::expect_error(
    do.call(check_upload_params, test_too_big_size),
    regexp = "File size must be between 0 - 5497558138880 (5TB), inclusive",
    fixed = TRUE
  )

  # Fails when no part size is provided
  testthat::expect_error(do.call(check_upload_params, test_no_part_size))

  # Fails when bad part size is provided
  testthat::expect_error(do.call(check_upload_params, test_bad_part_size))

  # Fails when negative part size is provided
  testthat::expect_error(do.call(check_upload_params, test_negative_part_size))

  # Fails when too big part size is provided
  testthat::expect_error(
    do.call(check_upload_params, test_too_big_part_size),
    regexp = "Parameter part_size must be 5 MB to 5 GB, last part can be < 5 MB", # nolint
    fixed = TRUE
  )

  # Fails when too small part size is provided
  testthat::expect_error(
    do.call(check_upload_params, test_too_small_part_size),
    regexp = "Parameter part_size must be 5 MB to 5 GB, last part can be < 5 MB", # nolint
    fixed = TRUE
  )

  # Fails when part length is too big
  testthat::expect_error(
    do.call(check_upload_params, test_bad_part_length),
    regexp = "Total number of parts must be from 1 to 10,000 (inclusive). Please modify part_size.", # nolint
    fixed = TRUE
  )
})

test_that("check_and_transform_datetime works as expected", {
  # Fails when no datetime is provided
  testthat::expect_error(check_and_transform_datetime(),
    regexp = "Date is required!",
    fixed = TRUE
  )

  # Check if character returns character back
  time <- "2016-04-01 14:25:50"
  testthat::expect_equal(check_and_transform_datetime(time),
    expected = "2016-04-01 14:25:50"
  )

  # Check if Date/time  returns character back
  time <- as.POSIXct("2016-04-01 14:25:50", tz = "UTC")
  testthat::expect_equal(check_and_transform_datetime(time),
    expected = "2016-04-01 14:25:50"
  )
})

# nolint start
test_that("check_and_process_file_details throws error for invalid name type", {
  file_with_wrong_name <- list2env(as.list(setup_file_obj), envir = new.env())
  file_with_wrong_name$name <- 123

  testthat::expect_error(
    check_and_process_file_details(file_with_wrong_name),
    regexp = "Assertion on 'file$name' failed: Must be of type 'string', not 'double'.",
    fixed = TRUE
  )
})

test_that("check_and_process_file_details throws error for invalid tags type", {
  file_with_invalid_tags <- list2env(as.list(setup_file_obj), envir = new.env())
  file_with_invalid_tags$tags <- "test-tag"

  testthat::expect_error(
    check_and_process_file_details(file_with_invalid_tags),
    regexp = "Assertion on 'file$tags' failed: Must be of type 'list', not 'character'.",
    fixed = TRUE
  )
})

test_that("check_and_process_file_details throws error for invalid metadata type", {
  file_with_invalid_metadata <- list2env(as.list(setup_file_obj), envir = new.env())
  file_with_invalid_metadata$metadata <- c("sample_id", "acdc")

  testthat::expect_error(
    check_and_process_file_details(file_with_invalid_metadata),
    regexp = "Assertion on 'file$metadata' failed: Must be of type 'list', not 'character'.",
    fixed = TRUE
  )
})

test_that("check_and_process_file_details works as expected", {
  # Call the function with a valid File object
  result <- check_and_process_file_details(setup_file_obj)

  # Create the expected result list
  expected_result <- list(
    id = "file-id",
    name = "File name",
    tags = list("tag_1"),
    metadata = list(
      sbg_public_files_category = "test",
      reference_genome = "HG19_Broad_variant",
      sample_id = "HCC1143_1M",
      case_id = "CCLE-HCC1143",
      investigation = "CCLE-BRCA"
    )
  )

  # Check that the result is a list
  testthat::expect_type(result, "list")

  # Check that the result matches the expected result
  testthat::expect_equal(result, expected_result)
})
# nolint end

test_that("check_response_and_notify_user throws an error when expected", {
  test_valid_files_param <- list("file_id_1", "file_id_2", "file_id_3")
  test_valid_res_param <- list(items = list(
    list(error = list(status = 404, code = 5002, message = "Requested file does not exist.")), # nolint
    list(resource = list(id = "file_id_2")),
    list(error = list(status = 404, code = 5002, message = "Requested file does not exist.")) # nolint
  ))

  # Fails when no files are provided
  testthat::expect_error(check_response_and_notify_user(res = test_valid_res_param), # nolint
    regexp = "Files parameter is required.",
    fixed = TRUE
  )

  # Fails when res parameter is not provided
  testthat::expect_error(check_response_and_notify_user(files = test_valid_files_param), # nolint
    regexp = "Res parameter is required.",
    fixed = TRUE
  )

  # Fails when bad files parameter is provided (list of numeric values)
  test_bad_files_param_1 <- list(1, 2, 3)
  testthat::expect_error(
    check_response_and_notify_user(files = test_bad_files_param_1, res = test_valid_res_param), # nolint
    regexp = "Assertion on 'files' failed: May only contain the following types: {character}, but element 1 has type 'numeric'.", # nolint
    fixed = TRUE
  )

  # Fails when bad files parameter is provided (vector of strings)
  test_bad_files_param_2 <- c("file_1_id", "file_2_id", "file_3_id")
  testthat::expect_error(
    check_response_and_notify_user(files = test_bad_files_param_2, res = test_valid_res_param), # nolint
    regexp = "Assertion on 'files' failed: Must be of type 'list', not 'character'.", # nolint
    fixed = TRUE
  )

  # Fails when bad res parameter is provided
  test_bad_res_param <- 42
  testthat::expect_error(
    check_response_and_notify_user(files = test_valid_files_param, res = test_bad_res_param), # nolint
    regexp = "Assertion on 'res' failed: Must be of type 'list', not 'double'.", # nolint
    fixed = TRUE
  )
})

test_that("check_response_and_notify_user works as expected", {
  files <- list("file_id_1", "file_id_2", "file_id_3")
  res <- list(items = list(
    list(error = list(status = 404, code = 5002, message = "Requested file does not exist.")), # nolint
    list(resource = list(id = "file_id_2")),
    list(error = list(status = 404, code = 5002, message = "Requested file does not exist.")) # nolint
  ))

  # Generates the expected console output
  testthat::skip_on_ci()
  testthat::skip_on_cran()
  testthat::expect_snapshot(check_response_and_notify_user(files, res))
})
