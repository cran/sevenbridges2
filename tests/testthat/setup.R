### Script for setting testing variables
# devtools::load_all()

# Dummy token
dummy_token <-
  stringi::stri_rand_strings(1, 32, pattern = "[a-z0-9]")

# Different bad token types
bad_tokens <- list(NA, "", NULL, list())

# Different bad url types
bad_urls <- list(NA, "", NULL, list())

# Different bad method types
bad_methods <- c(NA, "", NULL, "PUTT")

# Different bad encoding types
bad_encodings <- c(NA, "", NULL, "something else")

credentials_path <- testthat::test_path(
  "test_data",
  "sbg_credentials_test_file"
)

# Generate dummy token
test_token <- stringi::stri_rand_strings(1, 32, pattern = "[a-z0-9]")

# Auth object
setup_auth_object <-
  Auth$new(from = "file", config_file = credentials_path)

# Item object
setup_item_object <-
  Item$new(
    href = "resource-item-url",
    response = list("raw-response"),
    auth = setup_auth_object
  )

# Rate limit object
rate_limit_res <- list(
  rate = list(
    limit = 1000,
    remaining = 990,
    reset = 1693846218
  ),
  instance = list(
    limit = -1,
    remaining = 987654342
  )
)
setup_rate_limit_obj <- asRate(
  x = rate_limit_res,
  auth = setup_auth_object
)

# User obj
user_res <- list(
  username = "luna_lovegood",
  email = "luna.lovegood@hogwarts.com",
  first_name = "Luna",
  last_name = "Lovegood",
  affiliation = "Hogwarts",
  country = "United Kingdom"
)
setup_user_object <- asUser(
  x = user_res,
  auth = setup_auth_object
)

# Permission obj
setup_permission_obj <-
  Permission$new(
    write = TRUE,
    read = TRUE,
    copy = TRUE,
    execute = TRUE,
    admin = TRUE,
    href = NULL,
    response = list("raw-response"),
    auth = setup_auth_object
  )

# Projects obj
setup_projects_obj <- Projects$new(auth = setup_auth_object)

# Project obj response
project_res <- list(
  id = "project_id",
  name = "Project name",
  billing_group = "billing group",
  description = "Project description",
  tags = list("Tag1", "Tag2"),
  settings = list("locked" = FALSE),
  root_folder = "root_folder_id",
  created_by = "user1",
  created_on = as.POSIXct.POSIXlt(
    strptime("2023-06-10 13:36:00", "%Y-%m-%d %H:%M:%S")
  ),
  modified_on = as.POSIXct.POSIXlt(
    strptime("2023-07-10 13:36:00", "%Y-%m-%d %H:%M:%S")
  ),
  permissions = setup_permission_obj,
  category = "PRIVATE"
)
# Project obj
setup_project_obj <- asProject(
  x = project_res,
  auth = setup_auth_object
)

# Project member object
proj_member_res <- list(
  username = "test-member",
  email = "test-member@gmail.com", type = "USER",
  id = "test-member",
  permissions = Permission$new(
    read = TRUE, copy = FALSE, write = FALSE,
    execute = FALSE, admin = FALSE,
    href = NULL,
    auth = setup_auth_object,
    response = list(raw = "raw-response-list")
  ),
  href = "link/to/resource",
  response = list(raw = "raw-response-list")
)
setup_project_member_object <- asMember(
  x = proj_member_res,
  auth = setup_auth_object
)

# Files obj
setup_files_obj <- Files$new(auth = setup_auth_object)

file_res <- list(
  id = "file-id",
  name = "File name",
  size = 100,
  project = "user1/project-id",
  parent = "parent-id",
  type = "file",
  created_on = "2023-06-06T11:14:11Z",
  modified_on = "2023-06-06T11:14:11Z",
  href = "https://api.sbgenomics.com/v2/files/file-id",
  tags = list("tag_1"),
  metadata = list(
    sbg_public_files_category = "test",
    reference_genome = "HG19_Broad_variant",
    sample_id = "HCC1143_1M",
    case_id = "CCLE-HCC1143",
    investigation = "CCLE-BRCA"
  ),
  origin = list(task = "123a1a1a-12a1-1234-a123-1234567a1a12"),
  storage = list(
    type = "PLATFORM",
    hosted_on_locations = list("aws:us-east-1")
  )
)
setup_file_obj <- asFile(
  x = file_res,
  auth = setup_auth_object
)

