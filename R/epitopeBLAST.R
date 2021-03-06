#' Identifies next index peptide, calls indexEpitopes to parse alignments to
#' that index peptide, and updates BLAST table accordingly.
#'
#' @param data List with BLAST alignment table and fasta file of peptides.
#' @param aln.size Minimum length of alignment to consider from BLASTp alignments of 'data'.
#'
#' @export

epitopeBLAST <- function(data, aln.size){

  options(stringsAsFactors = FALSE)
  blast <- data[[1]]
  fasta <- data[[2]]
  # == == == == == A. Load fasta, separate full peptides & epitopes. == =
  epitopes <- fasta[grepl("\\.", names(fasta))]

  #subset out prior epitopes. ep.genes = gene|tile names of epitopes.
  if(length(epitopes > 0)){
    ep.names <- names(epitopes) %>% strsplit("__________") %>% unlist %>% as.character
    ep.genes <- sapply(1:length(ep.names), function(x){
      ep.names[x] %>% strsplit("\\.") %>% unlist %>% `[[`(1)})
    blast.current <- blast[!(blast$qID %in% ep.genes), ]
  } else{blast.current <- blast}


  # == == == == == B. Choose index peptide & imsadentify its epitopes. == =
  index <- blast.current %>% chooseIndex()
  if(!("indexOrder" %in% names(data))){
    data$indexOrder <- index
  } else{data$indexOrder %<>% c(index)}

  if(nrow(blast.current) == 0){return(data)}

  # ipath <- "indexOrder.txt"
  # write(index,ipath,append=TRUE)


  newdata <- indexEpitopes(blast, index, aln.size)
  #returns modified blast, index epitopes (indexep)

  # == == == == == C. Write new epitopes .fasta file. == =
  #replace index peptides with index epitopes
  blast.remain <- blast.current[blast.current$qID!=index, ] #aln, q != index
  epFrag <- data.frame(ID = names(epitopes), Seq = epitopes %>% as.character)
  epList <- data.frame(ID = blast.remain$qID, Seq = blast.remain$qSeq) %>%
    rbind(newdata[[2]], epFrag) %>% unique #blast.remain + old eps + new index eps
  epList %<>% mergeFastaDuplicates #remove duplicates, merge nomenclature


  new.fasta <- epList$Seq
  names(new.fasta) <- epList$ID
  new.stringset <- Biostrings::AAStringSet(new.fasta)
  names(new.stringset) <- epList$ID

  returndata <- list(blast = newdata$blast, fasta = new.stringset,
                     indexOrder = data$indexOrder)
  # writeFastaAA(new.stringset,"temp.fasta") #temp debugging
  return(returndata)
} #END epitopeBLAST()

