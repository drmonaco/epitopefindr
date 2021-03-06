% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/trimEpitopes.R
\name{trimEpitopes}
\alias{trimEpitopes}
\title{Update BLAST table positions to reflect smaller intervals when a subinterval
has been determined as the minimal overlap of alignments to a peptide.}
\usage{
trimEpitopes(data, aln.size, tofilter = FALSE)
}
\arguments{
\item{data}{List containing BLAST table and fasta file and index peptide order to process.}

\item{aln.size}{Minimum length of alignment to consider from BLASTp alignments of 'data'.}

\item{tofilter}{Binary whether or not to filter BLAST table entries.}
}
\description{
Update BLAST table positions to reflect smaller intervals when a subinterval
has been determined as the minimal overlap of alignments to a peptide.
}