folder_res <- list(
  id = "folder_id",
  name = "Folder_name",
  project = "user1/project-id",
  parent = "parent-id",
  type = "folder",
  created_on = "2023-06-06T11:14:11Z",
  modified_on = "2023-06-06T11:14:11Z",
  href = "https://api.sbgenomics.com/v2/files/folder_id",
  url = NA
)
setup_folder_obj <- asFile(
  x = folder_res,
  auth = setup_auth_object
)

# Setup Upload test object
setup_upload_object <- Upload$new(
  path = testthat::test_path("test_data"),
  filename = "new_name.txt",
  overwrite = TRUE,
  parent = "parent-id",
  file_size = 50 * 1024^2,
  part_size = 7 * 1024^2,
  auth = setup_auth_object
)

# Load raw cwl app
setup_app_path <- testthat::test_path(
  "test_data",
  "raw_app_list.RDS"
)
setup_raw_cwl <- readRDS(setup_app_path)

app_res <- list(
  id = "user_free_1/user-free-1-s-demo-project/fastqc-analysis/7",
  project = "user_free_1/user-free-1-s-demo-project",
  name = "FastQC Analysis",
  revision = 0,
  raw = setup_raw_cwl,
  copy_of = NA,
  latest_revision = 0
)
setup_app_obj <- asApp(
  x = app_res,
  auth = setup_auth_object
)

# Resource_obj
setup_resource_obj <- Resource$new(auth = setup_auth_object)

# Apps obj
setup_apps_obj <- Apps$new(auth = setup_auth_object)

# Volumes obj
setup_volumes_obj <- Volumes$new(auth = setup_auth_object)

# Volume obj
volume_res <- list(
  id = "volume-id",
  name = "my_new_volume",
  access_mode = "RW",
  service = list(
    type = "s3",
    bucket = "bucket-name",
    prefix = "",
    endpoint = "s3.amazonaws.com",
    credentials = list(
      access_key_id = "access_key_id"
    ),
    properties = list(
      sse_algorithm = "AES256"
    ),
    export_enabled = TRUE,
    direct_export_enabled = FALSE
  ),
  created_on = "2023-06-15T14:50:16Z",
  modified_on = "2023-06-15T14:50:16Z",
  active = TRUE
)
setup_s3_volume_obj <- asVolume(
  x = volume_res,
  auth = setup_auth_object
)

# Collection object
setup_collection_obj <- Collection$new(
  href = "some-href",
  items = list(
    item1 = list(field1 = "value11", field2 = "value12"),
    item2 = list(field1 = "value21", field2 = "value22"),
    item3 = list(field1 = "value31", field2 = "value32")
  ),
  links = list(
    list(href = "link-to-next-page", method = "GET", rel = "next"),
    list(href = "link-to-prev-page", method = "GET", rel = "prev")
  ),
  response = list(raw = "raw-response-list"),
  auth = setup_auth_object
)

# VolumeFile object
volume_file_res <- list(
  location = "my_new_file.txt",
  type = "s3",
  volume = "my_s3_volume",
  metadata = list(metadata_field = "metadata-value"),
  href = "resource-href"
)
setup_volume_file_obj <- asVolumeFile(
  x = volume_file_res,
  auth = setup_auth_object
)
# VolumePrefix object
volume_prefix_res <- list(
  prefix = "my_new_folder",
  volume = "my_s3_volume",
  href = "resource-href"
)
setup_volume_prefix_obj <- asVolumePrefix(
  x = volume_prefix_res,
  auth = setup_auth_object
)

