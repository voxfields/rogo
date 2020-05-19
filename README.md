[rogo_logo.png!](images/rogo_logo.png)

# A Tracery-like Replacement Grammar Implemented in R

## Introduction

**Rogo** is a **Tracery-like** replacement grammar implemented in R. 

Rogo generates text by traversing a grammar that is stored as a data table or CSV. This offers a simple and flexible approach to generating text for many possible fun uses (*e.g.* stories, games or bots).

Tracery was original developed by Kate Compton in Javascript for grammars stored in JSON files. You can read more about Tracery and Kate Compton's work [here](https://www.tracery.io).

## Installation

Rogo can be installed directly from github.

```{r setup}
devtools::install_github("voxfields/rogo")
library(rogo)
```


## Writing an example grammar

Rogo uses grammars stored as data tables. A grammar is a dictionary of branches (*i.e.* rulesets) that match **roots** (*i.e.* tags) to **shoots** (*i.e.* replacements). When generating text, Rogo traverses these branches replacing each root randomly with one of its shoots. We can reference roots within shoots using `#`. 

Let's begin by writing a simple example grammar to generate text about the discovery of exoplanets. 

```{r example grammar}
# Create a data table with a grammar
exoplanet_grammar <- data.table(
                      # root specifies the tag
                      root = "discoveryEvent", 
                      # shoot specifies the replacement
                      shoot = c("Using #technique#, we #finding#.")
                      )
# Rogo uses grammars stored as data tables
exoplanet_grammar
```

## Adding new shoots

We can add one or more new shoots to exisiting roots or create new branches using `add_shoots()`. 

```{r}
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
```

## Generating text

We can use `flatten_grammar()` to generate text. We start flattening the grammar at a specified root called the origin. Here, let's generate a sentence about exoplanet discovery with the `discoveryEvent` root from our example grammar.

```{r}
# Generate a sentence about exoplanet discovery
flatten_grammar(exoplanet_grammar, origin = "discoveryEvent")
```

The origin can be any root in the grammar. For example, we can generate fragments about exoplanet discovery by using the `finding` root from our grammar as the origin.

```{r}
# Generate a sentence fragment about exoplanet discovery
flatten_grammar(exoplanet_grammar, origin = "finding")
```

## Removing existing shoots

We can remove one or more shoots from exisiting roots, or remove branches (roots and shoots) using `trim_shoots()`. If a root is called but not present in the grammar it will be tagged with `$`.

```{r}
# Remove super-Earths from planetType root
exoplanet_grammar <- trim_shoots(exoplanet_grammar, "planetTypes", # root
                                 "super-Earths"                   # shoot
                                 )
# Remove planetType root altogether 
exoplanet_grammar <- trim_shoots(exoplanet_grammar, "planetTypes"
                                 )
# Generate a fragment about exoplanet discovery without any exoplanet root
flatten_grammar(exoplanet_grammar, origin = "discoveryEvent")
```

## Working with modifiers

Modifiers deal with some (but not all) basic English rules for articles (*i.e.* determiners), pluralization and tense. Modifiers are applied to shoots after they've been selected for replacement.

* `.cap` Capitalizes the first letter of the shoot
* `.ed` Modifies a shoot for the paste tense
* `.s` Pluralizes a shoot
* `.a` Adds 'an' or 'a' as a determiner before a root

```{r}
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
```

## Saving and opening an existing grammar

A grammar can be saved as a CSV using `write.csv()`. An existing grammar saved as a CSV can be opened using `read_grammar()`.

```{r}
# Temporary file for writing CSV 
temporary_file <- tempfile()
write.csv(forest_grammar, temporary_file)

# Read in grammar
forest_grammar <- read_grammar(temporary_file)
```

## Bugs, questions, or suggestions 

To report a bug, ask a question, or offer a suggestion for improvement, please open an [issue.](https://github.com/voxfields/rogo/issues)

## More Tracery resources

To learn more about Tracery, see Kate Compton's work:

* [Tracery Javascript Repo](https://github.com/galaxykate/tracery/tree/tracery2)
* [Tracery Tutorial](http://www.crystalcodepalace.com/traceryTut.html)
* [Tracery Browser Editor](http://tracery.io/editor/)
* [Tracery Conference Paper](https://link.springer.com/chapter/10.1007/978-3-319-27036-4_14)
