#' epitopefindr: a package for identifying minimal overlaps from BLAST alignments.
#'
#'
#'The purpose of this package is to describe the alignments among a set of
#'peptide sequences by reporting the overlaps of each peptide's alignments to
#'other peptides in the set. One can imagine inputting a list of peptides
#'enriched by immunoprecipitation to identify corresponding epitopes.
#'
#'`epitopefindr` takes a .fasta file listing peptide sequences of interest and
#'calls BLASTp from within R to identify alignments among these peptides. Each
#'peptide's alignments to other peptides are then simplified to the minimal
#'number of "non overlapping" intervals* of the index peptide that represent all
#'alignments to other peptides reported by BLAST. *By default, each interval
#'must be at least 7 amino acids long, and two intervals are considered NOT
#'overlapping if they share 6 or fewer amino acids. After the minimal overlaps
#'are identified for each peptide, these overlaps are gathered into aligning
#'groups based on the initial BLAST. For each group, a multiple sequence
#'alignment logo, or motif, is generated to represent the collective sequence.
#'Additionally, a spreadsheet is written to list the final trimmed amino acid
#'sequences and some metadata.
#'
#' @docType package
#' @name epitopefindr
#'
#' @importFrom magrittr %>%
#' @importFrom magrittr %<>%
#' @import data.table
NULL

## quiets concerns of R CMD check re: the .'s that appear in pipelines
if(getRversion() >= "2.15.1")  utils::globalVariables(c("."))