# VolumeFileCollection object
vol_content_collection_res <- list(
  href = "some-href",
  items = list(
    list(
      href = "resource-href",
      location = "my_new_file1.txt",
      type = "s3",
      volume = "my_s3_volume",
      metadata = list(metadata_field = "metadata-value")
    ),
    list(
      href = "resource-href",
      location = "my_new_file2.txt",
      type = "s3",
      volume = "my_s3_volume",
      metadata = list(metadata_field = "metadata-value")
    )
  ),
  prefixes = list(list(
    href = "resource-href",
    prefix = "my_new_folder",
    volume = "my_s3_volume"
  )),
  links = list(list("next" = "link-to-next-page")),
  response = list(raw = "raw-response-list")
)
setup_volcont_collection_obj <- asVolumeContentCollection(
  x = vol_content_collection_res,
  auth = setup_auth_object
)

# Volume member object
volume_member_res <- list(
  username = "test-member",
  email = "test-member@gmail.com", type = "USER",
  id = "test-member",
  permissions = Permission$new(
    read = TRUE, copy = FALSE, write = FALSE,
    execute = NULL, admin = FALSE,
    href = NULL,
    auth = setup_auth_object,
    response = list(raw = "raw-response-list")
  ),
  href = "link/to/resource",
  response = list(raw = "raw-response-list")
)
setup_volume_member_object <- asMember(
  x = volume_member_res,
  auth = setup_auth_object
)

# Imports obj
setup_imports_obj <- Imports$new(auth = setup_auth_object)

file_obj_params_list <- list(
  id = "file-id",
  name = "File_name",
  size = 100,
  project = "user1/project-id",
  parent = "parent-id",
  type = "file",
  created_on = "2023-06-06T11:14:11Z",
  modified_on = "2023-06-06T11:14:11Z",
  href = "https://api.sbgenomics.com/v2/files/file-id",
  auth = setup_auth_object
)
# Import obj
import_res <- list(
  href = "link-to-the-resource",
  id = "import-job-id",
  state = "COMPLETED",
  overwrite = FALSE,
  autorename = TRUE,
  preserve_folder_structure = NULL,
  source = list(volume = "volume-id", location = "location-name"),
  destination = list(project = "project-id", name = "file_name.txt"),
  started_on = "2023-07-13T12:34:56Z",
  finished_on = "2023-07-13T12:34:56Z",
  error = NULL,
  result = file_obj_params_list
)
setup_import_obj <- asImport(
  x = import_res,
  auth = setup_auth_object
)

# Tasks obj
setup_tasks_obj <- Tasks$new(auth = setup_auth_object)

task_res <- list(
  id = "task-id",
  name = "Task name",
  description = "My new test task",
  project = "project-id",
  app = "app-id",
  created_by = "user1",
  executed_by = "user1",
  created_on = "12-08-2023",
  start_time = "12-08-2023",
  end_time = "12-08-2023"
)
# Task obj
setup_task_obj <- asTask(
  x = task_res,
  auth = setup_auth_object
)

# Exports obj
setup_exports_obj <- Exports$new(auth = setup_auth_object)

# Export obj
export_res <- list(
  href = "link-to-the-resource",
  id = "export-job-id",
  state = "COMPLETED",
  overwrite = FALSE,
  properties = NULL,
  source = list(file = "file-id"),
  destination = list(volume = "volume-id", location = "file_name.txt"),
  started_on = "2023-07-14T12:34:56Z",
  finished_on = "2023-07-14T12:34:56Z",
  error = NULL,
  result = file_obj_params_list
)
setup_export_obj <- asExport(
  x = export_res,
  auth = setup_auth_object
)

