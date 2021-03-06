% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/geom_parttree.R
\name{geom_parttree}
\alias{geom_parttree}
\title{Visualise tree partitions}
\usage{
geom_parttree(
  mapping = NULL,
  data = NULL,
  stat = "identity",
  position = "identity",
  linejoin = "mitre",
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = TRUE,
  ...
)
}
\arguments{
\item{mapping}{Set of aesthetic mappings created by \code{\link[ggplot2:aes]{aes()}} or
\code{\link[ggplot2:aes_]{aes_()}}. If specified and \code{inherit.aes = TRUE} (the
default), it is combined with the default mapping at the top level of the
plot. You must supply \code{mapping} if there is no plot mapping.}

\item{data}{An \code{\link[rpart]{rpart.object}}, or an object of compatible
type (e.g. a decision tree produced using `parsnip`).}

\item{stat}{The statistical transformation to use on the data for this
layer, as a string.}

\item{position}{Position adjustment, either as a string, or the result of
a call to a position adjustment function.}

\item{linejoin}{Line join style (round, mitre, bevel).}

\item{na.rm}{If \code{FALSE}, the default, missing values are removed with
a warning. If \code{TRUE}, missing values are silently removed.}

\item{show.legend}{logical. Should this layer be included in the legends?
\code{NA}, the default, includes if any aesthetics are mapped.
\code{FALSE} never includes, and \code{TRUE} always includes.
It can also be a named logical vector to finely select the aesthetics to
display.}

\item{inherit.aes}{If \code{FALSE}, overrides the default aesthetics,
rather than combining with them. This is most useful for helper functions
that define both data and aesthetics and shouldn't inherit behaviour from
the default plot specification, e.g. \code{\link[ggplot2:borders]{borders()}}.}

\item{...}{Other arguments passed on to \code{\link[ggplot2:layer]{layer()}}. These are
often aesthetics, used to set an aesthetic to a fixed value, like
\code{colour = "red"} or \code{size = 3}. They may also be parameters
to the paired geom/stat.}
}
\description{
\code{geom_parttree()} is a simple extension of
  \code{\link[ggplot2]{geom_rect()}} that first calls \code{\link{parttree()}}
  to convert the inputted tree object into an amenable data frame.
}
\details{
Note that, because of the way \code{ggplot2} validates inputs and
  assembles plot layers, the data input for \code{geom_parttree()} (i.e. an
  \code{\link[rpart]{rpart.object}}) must assigned in the layer itself; not
  in the initialising \code{\link[ggplot2]{ggplot2()}} call. See Examples.
}
\section{Aesthetics}{

\code{geom_parttree()} aims to "work-out-of-the-box" with minimal input from
the user's side, apart from specifying the data object. This includes taking
care of the data transformation in a way that, generally, produces optimal
corner coordinates for each partition (i.e. `xmin`, `xmax`, `ymin`, and
`ymax`). However, it also understands the following aesthetics that users
may choose to specify manually:
\itemize{
 \item{\code{fill} (particularly encouraged, since this will provide a visual
 cue regarding the prediction in each partition region)}
 \item{\code{colour}}
 \item{\code{alpha}}
 \item{\code{linetype}}
 \item{\code{size}}
}
}

\examples{
library(ggplot2)
library(rpart)

## Simple decision tree (max of two predictor variables)
iris_tree = rpart(Species ~ Sepal.Width + Petal.Width, data=iris)
## Plot with original iris data only
p = ggplot(data = iris, aes(x=Petal.Width, y=Sepal.Width)) +
  geom_point(aes(col=Species)) ## Original data
## Add tree partitions to the plot (borders only)
p + geom_parttree(data = iris_tree)
## Better to use fill highlight predictions
p + geom_parttree(data = iris_tree, aes(fill=Species), alpha = 0.1)

## Various front-end frameworks are also supported, e.g.:
library(parsnip)

iris_tree2 =
  decision_tree() \%>\%
  set_engine("rpart") \%>\%
  set_mode("classification") \%>\%
  fit(Species ~ Sepal.Width + Petal.Width, data=iris)

p + geom_parttree(data = iris_tree2, aes(fill=Species), alpha = 0.1)
}
\seealso{
\code{\link{parttree()}}, \code{\link[ggplot2]{geom_rect()}}.
}
