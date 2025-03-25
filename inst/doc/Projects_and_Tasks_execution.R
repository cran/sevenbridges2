## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  eval = FALSE
)

## -----------------------------------------------------------------------------
#  # List and view your projects
#  all_my_projects <- a$projects$query()
#  View(all_my_projects$items)

## -----------------------------------------------------------------------------
#  # List projects of particular user
#  a$projects$query(owner = "<username1>")
#  a$projects$query(owner = "<username2>")

## -----------------------------------------------------------------------------
#  # List projects whose name contains 'demo'
#  a$projects$query(name = "demo")

## -----------------------------------------------------------------------------
#  # Return all projects matching the name "wgs"
#  wgs_projects <- a$projects$query(name = "wgs")
#  
#  # Filter by project creators
#  creators <- sapply(wgs_projects$items, "[[", "created_by")
#  wgs_projects$items[which(creators == "<some_username>")]
#  
#  # Filter by project creation date
#  create_date <- as.Date(sapply(wgs_projects$items, "[[", "created_on"))
#  wgs_projects$items[which(as.Date(create_date) < as.Date("2019-01-01"))]
#  
#  # Filter by project modification date
#  modify_date <- as.Date(sapply(wgs_projects$items, "[[", "modified_on"))
#  wgs_projects$items[which(as.Date(modify_date) < as.Date("2019-01-01"))]

## -----------------------------------------------------------------------------
#  # Get billing group
#  billing_groups <- a$billing_groups$query()
#  billing_group <- a$billing_groups$get("<billing_id>")
#  
#  # Create a project named 'API Testing'
#  a$projects$create(
#    name = "API Testing", billing_group = billing_group,
#    description = "Test for API"
#  )

## -----------------------------------------------------------------------------
#  # Fetch previously created project
#  p <- a$projects$get(id = "<your_username_or_division>/api-testing")

## -----------------------------------------------------------------------------
#  # Print all project info
#  p$detailed_print()

## -----------------------------------------------------------------------------
#  # Delete project using Auth$projects path
#  a$projects$delete(project = "<project_object_or_id>")
#  
#  # Delete project directly from the project object
#  p$delete()

## -----------------------------------------------------------------------------
#  # Update project
#  p$update(
#    name = "Project with modified name",
#    description = "This is the modified description."
#  )

## -----------------------------------------------------------------------------
#  # Reload project object
#  p$reload()

## -----------------------------------------------------------------------------
#  # List project members
#  p$list_members()

## -----------------------------------------------------------------------------
#  # Add project member
#  p$add_member(
#    user = "<username_of_a_user_you_want_to_add>",
#    permissions = list(write = TRUE, execute = TRUE)
#  )

## -----------------------------------------------------------------------------
#  # Modify project member's permissions
#  p$modify_member_permissions(
#    user = "<username_of_a_user_of_interest>",
#    permissions = list(copy = TRUE)
#  )

## -----------------------------------------------------------------------------
#  # Remove a project member
#  p$remove_member(user = "<username_of_a_user_you_want_to_remove>")

## -----------------------------------------------------------------------------
#  # List project files
#  p$list_files()

## -----------------------------------------------------------------------------
#  # Create a folder within project files
#  p$create_folder(name = "My_new_folder")

## -----------------------------------------------------------------------------
#  # Get a project's root folder object
#  p$get_root_folder()

## -----------------------------------------------------------------------------
#  # List project's apps
#  p$list_apps()
#  
#  # List project's tasks
#  p$list_tasks()
#  
#  # List project's imports
#  p$list_imports()

## -----------------------------------------------------------------------------
#  # List files in the project root directory
#  api_testing_files <- a$files$query(project = "project_object_or_id")
#  api_testing_files

## -----------------------------------------------------------------------------
#  # List files in a subdirectory
#  a$files$query(parent = "<parent_directory_object_or_id>")

## -----------------------------------------------------------------------------
#  # List files with these names
#  a$files$query(
#    project = "<project_object_or_id",
#    name = c("<file_name1>", "<file_name2>")
#  )
#  
#  # List files with metadata fields sample_id and library values set
#  a$files$query(
#    project = "<project_object_or_id>",
#    metadata = list(
#      "sample_id" = "<sample_id_value>",
#      "library" = "<library_value>"
#    )
#  )
#  
#  # List files with this tag
#  a$files$query(project = "<project_object_or_id>", tag = c("<tag_value>"))
#  
#  # List files from this task
#  a$files$query(project = "<project_object_or_id>", task = "<task_object_or_id>")