setup_task_inputs_raw <- list(
  input_reads = list(
    list(
      path = "input_reads_nested_file_1_id",
      metadata = list(paired_end = "1", sample_id = "TCRBOA3-T"),
      size = 12580652281,
      contents = NULL,
      name = "TCRBOA3-T-WEX.read1.fastq",
      checksum = NULL,
      location = "input_reads_file_1_id_location",
      class = "File",
      dirname = "/Projects/parent_id/"
    ),
    list(
      path = "input_reads_nested_file_2_id",
      metadata = list(paired_end = "2", sample_id = "TCRBOA3-T"),
      size = 12580652281,
      contents = NULL,
      name = "TCRBOA3-T-WEX.read2.fastq",
      checksum = NULL,
      location = "input_reads_nested_file_2_location",
      class = "File",
      dirname = "/Projects/parent-id/"
    ),
    another_level_nested = list(
      list(
        path = "input_reads_nested_file_3_id",
        class = "File"
      ),
      list(
        path = "input_reads_nested_file_4_id",
        class = "File"
      )
    )
  ),
  target_bed = list(
    path = "target_bed_file_id",
    metadata = structure(list(), names = character(0)),
    size = 5312162L,
    contents = NULL,
    name = "v5_core_targets.refse-ccds-gencode-ucsc.bed",
    checksum = NULL,
    location = "target_bed_file_location",
    class = "File",
    dirname = "/Projects/parent_id/reference_files/"
  ),
  bait_bed = list(
    path = "bait_bed_id",
    metadata = structure(list(), names = character(0)),
    size = 5506630L,
    contents = NULL,
    name = "SureSelect_XT_Human_All_Exon_V5_annot.bed",
    checksum = NULL,
    location = "bait_bed_location",
    class = "File",
    dirname = "/Projects/parent_id/reference_files/"
  ),
  kgsnp_database = list(
    path = "kgsnp_database_id",
    metadata = structure(list(), names = character(0)),
    size = 7398865818,
    contents = NULL,
    name = "1000G_phase1.snps.high_confidence.hg19.sites.vcf",
    checksum = NULL,
    location = "kgsnp_database_location",
    class = "File",
    dirname = "/Projects/parent_id/reference_files/"
  ),
  input_tar_with_reference = list(
    path = "input_tar_with_reference_id",
    metadata = list(library_id = "UCSC"),
    size = 8689960960,
    contents = NULL,
    name = "ucsc.hg19.fasta.tar",
    checksum = NULL,
    location = "input_tar_with_reference_location",
    class = "File",
    dirname = "/Projects/parent_id/reference_files/"
  ),
  mgindel_database = list(
    path = "mgindel_database_id",
    metadata = structure(list(), names = character(0)),
    size = 20718745L,
    contents = NULL,
    name = "Mills_and_1000G_gold_standard.tab.indels.hg19.sites.vcf.gz",
    checksum = NULL,
    location = "mgindel_database_location",
    class = "File",
    dirname = "/Projects/parent_id/reference_files/"
  ),
  char = "char_value",
  double = 235.6,
  some_vars = list(
    int = 10,
    str = "text"
  )
)

