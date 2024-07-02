## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  eval = FALSE
)

## -----------------------------------------------------------------------------
#  # Authenticate
#  a <- Auth$new(platform = "aws-us", token = "<your-token>")
#  
#  # Get the desired project to upload to
#  destination_project <- a$projects$get(project = "<project_id>")
#  
#  # Create upload job and set destination project
#  upload_job <- a$upload(
#    path = "/path/to/your/file.txt",
#    project = destination_project,
#    overwrite = TRUE,
#    init = TRUE
#  )

## -----------------------------------------------------------------------------
#  # Get destination folder object
#  destination_folder <- a$files$get(id = "<folder_id>")
#  
#  up <- a$upload(
#    path = "/path/to/your/file.txt",
#    parent = destination_folder,
#    overwrite = TRUE,
#    init = TRUE
#  )

## -----------------------------------------------------------------------------
#  up$print()

## -----------------------------------------------------------------------------
#  # Start upload
#  up$start()

## -----------------------------------------------------------------------------
#  # Create upload job and start it immediately
#  up <- a$upload(
#    path = "/path/to/your/file.txt",
#    project = destination_project,
#    overwrite = TRUE,
#    init = FALSE
#  )

## -----------------------------------------------------------------------------
#  # Get upload progress info
#  up$info()

## -----------------------------------------------------------------------------
#  # List ongoing uploads
#  a$list_ongoing_uploads()

## -----------------------------------------------------------------------------
#  # Abort upload
#  a$abort_upload(upload_id = "<id_of_the_upload_process>")

## -----------------------------------------------------------------------------
#  # Query volumes
#  a$volumes$query()

## -----------------------------------------------------------------------------
#  # Get volume
#  a$volumes$get(id = "<volume_owner_or_division>/<volume_name>")

## -----------------------------------------------------------------------------
#  # Create AWS volume using IAM User authentication type
#  aws_iam_user_volume <- a$volumes$create_s3_using_iam_user(
#    name = "my_new_aws_user_volume",
#    bucket = "<bucket-name>",
#    description = "AWS IAM User volume",
#    access_key_id = "<access-key>",
#    secret_access_key = "<secret-access-key>"
#  )
#  
#  aws_iam_user_volume_from_path <- a$volumes$create_s3_using_iam_user(
#    from_path = "path/to/my/json/file.json"
#  )
#  
#  
#  # Create AWS volume using IAM Role authentication type
#  aws_iam_role_volume <- a$volumes$create_s3_using_iam_role(
#    name = "my_new_aws_role_volume",
#    bucket = "<bucket-name>",
#    description = "AWS IAM Role volume",
#    role_arn = "<role-arn-key>",
#    external_id = "<external-id>"
#  )
#  
#  aws_iam_role_volume_from_path <- a$volumes$create_s3_using_iam_role(
#    from_path = "path/to/my/json/file.json"
#  )
#  
#  # Create Google Cloud volume using IAM User authentication type
#  gc_iam_user_volume <- a$volumes$create_google_using_iam_user(
#    name = "my_new_gc_user_volume",
#    access_mode = "RW",
#    bucket = "<bucket-name>",
#    description = "GC IAM User volume",
#    client_email = "<client_email>",
#    private_key = "<private_key-string>"
#  )
#  
#  gc_iam_user_volume_from_path <- a$volumes$create_google_using_iam_user(
#    from_path = "path/to/my/json/file.json"
#  )
#  
#  # Create Google Cloud volume using IAM Role authentication type
#  # by passing configuration parameter as named list
#  gc_iam_role_volume <- a$volumes$create_google_using_iam_role(
#    name = "my_new_gc_role_volume",
#    access_mode = "RO",
#    bucket = "<bucket-name>",
#    description = "GC IAM Role volume",
#    configuration = list(
#      type = "<type-name>",
#      audience = "<audience-link>",
#      subject_token_type = "<subject_token_type>",
#      service_account_impersonation_url = "<service_account_impersonation_url>",
#      token_url = "<token_url>",
#      credential_source = list(
#        environment_id = "<environment_id>",
#        region_url = "<region_url>",
#        url = "<url>",
#        regional_cred_verification_url = "<regional_cred_verification_url>"
#      )
#    )
#  )
#  
#  # Create Google Cloud volume using IAM Role authentication type
#  # by passing configuration parameter as string path to configuration file
#  gc_iam_role_volume_config_file <- a$volumes$create_google_using_iam_role(
#    name = "my_new_gc_role_volume_cnf_file",
#    access_mode = "RO",
#    bucket = "<bucket-name>",
#    description = "GC IAM Role volume - using config file",
#    configuration = "path/to/config/file.json"
#  )
#  
#  # Create Google Cloud volume using IAM Role authentication type
#  # using from_path parameter
#  gc_iam_role_volume_from_path <- a$volumes$create_google_using_iam_role(
#    from_path = "path/to/full/config/file.json"
#  )
#  
#  # Create Azure volume
#  azure_volume <- a$volumes$create_azure(
#    name = "my_new_azure_volume",
#    description = "Azure volume",
#    endpoint = "<endpoint>",
#    container = "<bucket-name",
#    storage_account = "<storage_account-name>",
#    tenant_id = "<tenant_id>",
#    client_id = "<client_id>",
#    client_secret = "<client_secret>",
#    resource_id = "<resource_id>"
#  )
#  
#  azure_volume_from_path <- a$volumes$create_azure(
#    from_path = "path/to/my/json/file.json"
#  )
#  
#  # Create Ali Cloud volume
#  ali_volume <- a$volumes$create_ali_oss(
#    name = "my_new_azure_volume",
#    description = "Ali volume",
#    endpoint = "<endpoint>",
#    bucket = "<bucket-name",
#    access_key_id = "<access_key_id>",
#    secret_access_key = "<secret_access_key>"
#  )
#  
#  ali_volume_from_path <- a$volumes$create_ali_oss(
#    from_path = "path/to/my/json/file.json"
#  )