## -----------------------------------------------------------------------------
#  # Query project files according to described criteria
#  my_files <- a$files$query(
#    project = "user1/api-testing",
#    metadata = list(
#      sample_id = "Sample1",
#      sample_id = "Sample2",
#      library_id = "EXAMPLE"
#    ),
#    tag = c("hello", "world")
#  )

## -----------------------------------------------------------------------------
#  # Query public files
#  public_files <- a$files$query(project = "admin/sbg-public-data")

## -----------------------------------------------------------------------------
#  # Get a single File object by ID
#  a$files$get(id = "<file_id>")

## -----------------------------------------------------------------------------
#  # Delete a file
#  a$files$delete(file = "<file_object_or_id>")

## -----------------------------------------------------------------------------
#  # Delete multiple files
#  async_delete_job <- a$files$async_bulk_delete(
#    items = list("file1-id", "file2-id", file_obj)
#  )

## -----------------------------------------------------------------------------
#  # Reload object to check its status
#  async_delete_job$reload()
#  async_delete_job
#  
#  # Or fetch async delete job object by id
#  async_delete_job <- a$files$async_get_delete_job(job_id = "<job-id>")
#  async_delete_job

## -----------------------------------------------------------------------------
#  # Fetch files by id to copy into the api-testing project
#  file1 <- a$files$get(id = "6435367997d9446ecb66cfb2")
#  file2 <- a$files$get(id = "6435367997d9446ecb66cgr2")
#  
#  # Copy files to the project
#  a$files$copy(
#    files = list(file1, file2),
#    destination_project = "<username_or_division>/api-testing"
#  )

## -----------------------------------------------------------------------------
#  # Fetch files by id to copy into the api-testing project
#  file1 <- a$files$get(id = "6435367997d9446ecb66cfb2")
#  file2 <- a$files$get(id = "6435367997d9446ecb66cgr2")
#  
#  # Copy files to a project
#  async_job_copy <- a$files$async_bulk_copy(
#    items = list(
#      list(
#        file = file1,
#        project = "<username_or_division>/api-testing"
#      ),
#      list(
#        file = file2,
#        parent = "<destination-folder-id>",
#        name = "copied_file_new_name"
#      )
#    )
#  )
#  
#  # Reload object to check status
#  async_job_copy$reload()
#  async_job_copy
#  
#  # Or fetch async copy job object by id
#  async_job_copy <- a$files$async_get_copy_job(job_id = "<job-id>")
#  async_job_copy

## -----------------------------------------------------------------------------
#  # Get details of multiple files by providing their IDs
#  a$files$bulk_get(files = list("<file_1_id>", "<file_2_id>"))

## -----------------------------------------------------------------------------
#  # Get files
#  file_obj_1 <- a$files$get(id = "<file_1_ID>")
#  file_obj_2 <- a$files$get(id = "<file_2_ID>")
#  
#  # Edit file_obj_1 fields
#  file_obj_1$name <- "new_file_1_name.txt"
#  file_obj_1$metadata <- list("new_metadata_field" = "123")
#  file_obj_1$tags <- list("bulk_update_tag")
#  
#  # Edit file_obj_2 fields
#  file_obj_2$name <- "new_file_2_name.txt"
#  file_obj_2$metadata <- list("new_metadata_field" = "123")
#  file_obj_2$tags <- list("bulk_update_tag")
#  
#  # Bulk update
#  a$files$bulk_update(files = list(file_obj_1, file_obj_2))

## -----------------------------------------------------------------------------
#  # Get files
#  file_obj_1 <- a$files$get(id = "<file_1_ID>")
#  file_obj_2 <- a$files$get(id = "<file_2_ID>")
#  
#  # Edit file_obj_1 fields
#  file_obj_1$name <- "new_file_1_name.txt"
#  file_obj_1$metadata <- list("new_metadata_field" = "123")
#  file_obj_1$tags <- list("bulk_edit_tag")
#  
#  # Edit file_obj_2 fields
#  file_obj_2$name <- "new_file_2_name.txt"
#  file_obj_2$metadata <- list("new_metadata_field" = "123")
#  file_obj_2$tags <- list("bulk_edit_tag")
#  
#  # Bulk edit
#  a$files$bulk_edit(files = list(file_obj_1, file_obj_2))

## -----------------------------------------------------------------------------
#  # Get details of all async file jobs
#  all_jobs <- a$files$async_list_file_jobs()
#  all_jobs

