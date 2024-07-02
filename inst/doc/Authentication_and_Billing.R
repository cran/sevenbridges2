## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  eval = FALSE
)

## -----------------------------------------------------------------------------
#  # Direct authentication with setting platform parameter
#  a <- Auth$new(
#    token = "<your_token>",
#    platform = "aws-us"
#  )

## -----------------------------------------------------------------------------
#  # Direct authentication with setting url parameter
#  a <- Auth$new(
#    token = "<your_token>",
#    url = "https://api.sb.biodatacatalyst.nhlbi.nih.gov/v2/"
#  )

## -----------------------------------------------------------------------------
#  # Direct authentication on default aws-us platform
#  a <- Auth$new(token = "<your_token>")

## -----------------------------------------------------------------------------
#  # Set environment variables
#  sevenbridges2:::sbg_set_env(
#    url = "https://cgc-api.sbgenomics.com/v2",
#    token = "<your_token>"
#  )

## -----------------------------------------------------------------------------
#  # Check environment variables
#  sevenbridges2:::sbg_get_env("SB_API_ENDPOINT")
#  ## "https://cgc-api.sbgenomics.com/v2"
#  
#  sevenbridges2:::sbg_get_env("SB_AUTH_TOKEN")
#  ## "<your_token>"

## -----------------------------------------------------------------------------
#  # Authenticate using environment variables
#  a <- Auth$new(from = "env")

## -----------------------------------------------------------------------------
#  # Unset environment variables
#  Sys.unsetenv("SB_API_ENDPOINT")
#  Sys.unsetenv("SB_AUTH_TOKEN")

## -----------------------------------------------------------------------------
#  # Set environment variables for the first account
#  sevenbridges2:::sbg_set_env(
#    url = "https://api.sbgenomics.com/v2",
#    token = "<your_token>",
#    sysenv_url_name = "account_1_url",
#    sysenv_token_name = "account_1_token"
#  )
#  
#  # Set environment variables for the second account
#  sevenbridges2:::sbg_set_env(
#    url = "https://api.sb.biodatacatalyst.nhlbi.nih.gov/v2/",
#    token = "<your_token>",
#    sysenv_url_name = "account_2_url",
#    sysenv_token_name = "account_2_token"
#  )

## -----------------------------------------------------------------------------
#  # Authenticate using the first account
#  a <- sevenbridges2::Auth$new(
#    from = "env",
#    sysenv_url = "account_1_url",
#    sysenv_token = "account_1_token"
#  )
#  
#  # Authenticate using the second account
#  b <- sevenbridges2::Auth$new(
#    from = "env",
#    sysenv_url = "account_2_url",
#    sysenv_token = "account_2_token"
#  )

## -----------------------------------------------------------------------------
#  # Authenticate using file configuration
#  a <- Auth$new(from = "file")

## -----------------------------------------------------------------------------
#  # Authenticate using file configuration and specific profile
#  a <- Auth$new(from = "file", profile_name = "aws-us-<username>")

## -----------------------------------------------------------------------------
#  # Authenticate using specific file configuration on custom path
#  a <- Auth$new(
#    from = "file", config_file = "~/sevenbridges.cfg",
#    profile_name = "aws-us-<username>"
#  )

## -----------------------------------------------------------------------------
#  # Load package and check advance access option
#  library("sevenbridges2")
#  getOption("sevenbridges2")$advance_access

## -----------------------------------------------------------------------------
#  # Authenticate first
#  a <- Auth$new(token = "<your_token>", platform = "aws-us")
#  
#  # Try to send request to list markers
#  req <- a$api(
#    path = "genome/markers?file={bam_file_id}",
#    method = "GET"
#  )

## -----------------------------------------------------------------------------
#  # Enable advance access option
#  opt <- getOption("sevenbridges2")
#  opt$advance_access <- TRUE
#  options(sevenbridges2 = opt)

## -----------------------------------------------------------------------------
#  # Check advance_access option again
#  getOption("sevenbridges2")$advance_access

## -----------------------------------------------------------------------------
#  # Send request again to list markers
#  req <- a$api(
#    path = "genome/markers?file={bam_file_id}",
#    method = "GET"
#  )

## -----------------------------------------------------------------------------
#  # Read content
#  httr::content(req)

## -----------------------------------------------------------------------------
#  # Get rate limit info
#  a$rate_limit()

## -----------------------------------------------------------------------------
#  # List all API paths
#  a$api()

## -----------------------------------------------------------------------------
#  # Return your information
#  a$user()
#  
#  # Return user RFranklin's information
#  a$user(username = "RFranklin")

## -----------------------------------------------------------------------------
#  # Get specific billing group
#  my_billing_group <- a$billing_groups$get(id = "<billing_group_id>")
#  
#  # You can still print the billing group info by calling the print method
#  my_billing_group$print()

## -----------------------------------------------------------------------------
#  # Get analysis breakdown
#  my_billing_group$analysis_breakdown()

## -----------------------------------------------------------------------------
#  # Get storage breakdown
#  my_billing_group$storage_breakdown()

## -----------------------------------------------------------------------------
#  # Get egress breakdown
#  my_billing_group$egress_breakdown()

## -----------------------------------------------------------------------------
#  # Reload Billing objcet
#  my_billing_group$reload()

## -----------------------------------------------------------------------------
#  # List invoices of specific billing group
#  invoices_bg <- a$invoices$query(billing_group = "<billing_group_id>")
#  
#  # Print invoices
#  invoices_bg

## -----------------------------------------------------------------------------
#  # Get specific invoice by ID
#  invoice <- a$invoices$get(id = "<invoice_id>")
#  
#  # Print
#  invoice

## -----------------------------------------------------------------------------
#  # Reload Invoice object
#  invoice$reload()

## -----------------------------------------------------------------------------
#  # Send feedback
#  a$send_feedback(
#    "This is a test for sending feedback via API. Please ignore this message.",
#    type = "thought"
#  )