## -----------------------------------------------------------------------------
#  # Print volume info
#  print(aws_iam_user_volume)

## -----------------------------------------------------------------------------
#  # If the volume is created with RO access mode and RO credential parameters,
#  # and now we want to change it to RW, we should also set proper credential
#  # parameters that are connected to the RW user on the bucket.
#  # If it's created with RW credentials, but access mode is set to RO, then no
#  # change is needed in the credentials parameters.
#  aws_iam_user_volume$update(
#    description = "Updated to RW",
#    access_mode = "RW",
#    service = list(
#      credentials = list(
#        access_key_id = "<access_key_id_for_rw>",
#        secret_access_key = "<secret_access_key_for_rw>",
#      )
#    )
#  )

## -----------------------------------------------------------------------------
#  # Reload volume object
#  aws_iam_user_volume$reload()

## -----------------------------------------------------------------------------
#  # List all files in root bucket directory
#  content_collection <- aws_iam_user_volume$list_contents(limit = 20)
#  
#  # Print collection
#  content_collection
#  
#  # List all files from a specific directory on the bucket
#  folder_files_collection <- aws_iam_user_volume$list_contents(
#    prefix = "<directory_name>"
#  )
#  
#  # Get the next group of results by setting the continuation token
#  content_collection <- aws_iam_user_volume$list_contents(
#    limit = 20,
#    continuation_token = "<continuation_token>"
#  )
#  
#  # Preview volume files
#  content_collection$items
#  
#  # Preview volume prefixes/folders
#  content_collection$prefixes
#  
#  # Preview links
#  aws_iam_user_volume$links
#  
#  # Get the next group of results by setting the link parameter
#  aws_iam_user_volume$list_contents(link = "<link_to_next_results>")
#  
#  # Or use VolumeContentCollection object's next_page() method for this:
#  content_collection$next_page()
#  
#  # You can also fetch all results with the all() method
#  content_collection$all()

## -----------------------------------------------------------------------------
#  # Get single volume file info - by setting file_location
#  vol_file1 <- aws_iam_user_volume$get_file(
#    location = "<file_location_on_bucket>"
#  )
#  
#  # Get single volume file info - by setting link
#  vol_file1 <- aws_iam_user_volume$get_file(link = "full/request/link/to/file")

## -----------------------------------------------------------------------------
#  vol_file1$reload()

## -----------------------------------------------------------------------------
#  # List content
#  volume_content <- aws_iam_user_volume$list_contents()
#  
#  # Extract prefixes
#  volume_prefixes <- volume_content$prefixes
#  
#  # Select one of the volume folders to list its content
#  volume_folder <- volume_prefixes[[1]]
#  
#  # Print volume prefix information
#  volume_folder$print()