setup_task_outputs_raw <- list(
  alignment_metrics = list(
    path = "alignment_metrics_id",
    size = 2337L,
    name = "_1_TCRBOA3-T.ALN_METRIC.txt",
    checksum = "sum",
    location = NULL,
    secondaryFiles = list(),
    class = "File",
    dirname = "/mnt/nosbgfs/workspaces/wp-id/tasks/task-id/SBG_Rename_App_4"
  ),
  per_target_coverage = list(
    path = "per_target_coverage_id",
    size = 18757531L,
    name = "_1_TCRBOA3-T.per_target_coverage.txt",
    checksum = "sum",
    location = NULL,
    class = "File",
    dirname = "/mnt/nosbgfs/workspaces/wp-id/tasks/task-id/Picard_CollectHsMetrics" # nolint
  ),
  hs_metrics = list(
    path = "hs_metrics_id",
    size = 5523L,
    name = "_1_TCRBOA3-T.hsMetrics.txt",
    checksum = "sum",
    location = NULL,
    class = "File",
    dirname = "/mnt/nosbgfs/workspaces/wp-id/tasks/task-id/Picard_CollectHsMetrics" # nolint
  ),
  dedup_metrics = list(
    path = "dedup_metrics_id",
    size = 2952L,
    name = "_1_TCRBOA3-T.DEDUP.txt",
    checksum = "sum",
    location = NULL,
    secondaryFiles = list(),
    class = "File",
    dirname = "/mnt/nosbgfs/workspaces/wp-id/tasks/task-id/SBG_Rename_App"
  ),
  output_bam = list(
    path = "output_bam_id",
    size = 6632805966,
    name = "_1_TCRBOA3-T.sorted.dedup.recal.bam",
    checksum = "sum",
    location = NULL,
    secondaryFiles = list(
      list(
        path = "sec_file_id",
        metadata = list(
          `__inherit__` = "input_bam",
          intervals_file = "v5_core_targets.refse-ccds-gencode-ucsc.bed",
          reference_genome = "ucsc.hg19",
          sample_id = "TCRBOA3-T"
        ),
        size = 2950000L,
        contents = NULL,
        name = "_1_TCRBOA3-T.sorted.dedup.recal.bam.bai",
        checksum = "sum",
        location = "parent-id",
        class = "File",
        dirname = "/mnt/nosbgfs/workspaces/wp-id/tasks/task-id/SBG_Rename_App_2" # nolint
      )
    ),
    class = "File",
    dirname = "/mnt/nosbgfs/workspaces/wp-id/tasks/task-id/SBG_Rename_App_2" # nolint
  ),
  recal_table = list(
    path = "recal_table_id", size = 861779L,
    name = "_1_TCRBOA3-T.recal_result.txt",
    checksum = "sum",
    location = NULL, secondaryFiles = list(), class = "File",
    dirname = "/mnt/nosbgfs/workspaces/wp-id/tasks/task-id/SBG_Rename_App_1" # nolint
  )
)

# Billing_groups obj
setup_billing_groups_obj <- Billing_groups$new(auth = setup_auth_object)

# Billing obj
billing_group_res <- list(
  id = "some-id",
  href = "some-href",
  owner = "some-owner",
  name = "some-name",
  type = "regular",
  pending = FALSE,
  disabled = FALSE,
  balance = list(
    currency = "Galleon [ʛ]",
    amount = "33333.3"
  )
)

setup_billing_obj <- asBilling(x = billing_group_res, auth = setup_auth_object)

# Invoices obj
setup_invoices_obj <- Invoices$new(auth = setup_auth_object)

# Invoice obj
invoice_res <- list(
  id = "some-id",
  href = "some-href",
  pending = FALSE,
  approval_date = "2020-01-01T00:00:00Z",
  invoice_period = list(
    from = "2020-01-01T11:00:00Z",
    to = "2020-01-31T23:59:59Z"
  ),
  analysis_costs = list(
    currency = "USD",
    amount = "1244.1"
  ),
  analysis_costs = list(
    currency = "USD",
    amount = "117.4"
  ),
  total = list(
    currency = "USD",
    amount = "1361.5"
  )
)

setup_invoice_obj <- asInvoice(x = invoice_res, auth = setup_auth_object)

