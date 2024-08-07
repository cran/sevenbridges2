testthat::test_that("Utility function parse_time works", {
  testthat::skip_on_ci()
  testthat::skip_on_cran()
  # unix timestamp doesn't contain the information about milliseconds
  test_unix_timestamp <- 1489700093

  human_readable_date <- parse_time(test_unix_timestamp,
    origin = "1970-01-01",
    time_zone = "GMT"
  )

  testthat::expect_equal(human_readable_date, "2017-03-16 21:34:53 GMT",
    label = "Epoch conversion to human-readable date went wrong."
  )

  # unix timestamp contains the information about milliseconds
  test_unix_timestamp <- 2555971200000

  human_readable_date <- parse_time(test_unix_timestamp,
    origin = "1970-01-01",
    time_zone = "GMT", use_milliseconds = TRUE
  )

  testthat::expect_equal(human_readable_date, "2050-12-30 GMT",
    label = "Epoch conversion to human-readable date went wrong."
  )

  # unix timestamp is missing
  test_unix_timestamp <- NA

  human_readable_date <- parse_time(test_unix_timestamp,
    origin = "1970-01-01",
    time_zone = "", use_milliseconds = TRUE
  )

  testthat::expect_equal(human_readable_date, "unknown",
    label = "Epoch conversion to human-readable date went wrong."
  )

  # Setup test params for testing
  bad_reset_time_as_unix_epoch <- list(reset_time_as_unix_epoch = "bad")
  bad_origin <- list(
    reset_time_as_unix_epoch = 2555971200000,
    origin = FALSE
  )
  bad_time_zone <- list(
    reset_time_as_unix_epoch = 2555971200000,
    origin = "string",
    time_zone = 1
  )
  bad_use_milliseconds <- list(
    reset_time_as_unix_epoch = 2555971200000,
    origin = "string",
    time_zone = "string",
    use_milliseconds = "bad"
  )

  # Test with bad_reset_time_as_unix_epoch
  testthat::expect_error(
    do.call(parse_time, bad_reset_time_as_unix_epoch)
  )

  # Test with bad_origin
  testthat::expect_error(
    do.call(parse_time, bad_origin)
  )

  # Test with bad_time_zone
  testthat::expect_error(
    do.call(parse_time, bad_time_zone)
  )

  # Test with bad_use_milliseconds
  testthat::expect_error(
    do.call(parse_time, bad_use_milliseconds)
  )
})

testthat::test_that("Utility function flatten_query works", {
  # Load predefined unflattened query params list
  unflattened_query_params_list <- list(
    limit = 50,
    offset = 0,
    fields = list(
      "created_by",
      "name",
      "id"
    )
  )

  # Use the flatten_query function
  flattened_query_params_list <- flatten_query(unflattened_query_params_list)

  # Define the expected output
  expected_resulting_list <- list(
    limit = 50,
    offset = 0,
    fields = "created_by",
    fields = "name",
    fields = "id"
  )

  keys <- names(flattened_query_params_list)

  # Compare two lists
  testthat::expect_equal(
    flattened_query_params_list[keys],
    expected_resulting_list[keys]
  )

  # check with length 1 lists
  unflattened_query_params_list <- list(
    limit = 50,
    offset = 0,
    tags = list("api")
  )
  # Use the flatten_query function
  flattened_query_params_list <- flatten_query(unflattened_query_params_list)

  # Define the expected output
  expected_resulting_list <- list(
    limit = 50,
    offset = 0,
    tags = "api"
  )

  keys <- names(flattened_query_params_list)

  # Compare two lists
  testthat::expect_equal(
    flattened_query_params_list[keys],
    expected_resulting_list[keys]
  )
})