## -----------------------------------------------------------------------------
#  # Option 1 - Using the project parameter
#  
#  # Option 1.a (providing a Project object as the project parameter)
#  my_project <- a$projects$get(project = "<username_or_division>/api-testing")
#  demo_folder <- a$files$create_folder(
#    name = "my_new_folder",
#    project = my_project
#  )
#  
#  # Option 1.b (providing a project's ID as the project parameter)
#  demo_folder <- a$files$create_folder(
#    name = "my_new_folder",
#    project = "<username_or_division>/api-testing"
#  )

## -----------------------------------------------------------------------------
#  # Option 2 - Using the parent parameter
#  
#  # Option 2.a (providing a File (must be a folder) object as parent parameter)
#  my_parent_folder <- a$files$get(id = "<folder_id>")
#  demo_folder <- a$files$create_folder(
#    name = "my_new_folder",
#    parent = my_parent_folder
#  )
#  
#  # Option 2.b (providing a file's (folder's) ID as project parameter)
#  demo_folder <- a$files$create_folder(
#    name = "my_new_folder",
#    parent = "<folder_id>"
#  )

## -----------------------------------------------------------------------------
#  # Fetch files by ID to move them into the "api-testing" project
#  file1 <- a$files$get(id = "<file-1-id>")
#  file2 <- a$files$get(id = "<file-2-id>")
#  
#  # Move files to a project
#  async_job_move <- a$files$async_bulk_move(
#    items = list(
#      list(
#        file = file1,
#        project = "<username_or_division>/api-testing"
#      ),
#      list(
#        file = file2,
#        parent = "<destination-folder-id>",
#        name = "moved_file_new_name"
#      )
#    )
#  )
#  
#  # Reload the object to check the status
#  async_job_move$reload()
#  async_job_move
#  
#  # Or fetch the async move job object by id
#  async_job_move <- a$files$async_get_move_job(job_id = "<job-id>")
#  async_job_move

## -----------------------------------------------------------------------------
#  # Get some file
#  demo_file <- a$files$get(id = "<file_id>")
#  
#  # Regular file print
#  demo_file$print()

## -----------------------------------------------------------------------------
#  # Pretty print
#  demo_file$detailed_print()

## -----------------------------------------------------------------------------
#  # Update file name
#  demo_file$update(name = "<new_name>")
#  
#  # Update file metadata
#  demo_file$update(
#    metadata = list("<metadata_field>" = "<metadata_field_value>")
#  )
#  
#  # Update file tags
#  demo_file$update(tags = list("<tag_value>"))

## -----------------------------------------------------------------------------
#  # Add a new tag to a file
#  demo_file$add_tag(tags = list("new_tag"))
#  
#  # Add a new tag to a file and overwrite old ones
#  demo_file$add_tag(tags = list("new_tag"), overwrite = TRUE)
#  
#  # Delete all tags - just set tags to NULL
#  demo_file$add_tag(tags = NULL, overwrite = TRUE)

## -----------------------------------------------------------------------------
#  # Copy a file to a new project and set a new name
#  demo_file$copy_to(
#    project = "<destination_project_object_or_id>",
#    name = "<new_name>"
#  )

## -----------------------------------------------------------------------------
#  # Get downloadable URL for a file
#  demo_file$get_download_url()

## -----------------------------------------------------------------------------
#  # Get file metadata
#  demo_file$get_metadata()

## -----------------------------------------------------------------------------
#  # Set file metadata
#  demo_file$set_metadata(
#    metadata_fields = list("<metadata_field>" = "metadata_field_value"),
#    overwrite = TRUE
#  )

## -----------------------------------------------------------------------------
#  # List folder contents
#  demo_folder$list_contents()

## -----------------------------------------------------------------------------
#  # Move a file to a folder
#  demo_file$move_to_folder(
#    parent = "<parent_file_object_or_id>",
#    name = "Moved_file.txt"
#  )

## -----------------------------------------------------------------------------
#  # Download a file
#  demo_file$download(directory_path = "/path/to/your/destination/folder")

## -----------------------------------------------------------------------------
#  # Get a file's parent directory
#  demo_file$parent

## -----------------------------------------------------------------------------
#  # Get a folder object
#  parent_folder <- a$files$get(demo_file$parent)

## -----------------------------------------------------------------------------
#  # Delete a file
#  demo_file$delete()
#  
#  # Delete a folder
#  demo_folder$delete()

