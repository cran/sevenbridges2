## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  eval = FALSE
)

## -----------------------------------------------------------------------------
#  # Install package from CRAN
#  install.packages("sevenbridges2")

## -----------------------------------------------------------------------------
#  # Install package from github
#  remotes::install_github(
#    "sbg/sevenbridges2",
#    build_vignettes = TRUE, dependencies = TRUE
#  )

## -----------------------------------------------------------------------------
#  # Load the package
#  library("sevenbridges2")
#  
#  # Authenticate
#  a <- Auth$new(token = "<your_token>", platform = "aws-us")
#  
#  # List all projects with raw api() function
#  a$api(path = "projects", method = "GET")

## -----------------------------------------------------------------------------
#  # Create a collection of files
#  public_files <- a$files$query(project = "admin/sbg-public-data")
#  
#  # Load next 50 results
#  public_files$next_page()
#  
#  # Load previous 50 results
#  public_files$prev_page()
#  
#  # Load all results
#  public_files$all()

## -----------------------------------------------------------------------------
#  # Create a collection of files
#  public_files <- a$files$query(project = "admin/sbg-public-data")
#  
#  # Default print
#  public_files
#  
#  # Print 20 items
#  public_files$print(n = 20)

## -----------------------------------------------------------------------------
#  # Search all public files
#  public_files <- a$files$query(project = "admin/sbg-public-data")
#  
#  # Search files by name
#  file_1000G_omni <- a$files$query(
#    project = "admin/sbg-public-data",
#    name = "1000G_omni2.5.b37.vcf"
#  )

## -----------------------------------------------------------------------------
#  # Search all public apps containing the STAR term
#  public_star_apps <- a$apps$query(
#    visibility = "public",
#    query_terms = list("STAR")
#  )
#  
#  # Search all projects that contain "demo" in the name
#  demo_projs <- a$projects$query(name = "demo")

## -----------------------------------------------------------------------------
#  # Load package
#  library("sevenbridges2")

## -----------------------------------------------------------------------------
#  # Authenticate with direct method
#  a <- Auth$new(platform = "aws-us", token = "<your-token>")

## -----------------------------------------------------------------------------
#  # Set environment variables
#  sevenbridges2:::sbg_set_env(
#    url = "https://api.sbgenomics.com/v2/",
#    token = "<your_token>"
#  )

## -----------------------------------------------------------------------------
#  # Authenticate using environment variables
#  a <- Auth$new(from = "env")

## -----------------------------------------------------------------------------
#  # Load aws-us-<username> profile for authentication
#  a <- Auth$new(
#    from = "file",
#    profile_name = "aws-us-<username>"
#  )

## -----------------------------------------------------------------------------
#  # Load default profile
#  a <- Auth$new(from = "file")

## -----------------------------------------------------------------------------
#  # Create Auth object with 'default' account
#  a <- Auth$new(from = "file", profile_name = "default")
#  
#  # Create Auth object with 'aws-us-<username>' account
#  b <- Auth$new(from = "file", profile_name = "aws-us-<username>")

## -----------------------------------------------------------------------------
#  # Get currently authenticated user info
#  a$user()

## -----------------------------------------------------------------------------
#  # Get user info
#  a$user(username = "<username>")

## -----------------------------------------------------------------------------
#  # Get rate limit info
#  a$rate_limit()

## -----------------------------------------------------------------------------
#  # Check your billing info
#  a$billing_groups$query()

## -----------------------------------------------------------------------------
#  # Check your invoices
#  a$invoices$query()

## -----------------------------------------------------------------------------
#  # Get a single billing group
#  a$billing_groups$get(id = "<billing_group_id>")

## -----------------------------------------------------------------------------
#  # List first 5 projects
#  my_projects <- a$projects$query(limit = 5)
#  my_projects
#  
#  # Load next page of results
#  my_projects$next_page()
#  
#  # Return all projects that contain the term "demo"
#  demo_projects <- a$projects$query(name = "demo")
#  
#  # Return all projects tagged with "demo"
#  tagged_projects <- a$projects$query(tags = list("demo"))

## -----------------------------------------------------------------------------
#  # List all available billing groups for currently logged in user
#  a$billing_groups$query()
#  
#  # Set the billing group for the new project
#  bid <- "<billing_group_id>"
#  
#  # Create a new project
#  p <- a$projects$create(
#    name = "API testing", billing_group = bid,
#    description = "This project has been created using the sevenbridges2 R API
#    library."
#  )

## -----------------------------------------------------------------------------
#  # Get a single project by ID
#  a$projects$get(id = "<your_username_or_division>/api-testing")

## -----------------------------------------------------------------------------
#  # Search by name matching, with limit 10
#  public_apps <- a$apps$query(
#    visibility = "public",
#    limit = 10,
#    query_terms = list("STAR")
#  )
#  
#  # Search by ID
#  star_app <- a$apps$get(
#    id = "admin/sbg-public-data/rna-seq-alignment-star/0"
#  )

## -----------------------------------------------------------------------------
#  # Copy app into the project
#  a$apps$copy(
#    app = star_app,
#    project = "<username_or_division>/api-testing",
#    name = "New copy of STAR"
#  )
#  
#  # Check if it is copied
#  p <- a$projects$get(id = "<username_or_division>/api-testing")
#  
#  # List the apps you have in your project
#  p$list_apps()

