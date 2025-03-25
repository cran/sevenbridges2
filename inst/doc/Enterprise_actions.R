## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  eval = FALSE
)

## -----------------------------------------------------------------------------
#  # Authenticate (division authentication token is required)
#  a <- Auth$new(platform = "aws-us", token = "<your-token>")
#  
#  # Query all divisions of which you are a member
#  a$divisions$query()

## -----------------------------------------------------------------------------
#  # Retrieve details of a specified division
#  a$divisions$get(id = "division-id")

## -----------------------------------------------------------------------------
#  # Retrieve details of a specified division
#  my_division <- a$divisions$get(id = "division-id")
#  
#  # List division teams you are a member of
#  my_division$list_teams()
#  
#  # List all teams in the division, including those you are not a member of
#  my_division$list_teams(list_all = TRUE)

## -----------------------------------------------------------------------------
#  # Retrieve details of a specific division
#  my_division <- a$divisions$get(id = "division-id")
#  
#  # List all members in the division
#  my_division$list_members()
#  
#  # List only members with the "ADMIN" role
#  my_division$list_members(role = "ADMIN")

## -----------------------------------------------------------------------------
#  # Retrieve details of a specific division
#  my_division <- a$divisions$get(id = "division-id")
#  
#  # Remove a member using their username
#  my_division$remove_member(user = "division-name/username")
#  
#  # Remove a member using a User object
#  members <- my_division$list_members(role = "MEMBER")
#  member_to_remove <- members$items[[1]]
#  my_division$remove_member(user = member_to_remove)

## -----------------------------------------------------------------------------
#  # Query all teams in a specific division
#  my_teams <- a$teams$query(division = "division-id", list_all = TRUE)
#  print(my_teams)

## -----------------------------------------------------------------------------
#  # Fetch single team by ID
#  my_test_team <- a$teams$get("my-test-team-id")
#  print(my_test_team)
#  
#  # Create new team
#  new_team <- a$teams$create(division = "division-id", name = "my-new-team")
#  print(new_team)
#  
#  # Delete a team
#  a$teams$delete(team = "my-new-team-id")

## -----------------------------------------------------------------------------
#  # Fetch a team by its ID
#  my_team <- a$teams$get("my-team-id")
#  
#  # List the team's members
#  my_team$list_members()

## -----------------------------------------------------------------------------
#  # Add a team member by providing their username
#  my_team$add_member(user = "division-name/username")

## -----------------------------------------------------------------------------
#  # Remove a team member by providing their username
#  my_team$remove_member(user = "division-name/username")

## -----------------------------------------------------------------------------
#  # Rename the team
#  my_team$rename(name = "new-team-name")

## -----------------------------------------------------------------------------
#  # Delete the team
#  my_team$delete()