## -----------------------------------------------------------------------------
#  # Delete two files by providing their IDs
#  a$files$delete(files = list("<file_1_ID>", "<file_2_ID>"))
#  
#  # Delete two files by providing a list of File objects
#  file_object_1 <- a$files$get(id = "<file_1_ID>")
#  file_object_2 <- a$files$get(id = "<file_2_ID>")
#  a$files$delete(files = list(file_object_1, file_object_2))

## -----------------------------------------------------------------------------
#  # Reload file/folder objects
#  demo_file$reload()
#  demo_folder$reload()

## -----------------------------------------------------------------------------
#  # Query public apps - set visibility parameter to "public"
#  a$apps$query(visibility = "public", limit = 10)

## -----------------------------------------------------------------------------
#  # Query private apps
#  my_apps <- a$apps$query()

## -----------------------------------------------------------------------------
#  # Load next 50 apps
#  my_apps$next_page()

## -----------------------------------------------------------------------------
#  # Query apps within your project - set limit to 10
#  a$apps$query(project = "<project_object_or_its_ID>", limit = 10)

## -----------------------------------------------------------------------------
#  # List public apps containing the term "VCFtools" in app's details
#  a$apps$query(visibility = "public", query_terms = list("VCFtools"), limit = 10)

## -----------------------------------------------------------------------------
#  # List files in project root directory
#  a$apps$query(
#    visibility = "public",
#    id = "admin/sbg-public-data/vcftools-convert"
#  )

## -----------------------------------------------------------------------------
#  # Get project
#  p <- a$projects$get("<username_or_division>/api-testing")
#  
#  # List apps in the specified project
#  p$list_apps(limit = 10)

## -----------------------------------------------------------------------------
#  # Get a public App object
#  bcftools_app <- a$apps$get(id = "admin/sbg-public-data/bcftools-call-1-15-1")

## -----------------------------------------------------------------------------
#  # Copy an app to a project
#  app_copy <- a$apps$copy(bcftools_app,
#    project = "<project_object_or_its_ID>",
#    name = "New_app_name"
#  )

## -----------------------------------------------------------------------------
#  # Load the JSON file
#  file_json <- jsonlite::read_json("/path/to/your/raw_cwl_in_json_format.cwl")
#  
#  # Create app from raw CWL (JSON)
#  new_app_json <- a$apps$create(
#    project = "<destination_project_object_or_its_ID>",
#    raw = file_json,
#    name = "New_app_json",
#    raw_format = "JSON"
#  )

## -----------------------------------------------------------------------------
#  # Create an app from raw CWL (YAML)
#  new_app_yaml <- a$apps$create(
#    project = "<destination_project_object_or_its_ID>",
#    from_path = "/path/to/your/raw_cwl_in_yaml_format.cwl",
#    name = "New_app_yaml",
#    raw_format = "YAML"
#  )

## -----------------------------------------------------------------------------
#  # Load the JSON file
#  file_json <- jsonlite::read_json("/path/to/your/raw_cwl_in_json_format.cwl")
#  
#  # Get project
#  p <- a$projects$get("<username_or_division>/api-testing")
#  
#  # Create app from raw CWL (JSON) in specified project
#  p$create_app(
#    raw = file_json,
#    name = "New_app_json",
#    raw_format = "JSON"
#  )

## -----------------------------------------------------------------------------
#  # Fetch the first app from project's apps
#  p <- a$projects$get("<username_or_division>/api-testing")
#  my_apps <- p$list_apps()
#  my_new_app <- my_apps$items[[1]]
#  
#  # Print app's details
#  my_new_app$print()

## -----------------------------------------------------------------------------
#  # Get app's inputs details
#  my_new_app$input_matrix()

## -----------------------------------------------------------------------------
#  # Get app's outputs details
#  my_new_app$output_matrix()

## -----------------------------------------------------------------------------
#  # Get an app revision
#  my_app <- a$apps$get(id = "<username_or_division>/api-testing/new_app_json/0")
#  my_app$print()

## -----------------------------------------------------------------------------
#  # Get an app revision
#  my_app$get_revision(revision = 1)

## -----------------------------------------------------------------------------
#  # Get an app revision and update the object
#  my_app$get_revision(revision = 1, in_place = TRUE)

## -----------------------------------------------------------------------------
#  # Create an app revision from a file
#  raw_cwl_as_list <- jsonlite::read_json(
#    path = "/path/to/your/raw_cwl_in_json_format.cwl"
#  )
#  my_app$create_revision(raw = raw_cwl_as_list, in_place = TRUE)

