# Penguin Data Set Adventure Shiny App

### Overview
Welcome to the Penguin Data Set Adventure Shiny App! This is an interactive application thath allows you to explore and visualize the Penguins dataset from the Plamerpenguins R package. You can dynamically filter penguin data based on species and year, and visualize it through tables and plots.

### Link to working app:
[Test Here!](https://blambert.shinyapps.io/penguinapp/)

### Features

**Penguin Species Selection:** Select a penguin species from the drop down to focus on exploration.

**Select Size Variable:** Choose a size variable to examine in graphs, with the variables being flipper length, bill length, and body mass.

**Year Selection:** Utilize radio buttons to view data collected in a specific year (between 2007-2009).

### Plots and Tables

**Table View:** Interactive table to filter penguin data.

**ScatterPlot:** Get a visual look at the relationship between beak size frequency and sex. Option included to filter by species.

**Histogram:** Examine the distribution of penguin bill depth, select for your desired species.

**BoxPlot:** Boxplot of selected variables, grouped by island, option to select data year.


### About the Dataset
The Penguins dataset from the Palmerpenguins R package includes data collected on three (Adelie, Gentoo, and chinstrap) penguin species over three year (2007-2009). Penguin data includes bill measurements, body mass and the respective island.

#### Dataset citation 
Horst AM, Hill AP, Gorman KB (2020). palmerpenguins: Palmer Archipelago (Antarctica) penguin data. doi:10.5281/zenodo.3960218, R package version 0.1.0, https://allisonhorst.github.io/palmerpenguins/.

#### If you would like to view or use this dataset: 
1. Download the palmerpenguins package using the install.packages() function in your R console.
2. Call the palmerpenguins package usign the library() function.
3. Now the dataset itself is named 'penguins', you can use a function of your choice to view the data.
