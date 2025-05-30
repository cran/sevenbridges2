% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/class-team.R
\name{Team}
\alias{Team}
\title{R6 Class representing a Team}
\description{
R6 Class representing a central resource for managing teams.
}
\examples{

## ------------------------------------------------
## Method `Team$print`
## ------------------------------------------------

\dontrun{
 team_object <- Team$new(
 	res = x,
		href = x$href,
		auth = auth,
		response = attr(x, "response")
 )
 team_object$print()
}

## ------------------------------------------------
## Method `Team$reload`
## ------------------------------------------------

\dontrun{
 team_object <- Team$new(
   res = x,
   href = x$href,
   auth = auth,
   response = attr(x, "response")
 )
 team_object$reload()
}


## ------------------------------------------------
## Method `Team$list_members`
## ------------------------------------------------

\dontrun{
  # Retrieve details of a specified team
  my_team <- a$teams$get(id = "team-id")

  # Retrieve a list of all team members
  my_team$list_members()
}


## ------------------------------------------------
## Method `Team$add_member`
## ------------------------------------------------

\dontrun{
  # Retrieve details of a specified team
  my_team <- a$teams$get(id = "team-id")

  # Add new member to the team
  my_team$add_member(user = "user-id")
}

## ------------------------------------------------
## Method `Team$remove_member`
## ------------------------------------------------

\dontrun{
  # Retrieve details of a specified team
  my_team <- a$teams$get(id = "team-id")

  # Remove a member from the team
  my_team$remove_member(user = "user-id")
}

## ------------------------------------------------
## Method `Team$rename`
## ------------------------------------------------

\dontrun{
  # Retrieve details of a specified team
  my_team <- a$teams$get(id = "team-id")

  # Rename the team
  my_team$rename(name = "new-team-name")
}

## ------------------------------------------------
## Method `Team$delete`
## ------------------------------------------------

\dontrun{
  # Retrieve details of a specified team
  my_team <- a$teams$get(id = "team-id")

  # Delete a team
  my_team$delete()
}
}
\section{Super class}{
\code{\link[sevenbridges2:Item]{sevenbridges2::Item}} -> \code{Team}
}
\section{Public fields}{
\if{html}{\out{<div class="r6-fields">}}
\describe{
\item{\code{URL}}{List of URL endpoints for this resource.}

\item{\code{id}}{The ID of the team.}

\item{\code{name}}{Team's name.}
}
\if{html}{\out{</div>}}
}
\section{Methods}{
\subsection{Public methods}{
\itemize{
\item \href{#method-Team-new}{\code{Team$new()}}
\item \href{#method-Team-print}{\code{Team$print()}}
\item \href{#method-Team-reload}{\code{Team$reload()}}
\item \href{#method-Team-list_members}{\code{Team$list_members()}}
\item \href{#method-Team-add_member}{\code{Team$add_member()}}
\item \href{#method-Team-remove_member}{\code{Team$remove_member()}}
\item \href{#method-Team-rename}{\code{Team$rename()}}
\item \href{#method-Team-delete}{\code{Team$delete()}}
\item \href{#method-Team-clone}{\code{Team$clone()}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-Team-new"></a>}}
\if{latex}{\out{\hypertarget{method-Team-new}{}}}
\subsection{Method \code{new()}}{
Create a new Team object.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{Team$new(res = NA, ...)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{res}}{Response containing the Team object information.}

\item{\code{...}}{Other response arguments.}
}
\if{html}{\out{</div>}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-Team-print"></a>}}
\if{latex}{\out{\hypertarget{method-Team-print}{}}}
\subsection{Method \code{print()}}{
Print method for Team class.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{Team$print()}\if{html}{\out{</div>}}
}

\subsection{Examples}{
\if{html}{\out{<div class="r example copy">}}
\preformatted{\dontrun{
 team_object <- Team$new(
 	res = x,
		href = x$href,
		auth = auth,
		response = attr(x, "response")
 )
 team_object$print()
}
}
\if{html}{\out{</div>}}

}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-Team-reload"></a>}}
\if{latex}{\out{\hypertarget{method-Team-reload}{}}}
\subsection{Method \code{reload()}}{
Reload Team object information.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{Team$reload(...)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{...}}{Other arguments that can be passed to core \code{api()} function
like 'fields', etc.}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
\code{\link{Team}} object.
}
\subsection{Examples}{
\if{html}{\out{<div class="r example copy">}}
\preformatted{\dontrun{
 team_object <- Team$new(
   res = x,
   href = x$href,
   auth = auth,
   response = attr(x, "response")
 )
 team_object$reload()
}

}
\if{html}{\out{</div>}}

}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-Team-list_members"></a>}}
\if{latex}{\out{\hypertarget{method-Team-list_members}{}}}
\subsection{Method \code{list_members()}}{
This call retrieves a list of all team members within a
specified team. Each member's username will be returned.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{Team$list_members(
  limit = getOption("sevenbridges2")$limit,
  offset = getOption("sevenbridges2")$offset,
  ...
)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{limit}}{The maximum number of collection items to return
for a single request. Minimum value is \code{1}.
The maximum value is \code{100} and the default value is \code{50}.
This is a pagination-specific attribute.}

\item{\code{offset}}{The zero-based starting index in the entire collection
of the first item to return. The default value is \code{0}.
This is a pagination-specific attribute.}

\item{\code{...}}{Other arguments that can be passed to core \code{api()} function
like 'fields', etc.}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
A \code{\link{Collection}} of \code{\link{User}} objects.
}
\subsection{Examples}{
\if{html}{\out{<div class="r example copy">}}
\preformatted{\dontrun{
  # Retrieve details of a specified team
  my_team <- a$teams$get(id = "team-id")

  # Retrieve a list of all team members
  my_team$list_members()
}

}
\if{html}{\out{</div>}}

}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-Team-add_member"></a>}}
\if{latex}{\out{\hypertarget{method-Team-add_member}{}}}
\subsection{Method \code{add_member()}}{
This call adds a division member to the specified team.
This action requires \code{ADMIN} privileges.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{Team$add_member(user)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{user}}{User ID of the division member you are adding to the team
using the following format: \code{division_id/username}. Alternatively,
a \code{User} object can be provided.}
}
\if{html}{\out{</div>}}
}
\subsection{Examples}{
\if{html}{\out{<div class="r example copy">}}
\preformatted{\dontrun{
  # Retrieve details of a specified team
  my_team <- a$teams$get(id = "team-id")

  # Add new member to the team
  my_team$add_member(user = "user-id")
}
}
\if{html}{\out{</div>}}

}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-Team-remove_member"></a>}}
\if{latex}{\out{\hypertarget{method-Team-remove_member}{}}}
\subsection{Method \code{remove_member()}}{
This call removes a member from a team. By removing a
member, you remove the user's membership to the team, but do not
remove their account from the division.
This action requires \code{ADMIN} privileges.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{Team$remove_member(user)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{user}}{The Seven Bridges Platform username of the user to be
removed, specified in the format \code{division-name/username}, or an object
of class \code{User} that contains the username.}
}
\if{html}{\out{</div>}}
}
\subsection{Examples}{
\if{html}{\out{<div class="r example copy">}}
\preformatted{\dontrun{
  # Retrieve details of a specified team
  my_team <- a$teams$get(id = "team-id")

  # Remove a member from the team
  my_team$remove_member(user = "user-id")
}
}
\if{html}{\out{</div>}}

}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-Team-rename"></a>}}
\if{latex}{\out{\hypertarget{method-Team-rename}{}}}
\subsection{Method \code{rename()}}{
This call renames the specified team. This action requires
\code{ADMIN} privileges.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{Team$rename(name = NULL)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{name}}{The new name for the team.}
}
\if{html}{\out{</div>}}
}
\subsection{Examples}{
\if{html}{\out{<div class="r example copy">}}
\preformatted{\dontrun{
  # Retrieve details of a specified team
  my_team <- a$teams$get(id = "team-id")

  # Rename the team
  my_team$rename(name = "new-team-name")
}
}
\if{html}{\out{</div>}}

}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-Team-delete"></a>}}
\if{latex}{\out{\hypertarget{method-Team-delete}{}}}
\subsection{Method \code{delete()}}{
This call deletes a team. By deleting a team, you remove
the users' membership to the team, but do not remove their accounts
from the division.
This action requires \code{ADMIN} privileges.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{Team$delete()}\if{html}{\out{</div>}}
}

\subsection{Examples}{
\if{html}{\out{<div class="r example copy">}}
\preformatted{\dontrun{
  # Retrieve details of a specified team
  my_team <- a$teams$get(id = "team-id")

  # Delete a team
  my_team$delete()
}
}
\if{html}{\out{</div>}}

}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-Team-clone"></a>}}
\if{latex}{\out{\hypertarget{method-Team-clone}{}}}
\subsection{Method \code{clone()}}{
The objects of this class are cloneable with this method.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{Team$clone(deep = FALSE)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{deep}}{Whether to make a deep clone.}
}
\if{html}{\out{</div>}}
}
}
}