# Setup App's inputs list with different cwl cases combined together
setup_app_inputs_list <-
  list(
    list(
      type = list("null", "File"), label = "Reference Genome FASTA",
      `sbg:fileTypes` = "FASTA", id = "#Reference_Genome_FASTA",
      `sbg:x` = 256.000007271767, `sbg:y` = 222.000005692244
    ),
    list(
      type = list("null", list(type = "array", items = "File")),
      label = "BAM_files", id = "#input_list", `sbg:x` = 67.9999739378687,
      `sbg:y` = 453.988288149063
    ), list(
      id = "in_alignments",
      `sbg:fileTypes` = "SAM, BAM, CRAM", type = "File", label = "Unmapped BAM",
      doc = "Unmapped BAM file.", `sbg:x` = -1237L, `sbg:y` = -463L
    ),
    list(
      id = "known_indels", `sbg:fileTypes` = "VCF", type = "File[]?",
      label = "Known INDELs", doc = "Known INDELs.", secondaryFiles = list(
        ".idx"
      ), `sbg:x` = 729.852416992188, `sbg:y` = -223.191284179688
    ),
    list(
      id = "scatter_count", type = "int?", doc = "Scatter count.",
      `sbg:exposed` = TRUE
    ), list(
      `sbg:category` = "Options",
      id = "factor", type = "string", inputBinding = list(
        prefix = "--factor=",
        separate = FALSE, shellQuote = FALSE, position = 3L
      ), # nolint start
      label = "Covariate of interest", doc = "The samples will be grouped according to the chosen variable of interest. This needs to match either a column name in the provided phenotype data CSV file or a metadata key. If the latter is true, then all the input files need to have this metadata field populated."
    ), # nolint end
    list(
      id = "quantification_tool", type = list(
        type = "enum",
        symbols = list(
          "htseq", "kallisto", "salmon", "sailfish",
          "rsem", "stringtie"
        ), name = "quantification_tool"
      ),
      inputBinding = list(
        prefix = "--quant=", separate = FALSE,
        shellQuote = FALSE, position = 3L
      ), label = "Quantification tool",
      doc = "Tool that generated abundance estimates."
    ), list(
      id = "in_tax", type = "Directory?", label = "Taxonomy directory",
      # nolint start
      doc = "Path to directory containing a taxonomy database to use. By default, /opt/Krona-2.8.1/KronaTools/taxonomy will be used.",
      # nolint end
      `sbg:x` = 612.62109375, `sbg:y` = 384L, loadListing = "deep_listing"
    ),
    list(
      id = "Sample_Tags_Version", type = list("null", list(
        type = "enum", symbols = list(
          "No Multiplexing", "Single-Cell Multiplex Kit - Human",
          "Single-Cell Multiplex Kit - Mouse", "Single-Cell Multiplex Kit - Flex" # nolint
        ),
        name = "Sample_Tags_Version"
      )), label = "Sample Tags Version",
      # nolint start
      description = "The sample multiplexing kit version.  This option should only be set for a multiplexed experiment."
      # nolint end
    )
  )

setup_app_outputs_list <- list(
  list(
    id = "#summary_metrics", label = "Summary Metrics",
    source = list("#Picard_CollectAlignmentSummaryMetrics.summary_metrics"),
    type = list("File"), `sbg:fileTypes` = "TXT", required = TRUE,
    `sbg:y` = 317.000007256866, `sbg:x` = 1185.00002108514
  ),
  list(
    id = "out_filtered_variants",
    outputSource = list("gatk_variantfiltration_4_1_0_0/out_variants"),
    `sbg:fileTypes` = "VCF.GZ", type = "File?", label = "Output filtered VCF",
    doc = "Output filtered VCF file.", `sbg:x` = 2750.72924804688,
    `sbg:y` = -106.195388793945
  ), list(
    id = "html_report",
    doc = "HTML report.", label = "HTML report", type = "File?",
    outputBinding = list(
      glob = "*.b64html",
      outputEval = "${\n return inheritMetadata(self, inputs.abundances)\n\n}"
    ),
    `sbg:fileTypes` = "HTML"
  ), list(
    id = "normalized_counts",
    doc = "Counts normalized using estimated sample-specific normalization factors.", # nolint
    label = "Normalized counts", type = "File?", outputBinding = list(
      glob = "*raw_counts.txt",
      outputEval = "${\n return inheritMetadata(self, inputs.abundances)\n\n}"
    ),
    `sbg:fileTypes` = "TXT"
  ), list(
    id = "results", doc = "Output CSV file.",
    label = "DESeq2 analysis results.", type = "File?", outputBinding = list(
      glob = "*out.csv",
      outputEval = "${\n return inheritMetadata(self, inputs.abundances)\n\n}"
    ),
    `sbg:fileTypes` = "CSV"
  ), list(
    id = "rdata", doc = "Workspace image.",
    label = "RData file", type = "File[]?", outputBinding = list(
      glob = "*.RData"
    ), `sbg:fileTypes` = "RDATA"
  ), list(
    id = "pheno_out", type = "File?", outputBinding = list(
      glob = "pheno_data.csv"
    )
  ), list(
    id = "out_report",
    outputSource = list("bracken_2_7/out_report"), `sbg:fileTypes` = "REPORT",
    type = "File[]?", label = "Bracken read estimates",
    doc = "Bracken read estimates report file.",
    `sbg:x` = 1692.93395996094, `sbg:y` = 223.5
  ), list(
    id = "vdj",
    outputSource = list(
      "VDJ_Compile_Results/vdjCellsDatatable",
      "VDJ_Compile_Results/vdjCellsDatatableUncorrected",
      "VDJ_Compile_Results/vdjUnfilteredContigsAIRR",
      "VDJ_Compile_Results/vdjDominantContigsAIRR",
      "VDJ_Compile_Results/vdjMetricsCsv"
    ), type = "File[]?",
    label = "VDJ"
  ), list(id = "Logs", outputSource = list(
    "BundleLogs/logs_dir"
  ), type = "Directory", label = "Pipeline Logs"),
  list(
    id = "Multiplex", outputSource = list("MergeMultiplex/Multiplex_out"),
    type = "File[]?"
  )
)