## -----------------------------------------------------------------------------
#  ## Select one of the volume folders to list its content
#  volume_folder <- volume_prefixes[[1]]
#  
#  # List content
#  volume_folder_content <- volume_folder$list_contents()

## -----------------------------------------------------------------------------
#  # List volume members
#  aws_iam_user_volume$list_members() # limit = 2
#  
#  # Get single member
#  aws_iam_user_volume$get_member(user = "<member-username>")

## -----------------------------------------------------------------------------
#  # Remove member
#  aws_iam_user_volume$remove_member("<member-username>")
#  
#  # Remove member using the Member object
#  members <- aws_iam_user_volume$list_members()
#  aws_iam_user_volume$remove_member(members$items[[3]])

## -----------------------------------------------------------------------------
#  # Add member via username
#  aws_iam_user_volume$add_member(user = "<member-username>", permissions = list(
#    read = TRUE, copy = TRUE, write = FALSE, admin = FALSE
#  ))
#  
#  # Add member via Member object
#  aws_iam_user_volume$add_member(
#    user = Member$new(
#      username = "<member-username>",
#      id = "<member-username>"
#    ),
#    permissions = list(
#      read = TRUE, copy = TRUE, write = FALSE,
#      admin = FALSE
#    )
#  )

## -----------------------------------------------------------------------------
#  # Modify member permissions
#  aws_iam_user_volume$modify_member_permissions(
#    user = "<member-username>",
#    permissions = list(write = TRUE)
#  )

## -----------------------------------------------------------------------------
#  # Deactivate volume
#  aws_iam_user_volume$deactivate()
#  
#  # Reactivate volume
#  aws_iam_user_volume$reactivate()

## -----------------------------------------------------------------------------
#  # Deactivate volume
#  aws_iam_user_volume$deactivate()
#  
#  # Delete volume
#  aws_iam_user_volume$delete()

## -----------------------------------------------------------------------------
#  # List imports
#  all_imports <- a$imports$query()
#  
#  # Limit results to 5
#  imp_limit5 <- a$imports$query(limit = 5)
#  
#  # Load next page of 5 results
#  imp_limit5$next_page(advance_access = TRUE)
#  
#  # Load all results at once until last page
#  imp_limit5$all(advance_access = TRUE)

## -----------------------------------------------------------------------------
#  # List imports with state being RUNNING or FAILED
#  imp_states <- auth$imports$query(state = c("RUNNING", "FAILED"))
#  
#  # List imports to the specific project
#  imp_project <- auth$imports$query(project = "<project_id>")

## -----------------------------------------------------------------------------
#  ## Get the volume from which you want to list all imports
#  vol1 <- auth$volumes$get(id = "<volumes_owner_or_division>/<volume-name>")
#  vol1$list_imports()
#  
#  ## Get the project object for which you want to list imports
#  test_proj <- auth$projects$get("<project_id>")
#  test_proj$list_imports()

## -----------------------------------------------------------------------------
#  # Get single import
#  imp_obj <- a$imports$get(id = "<import_job_id>")

## -----------------------------------------------------------------------------
#  # Get details of multiple import jobs
#  import_jobs <- a$imports$bulk_get(
#    imports = list("<import_job_id-1>", "<import_job_id-1>")
#  )

## -----------------------------------------------------------------------------
#  ## First, get the volume you want to import files from
#  vol1 <- a$volumes$get(id = "<volume_owner_or_division>/<volume_name>")
#  
#  ## Then, get the project object/id where you want to import files
#  test_proj <- a$projects$get("<project_id>")
#  
#  ## List all volume files on the volume
#  vol1_content <- vol1$list_contents()
#  
#  ## Select one of the volume files
#  volume_file_import <- vol1_content$items[[3]]
#  
#  ## Perform a file import
#  imp_job1 <- a$imports$submit_import(
#    source_location = volume_file_import$location,
#    destination_project = test_proj,
#    autorename = TRUE
#  )
#  
#  # Alternatively you can also call import() directly on the VolumeFile object
#  imp_job1 <- volume_file_import$import(
#    destination_project = test_proj,
#    autorename = TRUE
#  )

## -----------------------------------------------------------------------------
#  # Print Import object
#  print(imp_job1)

