test_that("Auth initialization works", {
  # Auth object creation works
  testthat::expect_no_error(Auth$new(token = "rand_token", url = "random_url"))

  # Auth object class and methods are set
  checkmate::assert_r6(
    setup_auth_object,
    classes = c("Auth"),
    public = c(
      "from", "platform", "url", "sysenv_url", "sysenv_token",
      "config_file", "profile_name", "fs", "authorization", "projects",
      "files", "apps", "volumes", "tasks", "imports", "exports",
      "invoices", "billing_groups", "projects", "files", "apps", "volumes",
      "tasks", "imports", "exports", "invoices", "billing_groups"
    )
  )
})

testthat::test_that("Init authentication works", {
  # Generate dummy token
  test_token <- stringi::stri_rand_strings(1, 32, pattern = "[a-z0-9]")

  # Create dummy authentication object
  auth <- suppressMessages(
    sevenbridges2::Auth$new(
      from = "direct",
      platform = "aws-us",
      token = test_token
    )
  )

  testthat::expect_true(checkmate::test_class(auth, classes = "Auth"))
  testthat::expect_equal(auth$get_token(), test_token)
  # Check the number of characters in the token written in the env variable
  testthat::expect_equal(nchar(auth$get_token()), 32L)

  # Check if token contains lower cas letters and digits only
  testthat::expect_equal(grepl("^[a-z0-9]+$", auth$get_token()), TRUE)

  # Check auth object fields
  testthat::expect_equal(auth$authorization, FALSE)
  testthat::expect_equal(auth$config_file, NULL)
  testthat::expect_equal(auth$from, "direct")
  testthat::expect_equal(auth$fs, NA)
  testthat::expect_equal(auth$platform, "aws-us")
  testthat::expect_equal(auth$profile_name, NULL)
  testthat::expect_equal(auth$sysenv_token, NULL)
  testthat::expect_equal(auth$sysenv_url, NULL)
  testthat::expect_equal(auth$url, "https://api.sbgenomics.com/v2/")

  # Clear env variable
  Sys.unsetenv("SB_AUTH_TOKEN")


  # Check if the initialization function returns an error if both
  # platform and url are provided
  err <- testthat::expect_error(
    suppressMessages(
      sevenbridges2::Auth$new(
        from = "direct",
        platform = "aws-us",
        token = test_token,
        url = "https://api.sbgenomics.com/v2/"
      )
    )
  )

  expected_error <- "`platform` and `url` cannot be set simultaneously"
  testthat::expect_equal(err$message, expected_error)

  # Check of the initialization method throws no error if neither of
  # those two (platform and url) are provided, because default aws-us is used
  req <- testthat::expect_message(
    sevenbridges2::Auth$new(
      from = "direct",
      platform = NULL,
      token = test_token,
      url = NULL
    ),
    "Using platform: aws-us"
  )

  # Check error message when wrong platform name is provided
  err <- testthat::expect_error(
    suppressMessages(
      sevenbridges2::Auth$new(
        from = "direct",
        platform = "Platform 9¾",
        token = test_token,
        url = NULL
      )
    )
  )
  # nolint start
  expected_error <- "Platform does not exist, please check its spelling (case-sensitive)"
  # nolint end
  testthat::expect_equal(err$message, expected_error)

  # Check error message when token is not provided
  # Check error message when wrong platform name is provided
  err <- testthat::expect_error(
    suppressMessages(
      sevenbridges2::Auth$new(
        from = "direct",
        platform = "aws-us",
        token = NULL,
        url = NULL
      )
    )
  )
  expected_error <- '`token` must be set when `from = "direct"`'
  testthat::expect_equal(err$message, expected_error)
})

testthat::test_that("Init authentication from env works", {
  # Set env variables with sbg_set_env function
  test_sysenv_url_name <- "TEST_AUTH_FROM_ENV_URL_NAME"
  test_sysenv_token_name <- "TEST_AUTH_FROM_ENV_TOKEN_NAME"

  sbg_set_env(
    url = "https://test-url.com/",
    token = stringi::stri_rand_strings(
      n = 1, length = 32,
      pattern = "[a-z0-9]"
    ),
    sysenv_url_name = test_sysenv_url_name,
    sysenv_token_name = test_sysenv_token_name
  )

  # Create dummy authentication object
  auth <- suppressMessages(
    sevenbridges2::Auth$new(
      from = "env",
      sysenv_url = test_sysenv_url_name,
      sysenv_token = test_sysenv_token_name
    )
  )

  testthat::expect_true(checkmate::test_class(auth, classes = "Auth"))

  testthat::expect_equal(auth$get_token(), sbg_get_env(test_sysenv_token_name))
  # Check the number of characters in the token written in the env variable
  testthat::expect_equal(nchar(auth$get_token()), 32L)

  # Check if token contains lower cas letters and digits only
  testthat::expect_equal(grepl("^[a-z0-9]+$", auth$get_token()), TRUE)

  # Check auth object fields
  testthat::expect_equal(auth$authorization, FALSE)
  testthat::expect_equal(auth$config_file, NULL)
  testthat::expect_equal(auth$from, "env")
  testthat::expect_equal(auth$fs, NA)
  testthat::expect_equal(auth$platform, NULL)
  testthat::expect_equal(auth$profile_name, NULL)
  testthat::expect_equal(auth$sysenv_token, test_sysenv_token_name)
  testthat::expect_equal(auth$sysenv_url, test_sysenv_url_name)
  testthat::expect_equal(auth$url, sbg_get_env(test_sysenv_url_name))

  # Clear env variables
  Sys.unsetenv(test_sysenv_url_name)
  Sys.unsetenv(test_sysenv_token_name)
})