# Setup example lists for comparison when testing lists_eq method
list1_to_compare <- structure(list(
  url = "https://api.sbgenomics.com/v2/users/demo-user",
  status_code = 200L,
  headers = structure(list(
    server = "nginx",
    date = "Fri, 31 May 2024 12:13:21 GMT",
    `content-type` = "application/json",
    accept = "application/json"
  ), class = c("insensitive", "list")),
  all_headers = list(
    list(
      status = 307L,
      version = "HTTP/2",
      headers = structure(
        list(
          server = "nginx",
          date = "Fri, 31 May 2024 12:13:21 GMT",
          `content-length` = "0",
          location = "https://api.sbgenomics.com/v2/users/demo-user"
        ),
        class = c("insensitive", "list")
      )
    ),
    list(status = 200L, version = "HTTP/2", headers = list())
  ),
  content = as.raw(c(
    0x7b, 0x22, 0x68, 0x72, 0x65, 0x66, 0x22, 0x3a,
    0x22, 0x68, 0x74, 0x74, 0x70, 0x73, 0x3a, 0x2f,
    0x2f, 0x61, 0x70, 0x69, 0x2e, 0x73, 0x62, 0x67,
    0x65, 0x6e, 0x6f, 0x6d, 0x69, 0x63, 0x73, 0x2e,
    0x63, 0x6f, 0x6d, 0x2f, 0x76, 0x32, 0x2f, 0x75,
    0x73, 0x65, 0x72, 0x73, 0x2f, 0x6d, 0x61, 0x72,
    0x69, 0x6a, 0x61, 0x6a, 0x6f, 0x76, 0x61, 0x6e,
    0x6f, 0x76, 0x69, 0x63, 0x22, 0x2c, 0x22, 0x75,
    0x73, 0x65, 0x72, 0x6e, 0x61, 0x6d, 0x65, 0x22,
    0x3a, 0x22, 0x6d, 0x61, 0x72, 0x69, 0x6a, 0x61,
    0x6a, 0x6f, 0x76, 0x61, 0x6e, 0x6f, 0x76, 0x69,
    0x63, 0x22, 0x2c, 0x22, 0x65, 0x6d, 0x61, 0x69,
    0x6c, 0x22, 0x3a, 0x22, 0x6d, 0x61, 0x72, 0x69,
    0x6a, 0x61, 0x2e, 0x6a, 0x6f, 0x76, 0x61, 0x6e,
    0x6f, 0x76, 0x69, 0x63, 0x40, 0x73, 0x65, 0x76,
    0x65, 0x6e, 0x62, 0x72, 0x69, 0x64, 0x67, 0x65,
    0x73, 0x2e, 0x63, 0x6f, 0x6d, 0x22, 0x2c, 0x22
  )),
  date = structure(1717157601, class = c("POSIXct", "POSIXt"), tzone = "GMT"),
  request = structure(list(
    method = "GET",
    url = "https://api.sbgenomics.com/v2/user/?limit=50&offset=0&fields=_all",
    headers = c(
      `X-SBG-Auth-Token` = "token",
      Accept = "application/json", `Content-Type` = "application/json"
    ),
    fields = NULL, options = list(
      useragent = "libcurl/7.86.0 r-curl/5.2.1 httr/1.4.7",
      httpget = TRUE
    ), auth_token = NULL
  ), class = "request"),
  handle = "<pointer: 0x7fcfaf9b2b90>"
), class = "response")