## -----------------------------------------------------------------------------
#  # Get public app RNA Sequencing alignment - STAR
#  star_app <- a$apps$get(
#    id = "admin/sbg-public-data/rna-seq-alignment-star/0"
#  )
#  
#  # Copy it into a project
#  star_app$copy(
#    project = "<username_or_division>/api-testing",
#    name = "Copy of STAR"
#  )

## -----------------------------------------------------------------------------
#  # Fetch copied app
#  copied_star_app <- a$apps$get(
#    id = "<username_or_division>/api-testing/newcopyofstar/0"
#  )
#  
#  # Preview its inputs
#  copied_star_app$input_matrix()

## -----------------------------------------------------------------------------
#  # Get reads (fastq) files and and copy them into a project
#  reads_1 <- a$files$get(id = "641c48c425ed1842bd0bf799") # file id
#  reads_1$copy_to(project = p)
#  
#  reads_2 <- a$files$get(id = "641c48c425ed1842bd0bf835") # file id
#  reads_2$copy_to(project = p)
#  
#  # Get a single file reference file and copy into a project
#  fasta_in <- a$files$get(id = "641c48c525ed1842bd0bf86a") # file id
#  fasta_in$copy_to(project = p)
#  
#  # Get gtf file and copy into a project
#  gtf_in <- a$files$get(id = "641c48c425ed1842bd0bf825") # file id
#  gtf_in$copy_to(project = p)
#  
#  # Get copied files
#  input_files <- p$list_files()$items

## -----------------------------------------------------------------------------
#  # Add new tasks
#  taskName <- paste0("STAR-alignment ", date())
#  
#  tsk <- p$create_task(
#    name = taskName,
#    description = "STAR test",
#    app = copied_star_app,
#    inputs = list(
#      "fastq" = c(input_files[[1]], input_files[[2]]),
#      "genomeFastaFiles" = input_files[[3]],
#      "sjdbGTFfile" = list(input_files[[4]])
#    )
#  )
#  
#  # Preview task
#  tsk$print()

## -----------------------------------------------------------------------------
#  # Get app's outputs details
#  copied_star_app$output_matrix()

## -----------------------------------------------------------------------------
#  # Run your task
#  tsk$run()

## -----------------------------------------------------------------------------
#  # Update task
#  tsk$update(description = "New RNA SEQ Alignment - STAR task")

## -----------------------------------------------------------------------------
#  # Reload task
#  tsk$reload()
#  tsk$status

## -----------------------------------------------------------------------------
#  # Abort your task
#  tsk$abort()

## -----------------------------------------------------------------------------
#  # Rerun your task
#  tsk$rerun()

## -----------------------------------------------------------------------------
#  # First clone existing task
#  cloned_task <- tsk$clone_task()
#  
#  # Then, update GTF input file in the cloned task
#  cloned_task$update(inputs = list(sjdbGTFfile = "<some new file>"))
#  cloned_task$run()

## -----------------------------------------------------------------------------
#  # # not run
#  # tsk$delete()

## -----------------------------------------------------------------------------
#  # Create project with disabled spot instances
#  p <- a$projects$create(
#    name = "spot-disabled-project", bid, description = "spot disabled project",
#    use_interruptible = FALSE
#  )

## -----------------------------------------------------------------------------
#  # Create task and set usage of interruptible instances to TRUE
#  tsk <- p$create_task(
#    name = paste0("spot enabled task in a spot disabled project"),
#    description = "spot enabled task",
#    app = copied_star_app,
#    inputs = list(
#      "fastq" = c(input_files[[1]], input_files[[2]]),
#      "genomeFastaFiles" = input_files[[3]],
#      "sjdbGTFfile" = list(input_files[[4]])
#    ),
#    use_interruptible_instances = TRUE
#  )

## -----------------------------------------------------------------------------
#  # Create task with setting instance type and number of parallel instances
#  tsk <- p$create_task(
#    ...,
#    execution_settings = list(
#      instance_type = "c4.2xlarge;ebs-gp2;2000",
#      max_parallel_instances = 2
#    )
#  )

## -----------------------------------------------------------------------------
#  # Add two more fastq files that will be used in our task inputs
#  # and copy them into our API testing project
#  reads_3 <- a$files$get(id = "641c48c425ed1842bd0bf7b6") # file id
#  reads_3$copy_to(project = p)
#  
#  reads_4 <- a$files$get(id = "641c48c425ed1842bd0bf7a5") # file id
#  reads_4$copy_to(project = p)
#  
#  # Get all project files
#  input_files <- p$list_files()$items
#  
#  taskName <- paste0("STAR-alignment ", date())
#  
#  # Create task with batch criteria
#  tsk <- p$create_task(
#    name = taskName,
#    description = "Batch Star Test",
#    app = copied_star_app,
#    batch = TRUE,
#    batch_input = "fastq",
#    batch_by = list(
#      type = "CRITERIA",
#      criteria = list("metadata.sample_id")
#    ),
#    inputs = list(
#      "fastq" = c(
#        input_files[[1]],
#        input_files[[2]],
#        input_files[[3]],
#        input_files[[4]]
#      ),
#      "genomeFastaFiles" = input_files[[5]],
#      "sjdbGTFfile" = list(input_files[[6]])
#    )
#  )
#  
#  # Run batch task
#  tsk$run()

## -----------------------------------------------------------------------------
#  # List parent task children and their execution details
#  child_tasks <- tsk$list_batch_children()
#  
#  child1_details <- child_tasks$items[[1]]$get_execution_details()
#  child2_details <- child_tasks$items[[2]]$get_execution_details()