## -----------------------------------------------------------------------------
#  # Create a new revision for an existing app
#  my_app$create_revision(
#    from_path = "/path/to/your/raw_cwl_in_json_format.cwl",
#    in_place = TRUE
#  )

## -----------------------------------------------------------------------------
#  # Copy app
#  copied_app <- my_app$copy(
#    project = "<destination_project_object_or_its_ID>",
#    name = "New_app_name"
#  )

## -----------------------------------------------------------------------------
#  # Sync a copied app to the latest revision created
#  copied_app$sync()

## -----------------------------------------------------------------------------
#  # Reload an app object
#  my_app$reload()

## -----------------------------------------------------------------------------
#  # Query all tasks
#  a$tasks$query()
#  
#  # Query tasks by their status
#  a$tasks$query(status = "COMPLETED", limit = 5)

## -----------------------------------------------------------------------------
#  # Find the project and pass it in the project parameter
#  p <- a$projects$query(id = "<project_id>")
#  a$tasks$query(project = p)
#  
#  # Alternatively you can list all tasks directly from the Project object
#  p <- a$projects$get(id = "<project_id>")
#  p$list_tasks()

## -----------------------------------------------------------------------------
#  # Get specific task by ID
#  a$tasks$get(id = "<task_id>")

## -----------------------------------------------------------------------------
#  # Get details of multiple tasks by providing their IDs
#  a$tasks$bulk_get(tasks = list("<task_1_id>", "task_2_id"))
#  
#  # Get details of multiple tasks by providing Task objects
#  task_obj_1 <- a$tasks$get("<task_1_id>")
#  task_obj_2 <- a$tasks$get("<task_2_id>")
#  a$tasks$bulk_get(tasks = list(task_obj_1, task_obj_2))

## -----------------------------------------------------------------------------
#  # Create a draft task
#  draft_task <- a$tasks$create(
#    project = "<project_object_or_id>",
#    app = "<app_object_or_id>"
#  )

## -----------------------------------------------------------------------------
#  # Create task with execution settings and with use of interruptible instances
#  execution_settings <- list(
#    "instance_type" = "c4.2xlarge;ebs-gp2;2000",
#    "max_parallel_instances" = 2,
#    "use_memoization" = TRUE,
#    "use_elastic_disk" = FALSE
#  )
#  task_exec_settings <- a$tasks$create(
#    project = "<project_object_or_id>",
#    app = "<app_object_or_id>",
#    execution_settings = execution_settings,
#    use_interruptible_instances = FALSE,
#  )

## -----------------------------------------------------------------------------
#  # Create and run task
#  task_exec_settings <- a$tasks$create(
#    project = "<project_object_or_id>",
#    app = "<app_object_or_id>",
#    input = "<inputs>",
#    action = "run"
#  )

## -----------------------------------------------------------------------------
#  # Create a draft task
#  batch_task <- a$tasks$create(
#    project = "<project_object_or_id>",
#    app = "<app_object_or_id>",
#    inputs = list(
#      "reads" = "<reads_file_object_or_id>",
#      "reference" = "<reference_file_object_or_id>"
#    ),
#    batch = TRUE,
#    batch_input = "reads",
#    batch_by = list(
#      type = "CRITERIA",
#      criteria = list("metadata.sample_id")
#    )
#  )

## -----------------------------------------------------------------------------
#  # Print task details
#  draft_task$print()

## -----------------------------------------------------------------------------
#  # Run a task
#  draft_task$run(in_place = TRUE)

## -----------------------------------------------------------------------------
#  # Abort a task
#  draft_task$abort()

## -----------------------------------------------------------------------------
#  # Clone a task
#  cloned_task <- draft_task$clone_task()

## -----------------------------------------------------------------------------
#  # Get execution details of the task
#  details <- draft_task$get_execution_details()

## -----------------------------------------------------------------------------
#  # List batch children
#  children_tasks <- batch_task$list_batch_children()

## -----------------------------------------------------------------------------
#  # Update task
#  draft_task$update(
#    description = "New description",
#    batch_by = list(
#      type = "CRITERIA",
#      criteria = list("metadata.diagnosis")
#    ),
#    inputs = list("in_reads" = "<some_other_file_object_or_id>")
#  )

## -----------------------------------------------------------------------------
#  # Rerun task
#  draft_task$rerun()

## -----------------------------------------------------------------------------
#  # Reload task object
#  draft_task$reload()

## -----------------------------------------------------------------------------
#  # Delete task
#  draft_task$delete()