testthat::test_that("Utility function handle_url2 works", {
  # Check call without url and handle
  err <- testthat::expect_error(handle_url2(url = NULL, handle = NULL))
  testthat::expect_equal(
    err$message,
    "Must specify at least one of url or handle."
  )

  # Test output - url provided
  result <- handle_url2(
    url = "https://api.sbgenomics.com/v2/user/",
    query = list(limit = 50, offset = 50)
  )
  testthat::expect_true(!is.null(result$handle))
  testthat::expect_true(checkmate::test_class(result$handle,
    classes = c("handle")
  ))
  testthat::expect_true(checkmate::test_class(result$handle$handle,
    classes = c("curl_handle")
  ))
  testthat::expect_true(!is.null(result$url))
  testthat::expect_equal(
    result$url,
    "https://api.sbgenomics.com/v2/user/?limit=50&offset=50"
  )
})

testthat::test_that("Utility function build_url2 works", {
  # test build_url2 output
  url_test_object <- readRDS(testthat::test_path(
    "test_data",
    "url_test_object.RDS"
  ))

  # apply build_url2 function to generate final url
  resulting_url <- build_url2(url_test_object)

  testthat::expect_equal(
    resulting_url,
    "https://api.sbgenomics.com/v2/user/?limit=50&offset=0"
  )


  # check if the function throws an error if the provided url object contains
  # password without username
  url_test_object <- readRDS(testthat::test_path(
    "test_data",
    "url_test_object_with_password_without_username.RDS"
  ))

  # apply build_url2 function to generate final url
  err <- testthat::expect_error(build_url2(url_test_object))
  testthat::expect_equal(err$message, "Cannot set password without username")
})