# Setup AsyncJob object
asyncjob_res <- list(
  id = "some-id",
  href = "some-href",
  type = "type",
  state = "FINISHED",
  result = "result",
  total_files = 6,
  completed_files = 6,
  failed_files = 0,
  started_on = "2025-01-31",
  finished_on = "2025-01-31"
)

setup_async_job_obj <- asAsyncJob(x = asyncjob_res, auth = setup_auth_object)


# Setup Division object
division_res <- list(
  id = "some-id",
  href = "some-href",
  name = "my-division"
)

setup_division_obj <- asDivision(x = division_res, auth = setup_auth_object)

# Setup Divisions obj
setup_divisions_obj <- Divisions$new(auth = setup_auth_object)

# Setup Team object
team_res <- list(
  id = "some-id",
  href = "some-href",
  name = "my-team"
)

setup_team_obj <- asTeam(x = team_res, auth = setup_auth_object)

# Setup Teams obj
setup_teams_obj <- Teams$new(auth = setup_auth_object)

# Create a division object and override its auth$user method to simulate a
# scenario where the division was fetched by a user with the 'ADMIN' role.
setup_auth_admin <- Auth$new(from = "file", config_file = credentials_path)
setup_div_with_admin <- asDivision(x = division_res, auth = setup_auth_admin)
unlockBinding("user", setup_div_with_admin$auth)
setup_div_with_admin$auth$user <- function() {
  list(
    username = "albus_dumbledore",
    email = "albus.dumbledore@hogwarts.com",
    first_name = "Albus",
    last_name = "Dumbledore",
    affiliation = "Hogwarts",
    country = "United Kingdom",
    role = "ADMIN"
  )
}

# Create a division object and override its auth$user method to simulate a
# scenario where the division was fetched by a user with the 'MEMBER' role.
setup_auth_member <- Auth$new(from = "file", config_file = credentials_path)
setup_div_with_member <- asDivision(x = division_res, auth = setup_auth_member) # nolint
unlockBinding("user", setup_div_with_member$auth)
setup_div_with_member$auth$user <- function() {
  list(
    username = "hermione_granger",
    email = "hermione.granger@hogwarts.com",
    first_name = "Hermione",
    last_name = "Granger",
    affiliation = "Hogwarts",
    country = "United Kingdom",
    role = "MEMBER"
  )
}

# Create a division object and override its auth$user method to simulate a
# scenario where the division was fetched by a user with the
# 'EXTERNAL_COLLABORATOR' role.
setup_auth_ext_collab <- Auth$new(from = "file", config_file = credentials_path) # nolint
setup_div_with_ext_collab <- asDivision(x = division_res, auth = setup_auth_ext_collab) # nolint
unlockBinding("user", setup_div_with_ext_collab$auth)
setup_div_with_ext_collab$auth$user <- function() {
  list(
    username = "fleur_delacour",
    email = "fleur.delacour@beauxbatons.fr",
    first_name = "Fleur",
    last_name = "Delacour",
    affiliation = "Beauxbatons",
    country = "France",
    role = "EXTERNAL_COLLABORATOR"
  )
}

# Close session at the end of tests
withr::defer(teardown_env())