## -----------------------------------------------------------------------------
#  # Select one of the volume folders to import
#  volume_folder_import <- vol1_content$prefixes[[1]]
#  
#  # Perform a folder import
#  imp_job2 <- a$imports$submit_import(
#    source_location = volume_folder_import$prefix,
#    destination_project = test_proj,
#    overwrite = TRUE,
#    preserve_folder_structure = TRUE
#  )
#  
#  # Alternatively you can also call import() directly on the VolumePrefix object
#  imp_job2 <- volume_folder_import$import(
#    destination_project = test_proj,
#    overwrite = TRUE,
#    preserve_folder_structure = TRUE
#  )
#  
#  # Print Import object
#  print(imp_job2)

## -----------------------------------------------------------------------------
#  # Reload import object
#  imp_job1$reload()

## -----------------------------------------------------------------------------
#  ## First, get the volume you want to import files from
#  vol1 <- a$volumes$get(id = "<volume_owner_or_division>/<volume_name>")
#  
#  ## Then, get the project object or the ID of the project into which you want
#  # to import files
#  test_proj <- a$projects$get("<project_id>")
#  
#  ## List all volume files
#  vol1_content <- vol1$list_contents()
#  
#  ## Preview the content and select one VolumeFile object and two VolumePrefix
#  ## objects (folders) for the purpose of this example
#  volume_file_import <- vol1_content$items[[1, 2]]
#  volume_file_import
#  
#  volume_folder_import <- vol1_content$prefixes[[1]]
#  volume_folder_import
#  
#  ## Construct the inputs list by filling the necessary information for each
#  # file/folder to import
#  to_import <- list(
#    list(
#      source_volume = "rfranklin/my-volume",
#      source_location = "chimeras.html.gz",
#      destination_project = "rfranklin/my-project"
#    ),
#    list(
#      source_volume = vol1,
#      source_location = "my-folder/",
#      destination_project = test_proj,
#      autorename = TRUE,
#      preserve_folder_structure = TRUE
#    ),
#    list(
#      source_volume = "rfranklin/my-volume",
#      source_location = "my-volume-folder/",
#      destination_parent = "parent-id",
#      name = "new-folder-name",
#      autorename = TRUE,
#      preserve_folder_structure = FALSE
#    )
#  )
#  bulk_import_jobs <- a$imports$bulk_submit_import(items = to_import)
#  
#  # Preview the results
#  bulk_import_jobs
#  
#  # Get updated status by fetching details with bulk_get() and by passing the
#  # list of import jobs created in the previous step
#  a$imports$bulk_get(imports = bulk_import_jobs$items)

## -----------------------------------------------------------------------------
#  ## First, get the volume you want to import files from
#  vol1 <- a$volumes$get(id = "<volume_owner_or_division>/<volume_name>")
#  
#  ## Then, get the project object or the ID of the project into which you want
#  # to import files
#  test_proj <- a$projects$get("<project_id>")
#  
#  ## List all volume files
#  vol1_content <- vol1$list_contents()
#  
#  ## Select two VolumeFile objects
#  volume_file_1_import <- vol1_content$items[[1]]
#  volume_file_2_import <- vol1_content$items[[2]]
#  
#  volume_files_to_import <- list(volume_file_1_import, volume_file_2_import)
#  
#  ## Construct the inputs list using the prepare_items_for_bulk_import() utility
#  # function
#  to_import <- prepare_items_for_bulk_import(
#    volume_items = volume_files_to_import,
#    destination_project = test_proj
#  )
#  
#  bulk_import_jobs <- a$imports$bulk_submit_import(items = to_import)
#  
#  # Preview the results
#  bulk_import_jobs
#  
#  # Get updated status by fetching details with bulk_get() and by passing the
#  # list of import jobs created in the previous step
#  a$imports$bulk_get(imports = bulk_import_jobs$items)

## -----------------------------------------------------------------------------
#  # List exports
#  all_exports <- a$exports$query()
#  
#  # Limit results to 5
#  exp_limit5 <- a$exports$query(limit = 5)
#  
#  # Load next page of 5 results
#  exp_limit5$next_page(advance_access = TRUE)
#  
#  # List all results until last page
#  exp_limit5$all()

## -----------------------------------------------------------------------------
#  # List exports with status RUNNING or FAILED
#  exp_states <- a$exports$query(state = c("RUNNING", "FAILED"))
#  
#  # List exports into a specific volume
#  exp_volume <- a$exports$query(
#    volume = "<volume_owner_or_division>/<volume_name>" # volume object or id
#  )