testthat::test_that("Init authentication from config file works", {
  # Create dummy authentication object
  auth <- suppressMessages(
    sevenbridges2::Auth$new(
      from = "file",
      config_file = testthat::test_path(
        "test_data",
        "sbg_credentials_test_file"
      ),
      profile_name = "BioDataCatalyst",
      sysenv_url = "TEST_SYSENV_URL_NAME",
      sysenv_token = "TEST_SYSENV_TOKEN_NAME"
    )
  )

  testthat::expect_true(checkmate::test_class(auth, classes = "Auth"))

  testthat::expect_equal(
    auth$get_token(),
    sbg_get_env(paste0(auth$profile_name, "_token"))
  )
  # Check the number of characters in the token written in the env variable
  testthat::expect_equal(nchar(auth$get_token()), 32L)

  # Check if token contains lower cas letters and digits only
  testthat::expect_equal(grepl("^[a-z0-9]+$", auth$get_token()), TRUE)

  # Check auth object fields
  testthat::expect_equal(auth$authorization, FALSE)
  testthat::expect_equal(
    auth$config_file,
    testthat::test_path(
      "test_data",
      "sbg_credentials_test_file"
    )
  )
  testthat::expect_equal(auth$from, "file")
  testthat::expect_equal(auth$fs, NA)
  testthat::expect_equal(auth$platform, "f4c")
  testthat::expect_equal(auth$profile_name, "BioDataCatalyst")

  testthat::expect_equal(
    auth$url,
    sbg_get_env(paste0(auth$profile_name, "_url"))
  )

  # Clear env variables
  Sys.unsetenv(paste0(auth$profile_name, "_token"))
  Sys.unsetenv(paste0(auth$profile_name, "_url"))
})

testthat::test_that("Calling the api method with no arguments returns a list of
                    all API paths", {
  testthat::expect_true(
    checkmate::test_class(setup_auth_object, classes = "Auth")
  )

  testthat::skip_on_ci()
  testthat::skip_on_cran()
  api_paths <- setup_auth_object$api()

  testthat::expect_equal(is.list(api_paths), TRUE)
  testthat::expect_equal(length(api_paths), 12L)

  expected_api_paths <- readRDS(testthat::test_path(
    "test_data",
    "all_api_paths.RDS"
  ))

  keys <- names(api_paths)

  # Compare the two lists
  testthat::expect_equal(api_paths[keys], expected_api_paths[keys])
})

testthat::test_that("Method upload throws error when needed", {
  # Negative cases for various parameters

  # Invalid path
  testthat::expect_error(
    setup_auth_object$upload(path = "non-existing-path/file.txt"),
    "There is no file at the specified path."
  )

  test_upload_file_path <- testthat::test_path("test_data")

  # project and parent both missing
  # nolint start
  testthat::expect_error(
    setup_auth_object$upload(path = test_upload_file_path),
    "Both the project name and parent folder ID are missing. You need to provide one of them."
  )
  # nolint end

  # project and parent both provided
  testthat::expect_error(
    setup_auth_object$upload(
      path = test_upload_file_path,
      project = "luna_lovegood/nargles-project",
      parent = "parent_folder_id"
    ),
    "You should specify a project or a parent folder, not both."
  )

  # Invalid parent param
  invalid_parent_param <- c("", NULL, list(), 232424, NA)
  for (id in invalid_parent_param) {
    testthat::expect_error(
      setup_auth_object$upload(path = test_path, parent = id)
    )
  }

  # Invalid parent param - File object (type File instead of Folder)
  testthat::expect_error(
    setup_auth_object$upload(
      path = test_upload_file_path,
      parent = setup_file_obj
    ),
    "The provided parent object is not a folder."
  )

  # Invalid project param
  invalid_project_obj <- c("", NULL, list(), 232424, NA, setup_file_obj)
  for (id in invalid_project_obj) {
    testthat::expect_error(
      setup_auth_object$upload(
        path = test_upload_file_path,
        project = id
      )
    )
  }

  # Invalid filename param
  invalid_filenames <- list("test file.txt", "test\file.txt")

  for (filename in invalid_filenames) {
    testthat::expect_error(
      setup_auth_object$upload(
        path = test_upload_file_path,
        project = "luna_lovegood/nargles-project",
        filename = filename
      ),
      "The file name cannot contain spaces or backslashes."
    )
  }

  # Test invalid init param
  bad_init <- "init"
  testthat::expect_error(
    setup_auth_object$upload(
      path = test_upload_file_path,
      project = "luna_lovegood/nargles-project",
      init = bad_init
    )
  )

  # Test invalid overwrite param
  bad_overwrite <- "overwrite"
  testthat::expect_error(
    setup_auth_object$upload(
      path = test_upload_file_path,
      project = "luna_lovegood/nargles-project",
      overwrite = bad_overwrite
    )
  )
})

testthat::test_that("Method send_feedback throws error when needed", {
  bad_text <- 123
  bad_type <- "something-else"
  bad_referrer <- 123

  # Test with invalid feedback text
  testthat::expect_error(
    setup_auth_object$send_feedback(
      text = bad_text
    )
  )

  # Test with invalid feedback type
  testthat::expect_error(
    setup_auth_object$send_feedback(
      text = "All ok",
      type = bad_type
    )
  )

  # Test with invalid refferer
  testthat::expect_error(
    setup_auth_object$send_feedback(
      text = "All ok",
      type = "idea",
      referrer = bad_referrer
    )
  )
})