testthat::test_that("Utility function set_headers works when authorization = FALSE", { # nolint
  token <- stringi::stri_rand_strings(1, 32, pattern = "[a-z0-9]")

  # Test set_headers when authorization parameter is FALSE (default)
  headers <- set_headers(token = token)

  testthat::expect_equal(typeof(headers), "character",
    label = glue::glue("Headers should be a vector of characters, not
                       {typeof(headers)}.")
  )
  testthat::expect_equal(length(headers),
    3L,
    label = "Headers vector should have three elements: X-SBG-Auth-Token,
    Accept and Content-Type"
  )
  testthat::expect_equal(names(headers), c(
    "X-SBG-Auth-Token", "Accept",
    "Content-Type"
  ),
  label = "Elements in headers vector do not have expected names."
  )
  testthat::expect_equal(unname(headers), c(
    token, "application/json",
    "application/json"
  ),
  label = "Headers elements are not as-expected."
  )
})

testthat::test_that("Utility function set_headers works when authorization = FALSE and advance_access = TRUE", { # nolint
  token <- stringi::stri_rand_strings(1, 32, pattern = "[a-z0-9]")

  # Test set_headers when authorization parameter is FALSE (default)
  headers <- set_headers(token = token, advance_access = TRUE)

  testthat::expect_equal(typeof(headers), "character",
    label = glue::glue("Headers should be a vector of characters, not
                       {typeof(headers)}.")
  )
  testthat::expect_equal(length(headers),
    4L,
    label = "Headers vector should have three elements: X-SBG-Auth-Token,
    Accept, Content-Type and X-SBG-advance-access "
  )
  testthat::expect_equal(names(headers), c(
    "X-SBG-Auth-Token", "Accept",
    "Content-Type",
    "X-SBG-advance-access"
  ),
  label = "Elements in headers vector do not have expected names."
  )
  testthat::expect_equal(unname(headers), c(
    token, "application/json",
    "application/json", "advance"
  ),
  label = "Headers elements are not as-expected."
  )
})

testthat::test_that("Utility function set_headers works when authorization = TRUE", { # nolint
  token <- stringi::stri_rand_strings(1, 32, pattern = "[a-z0-9]")

  # Test set_headers when authorization parameter is TRUE
  headers <- set_headers(
    authorization = TRUE,
    token = token,
    client_info = "info"
  )

  testthat::expect_equal(typeof(headers), "character",
    label = glue::glue("Headers should be a named character vector, not {typeof(headers)}.") # nolint
  )
  testthat::expect_equal(
    length(headers),
    expected = 4,
    label = "Headers should have four values."
  )
  testthat::expect_equal(
    object = names(headers),
    expected = c("Authorization", "Accept", "Content-Type", "User-Agent"),
    label = "The header names should be Authorization, Accept, Content-Type, User-Agent." # nolint
  )
  testthat::expect_equal(
    unname(headers["Authorization"]),
    glue::glue("Bearer {token}"),
    label = "Headers element is not as-expected."
  )
})

testthat::test_that("Utility function set_headers throws an error if token isnot provided", { # nolint
  err <- testthat::expect_error(set_headers(token = NULL))
  testthat::expect_equal(err$message, "Token is missing.")
})


testthat::test_that("Utility function setup_query works", {
  query <- list(limit = 10L, offset = 5L)
  fields <- c("name", "id", "created_by")

  query <- setup_query(
    query = query,
    limit = getOption("sevenbridges2")$limit,
    offset = getOption("sevenbridges2")$offset,
    fields = fields
  )

  # Set expected query list
  expected_query_list <- list(
    limit = 10L,
    offset = 5,
    fields = "name",
    fields = "id",
    fields = "created_by"
  )

  keys <- names(query)

  # Compare the two lists
  testthat::expect_equal(query[keys], expected_query_list[keys])
})

testthat::test_that("Utility function setup_body works", {
  method <- sample(c("POST", "PATCH", "PUT"), 1)

  # Check if the function setup_query throws an error when body is not a list
  test_body <- c(name = "test")
  err <- testthat::expect_error(setup_body(method = method, body = test_body))
  testthat::expect_equal(err$message, "Body should be a list.")

  # Check setup_query function output
  test_body <- readRDS(testthat::test_path(
    "test_data",
    "new_project_body.RDS"
  ))

  testthat::expect_true(is.list(test_body))

  body_param_json <- setup_body(method = method, body = test_body)
  expected_body_json <- readRDS(testthat::test_path(
    "test_data",
    "new_project_expected_body_json.RDS"
  ))
  testthat::expect_equal(body_param_json, expected_body_json)
})

testthat::test_that("Utility function m.fun works", {
  # test output when exact parameter is FALSE, and ignore.case is TRUE
  term <- "api"
  search_through_vector <- c(
    "element 1", "element 2 api", "element 3",
    "element 4 API", "element 5", "element 6", "api", "element 8"
  )

  match_index_vector <- m.fun(
    x = term,
    y = search_through_vector,
    exact = FALSE,
    ignore.case = TRUE
  )

  testthat::expect_equal(
    match_index_vector, c(2, 4, 7)
  ) # unnamed vector of match indexes

  # test output when exact parameter is FALSE, and ignore.case is FALSE
  match_index_vector <- m.fun(
    x = term,
    y = search_through_vector,
    exact = FALSE,
    ignore.case = FALSE
  )

  testthat::expect_equal(
    match_index_vector, c(2, 7)
  ) # unnamed vector of match indexes

  # test output when exact parameter is TRUE, and ignore.case is TRUE
  match_index_vector <- m.fun(
    x = term,
    y = search_through_vector,
    exact = TRUE,
    ignore.case = TRUE
  )

  testthat::expect_equal(match_index_vector, c(7)) # named vector

  # test output when exact parameter is FALSE,
  # and ignore.case is TRUE and there is only one match
  term <- "element 1"

  match_index_vector <- m.fun(
    x = term, y = search_through_vector,
    exact = FALSE, ignore.case = TRUE
  )

  testthat::expect_equal(
    match_index_vector, c(`element 1` = 1)
  ) # named vector of match indexes
})

testthat::test_that("Utility function m.match works", {
  # Test output when exact parameter is FALSE,
  # ignore.case is TRUE (id = NULL and name != NULL)
  search_through_list <- list(
    list(name = "project 1", id = "asdf1234"),
    list(name = "project 2", id = "qwer9876"),
    list(name = "project 3", id = "xyzq2234"),
    list(name = "project 3", id = "mnbv0192"),
    list(name = "project 4", id = "aeio5647")
  )

  matchings <- m.match(
    obj = search_through_list, id = NULL, name = "project 3",
    exact = FALSE, ignore.case = TRUE
  )

  # Set expected matchings list
  expected_matchings <- list(
    list(name = "project 3", id = "xyzq2234"),
    list(name = "project 3", id = "mnbv0192")
  )

  keys <- names(matchings)

  # Compare the two lists
  testthat::expect_equal(matchings[keys], expected_matchings[keys])


  # Test output when exact parameter is FALSE, ignore.case is TRUE
  # (id != NULL and name = NULL)
  search_through_list <- list(
    list(name = "project 1", id = "asdf1234"),
    list(name = "project 2", id = "qwer9876"),
    list(name = "project 3", id = "xyzq2234"),
    list(name = "project 3", id = "mnbv0192"),
    list(name = "project 4", id = "aeio5647")
  )

  matchings <- m.match(
    obj = search_through_list, id = "xyzq2234", name = NULL,
    exact = FALSE, ignore.case = TRUE
  )

  # Set expected matchings list
  expected_matchings <- list(name = "project 3", id = "xyzq2234")

  keys <- names(matchings)

  # Compare the two lists
  testthat::expect_equal(matchings[keys], expected_matchings[keys])

  # Test output when exact parameter is FALSE, and ignore.case is FALSE
  # (no matchings)
  matchings <- m.match(
    obj = search_through_list, id = NULL, name = "PROJECT 3",
    exact = FALSE, ignore.case = FALSE
  )

  testthat::expect_equal(matchings, list())

  # Test output when exact parameter is FALSE, and ignore.case is TRUE
})
# nolint start
testthat::test_that("Utility function check_and_transform_id from objects works", {
  # nolint end
  ## Project class -----
  # Check if function extract ID of instance
  test_project_id <- check_and_transform_id(setup_project_obj, "Project")
  # Is returned id a character vector
  testthat::expect_vector(test_project_id, ptype = character())
  # throws an error if Project instance tried to treat as File
  testthat::expect_error(
    check_and_transform_id(setup_project_obj, "File"),
    "Must inherit from class 'File', but has classes 'Project','Item','R6'."
  )

  ## File class -----
  # Check if function extract ID of instance
  test_file_id <- check_and_transform_id(setup_file_obj, "File")
  # Is returned id a character vector
  testthat::expect_vector(test_file_id, ptype = character())
  # throws an error if File instance tried to treat as a wrong class
  testthat::expect_error(
    check_and_transform_id(setup_file_obj, "Project"),
    "Must inherit from class 'Project', but has classes 'File','Item','R6"
  )

  ## Upload class -----
  # authentication obstacles
  ## Billing class -----
  test_biling_id <- check_and_transform_id(setup_billing_obj, "Billing")
  # Is returned id a character vector
  testthat::expect_vector(test_biling_id, ptype = character())
  # throws an error if billing instance tried to treat as a wrong class
  testthat::expect_error(
    check_and_transform_id(setup_billing_obj, "Project"),
    "Must inherit from class 'Project', but has classes 'Billing','Item','R6'."
  )
})
# nolint start
testthat::test_that("Utility function check_and_transform_id with ID as string works", {
  # nolint end
  valid_id <- c(
    "luna_lovegood/nargles-project",
    "643536f886c9522d97347edd",
    "asdfg123-1234-1234-ab12-7e7e7e777abc"
  )
  for (id in valid_id) {
    testthat::expect_vector(check_and_transform_id(id), ptype = character())
  }
})
# nolint start
test_that("Utility function check_and_transform_id throws error when ID is not valid", {
  # nolint end
  # ID have to be character string
  invalid_id <- c(TRUE, 123)
  for (id in invalid_id) {
    testthat::expect_error(check_and_transform_id(id))
  }
})

test_that("Utility function input_matrix works as expected", {
  simulated_raw_cwl <- list(inputs = setup_app_inputs_list)
  inputs_info <- input_matrix(simulated_raw_cwl)

  testthat::expect_true(
    checkmate::test_class(inputs_info, classes = "data.frame")
  )
  testthat::expect_equal(ncol(inputs_info), 4)
  testthat::expect_equal(nrow(inputs_info), 9)
  testthat::expect_true(
    all(c("id", "label", "type", "required") %in% names(inputs_info))
  )
})

test_that("Utility function make_type works as expected", {
  # Get example of one File type
  file_type <- setup_app_inputs_list[[3]]
  make_type <- make_type(file_type$type)
  testthat::expect_equal(make_type, "File")

  # Get example of one File array type
  file_type <- setup_app_inputs_list[[2]]
  make_type <- make_type(file_type$type)
  testthat::expect_equal(make_type, "File...")

  # Get example of one integer type
  int_type <- setup_app_inputs_list[[5]]
  make_type <- make_type(int_type$type)
  testthat::expect_equal(make_type, "int?")

  # Get example of one enum type
  enum_type <- setup_app_inputs_list[[7]]
  make_type <- make_type(enum_type$type)
  testthat::expect_equal(make_type, "enum")
})

test_that("Utility function find_type works as expected", {
  simple_list_enum <- list("enum")
  testthat::expect_equal(find_type(simple_list_enum), "null")

  simple_list_null <- list("null")
  testthat::expect_equal(find_type(simple_list_null), "null")

  named_list_enum <- list(type = "enum")
  testthat::expect_equal(find_type(named_list_enum), "enum")

  named_list_nested <- list(symbols = list(1, 2, 3))
  testthat::expect_equal(find_type(named_list_nested), "null")

  named_list_string <- list(name = "name")
  testthat::expect_equal(find_type(named_list_string), "null")

  simple_value_null <- "null"
  testthat::expect_equal(find_type(simple_value_null), "null")

  simple_value <- "File"
  testthat::expect_equal(find_type(simple_value), "File")

  simple_list_w_type <- list(type = "array", items = "File")
  testthat::expect_equal(find_type(simple_list_w_type), "File...")

  simple_list_w_type_enum <- list(
    type = "enum",
    symbols = list(1, 2, 3, 4),
    name = "Sample_Tags_Version"
  )
  testthat::expect_equal(find_type(simple_list_w_type_enum), "enum")

  string_vector <- c("null", "File")
  testthat::expect_equal(find_type(string_vector), "File")
})

test_that("Utility function is_required works as expected", {
  # Get example of one optional field with first 'null' value
  example_list <- list(type = list("null", type = "File"))
  testthat::expect_false(is_required(example_list))

  # Get example of one optional field containing ?
  example_string <- list(type = "int?")
  testthat::expect_false(is_required(example_string))

  # Get example of one required field
  example_list <- list(type = list(type = "File"))
  testthat::expect_true(is_required(example_list))

  # Get example of one required field
  example_string <- list(type = "int")
  testthat::expect_true(is_required(example_string))
})

test_that("Utility function output_matrix works as expected", {
  simulated_raw_cwl <- list(outputs = setup_app_outputs_list)
  outputs_info <- output_matrix(simulated_raw_cwl)

  testthat::expect_true(
    checkmate::test_class(outputs_info, classes = "data.frame")
  )
  testthat::expect_equal(ncol(outputs_info), 3)
  testthat::expect_equal(nrow(outputs_info), 11)
  testthat::expect_true(
    all(c("id", "label", "type") %in% names(outputs_info))
  )
})

test_that("Utility function lists_eq works as expected", {
  list2_to_compare <- list1_to_compare
  testthat::expect_true(lists_eq(list1_to_compare, list2_to_compare))
})

test_that("Utility function lists_eq throws error when expected", {
  list2_to_compare <- list1_to_compare
  list2_to_compare$error <- list(error = "error message")

  testthat::expect_false(lists_eq(list1_to_compare, list2_to_compare))

  list3_to_compare <- list1_to_compare
  list3_to_compare$content <- c("123", "345", "4t45")

  testthat::expect_false(lists_eq(list1_to_compare, list3_to_compare))
})
