## ---- include = FALSE----------------------------------------------------
knitr::opts_chunk$set(
  comment = "#>"
)

## ----setup, results = 'hide', message= FALSE-----------------------------
devtools::install_github("voxfields/rogo") # Install
library(rogo) # Load

## ----example grammar-----------------------------------------------------
# Create a data table with a grammar
exoplanet_grammar <- data.table(
                      # root specifies the tag
                      root = "discoveryEvent", 
                      # shoot specifies the replacement
                      shoot = c("Using #technique#, we #finding#.")
                      )
# Rogo uses grammars stored as data tables
exoplanet_grammar

## ------------------------------------------------------------------------
# Add a new shoot to discoveryEvent root
exoplanet_grammar <- add_shoots(exoplanet_grammar, "discoveryEvent",  # root
                         "We #finding# after validating #technique#." # shoot
                    )
# Add several new branches (root and shoots)
exoplanet_grammar <- add_shoots(exoplanet_grammar, "technique", # root
                         "the radial-velocity method",          # shoots
                         "transit photometry", 
                         "gravational microlensing"
                      )
exoplanet_grammar <- add_shoots(exoplanet_grammar, "finding",  # root
                         "discovered several #planetTypes#",   # shoots
                         "described novel #planetTypes#", 
                         "revised our understanding of #planetTypes#"
                      )
exoplanet_grammar <- add_shoots(exoplanet_grammar, "planetTypes", # root
                         "hot Jupiters",                          # shoots
                         "mini-Neptunes", 
                         "super-Earths"
                      )
exoplanet_grammar

## ------------------------------------------------------------------------
# Generate a sentence about exoplanet discovery
flatten_grammar(exoplanet_grammar, origin = "discoveryEvent")

## ------------------------------------------------------------------------
# Generate a sentence fragment about exoplanet discovery
flatten_grammar(exoplanet_grammar, origin = "finding")

## ------------------------------------------------------------------------
# Remove super-Earths from planetType root
exoplanet_grammar <- trim_shoots(exoplanet_grammar, "planetTypes", # root
                                 "super-Earths"                   # shoot
                                 )
# Remove planetType root altogether 
exoplanet_grammar <- trim_shoots(exoplanet_grammar, "planetTypes"
                                 )
# Generate a fragment about exoplanet discovery without any exoplanet root
flatten_grammar(exoplanet_grammar, origin = "discoveryEvent")

## ------------------------------------------------------------------------
# Create a data table with a grammar
forest_grammar <- data.table(
                      # root specifies the tag
                    root = "forestEvent", 
                      # shoot specifies the replacement
                    shoot = paste0("#preps.cap# I #move.ed#, I saw #animal.a#",
                                   " and several #animal.s#.")
                  )
# Add several new branches (root and shoots)
forest_grammar <- add_shoots(forest_grammar, "move", # root
                         "walk",          # shoots
                         "move", 
                         "jump",
                         "hike"
                      )
forest_grammar <- add_shoots(forest_grammar, "animal",  # root
                         "fox",   # shoots
                         "racoon", 
                         "robin",
                         "insect"
                      )
forest_grammar <- add_shoots(forest_grammar, "preps",  # root
                         "when",   # shoots
                         "before", 
                         "after",
                         "as"
                      )
# Generate text
flatten_grammar(forest_grammar, origin = "forestEvent")

## ------------------------------------------------------------------------
# Temporary file for writing CSV 
temporary_file <- tempfile()
write.csv(forest_grammar, temporary_file)

# Read in grammar
forest_grammar <- read_grammar(temporary_file)