## -----------------------------------------------------------------------------
#  # Get the volume for which you want to list all exports
#  vol1 <- a$volumes$get(id = "<volume_owner_or_division>/<volume_name>")
#  
#  # List exports
#  vol1$list_exports()

## -----------------------------------------------------------------------------
#  # Get a single export
#  exp_obj <- auth$exports$get(id = "<export_job_id>")

## -----------------------------------------------------------------------------
#  # Get details of multiple export jobs
#  export_jobs <- a$exports$bulk_get(
#    exports = list("<export_job_id-1>", "<export_job_id-1>")
#  )

## -----------------------------------------------------------------------------
#  # First, get the volume you want to export files to
#  vol1 <- a$volumes$get(id = "<volume_owner_or_division>/<volume_name>")
#  
#  # Get the File object/id you want to export from the platform
#  test_file <- a$files$get("<file_id>")
#  
#  # Perform a file export
#  exp_job1 <- a$exports$submit_export(
#    source_file = test_file,
#    destination_volume = vol1,
#    destination_location = "new_volume_file.txt" # new name
#  )

## -----------------------------------------------------------------------------
#  # Print export job info
#  print(exp_job1)

## -----------------------------------------------------------------------------
#  # Export file into the folder 'test_folder'
#  exp_job2 <- a$exports$submit_export(
#    source_file = test_file,
#    destination_volume = vol1,
#    destination_location = "test_folder/new_volume_file.txt" # new name
#  )
#  
#  # Print export job info
#  print(exp_job2)

## -----------------------------------------------------------------------------
#  # Reload export object
#  exp_job1$reload()

## -----------------------------------------------------------------------------
#  ## First, get the project and files you want to export
#  test_proj <- a$projects$get("<project_id>")
#  proj_files <- test_proj$list_files()
#  
#  ## Choose the first 3 files to export
#  files_to_export <- proj_files$items[1:3]
#  
#  ## Then, get the volume you want to export files into
#  vol1 <- a$volumes$get(id = "<volume_owner_or_division>/<volume_name>")
#  
#  ## Construct the inputs list by filling the necessary information for each
#  # file to export
#  to_export <- list(
#    list(
#      source_file = files_to_export[[1]],
#      destination_volume = vol1,
#      destination_location = files_to_export[[1]]$name
#    ),
#    list(
#      source_file = "second-file-id",
#      destination_volume = vol1,
#      destination_location = "my-folder/exported_second_file.txt",
#      overwrite = TRUE
#    ),
#    list(
#      source_file = files_to_export[[3]],
#      destination_volume = vol1,
#      destination_location = files_to_export[[3]]$name,
#      overwrite = FALSE,
#      properties = list(
#        sse_algorithm = "AES256"
#      )
#    ),
#    copy_only = FALSE
#  )
#  bulk_export_jobs <- a$exports$bulk_submit_export(items = to_export)
#  
#  # Preview the results
#  bulk_export_jobs
#  
#  # Get updated status by fetching details with bulk_get() and by passing the
#  # list of export jobs created in the previous step
#  a$exports$bulk_get(exports = bulk_export_jobs$items)

## -----------------------------------------------------------------------------
#  ## First, get the project and files you want to export
#  test_proj <- a$projects$get("<project_id>")
#  proj_files <- test_proj$list_files()
#  
#  ## Then, get the volume you want to export files into
#  vol1 <- a$volumes$get(id = "<volume_owner_or_division>/<volume_name>")
#  
#  ## Select two File objects
#  file_1_export <- proj_files[[1]]
#  file_2_export <- proj_files[[2]]
#  
#  files_to_export <- list(file_1_export, file_2_export)
#  
#  ## Construct the inputs list using the prepare_items_for_bulk_export() utility
#  # function
#  to_export <- prepare_items_for_bulk_export(
#    files = files_to_export,
#    destination_volume = vol1,
#    destination_location_prefix = "my-folder/"
#  )
#  
#  bulk_export_jobs <- a$exports$bulk_submit_export(items = to_export)
#  
#  # Preview the results
#  bulk_export_jobs
#  
#  # Get updated status by fetching details with bulk_get() and by passing the
#  # list of export jobs created in the previous step
#  a$exports$bulk_get(exports = bulk_export_jobs$items)

