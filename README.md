# Subject Hierarchy Sample Data and Example Apps

This repository contains sample files and example apps for subject hierarchy visualisation
The main purpose of this repository is to give a simple example of how raw course information can be transformed into a structured dataset and then presented using an interactive Shiny app. The repository also includes an intentionally weak visual example to help students think critically about visual design choices.

## What is in this repository

### 1. Sample dataset
The repository includes a made up Bachelor of IT dataset with:

1. course name
2. year level
3. semester
4. subject type
5. subject code
6. subject name

It also includes a separate prerequisite file that links a subject to its prerequisite subject.

### 2. Example apps
The repository may contain different example apps, such as:

1. a simple hierarchy view
2. a prerequisite relationship view
3. a weak example with a free flowing network layout

These examples are not final solutions for the assessment. They are provided to support discussion about what works well and what does not work well in visualisation design.

## Why this dataset is used

This dataset is used to demonstrate a full workflow that is relevant to the subject topics from Week 2 to Week 9. In particular, students should think about:

1. collecting data from source pages or multiple sources
2. cleaning and standardising the data
3. transforming the data into a usable structure
4. selecting a suitable visualisation
5. publishing the result online
6. giving feedback on another student’s work

Although this example dataset is small, the main idea is that students should learn how to turn imperfect or loosely structured information into something meaningful and interactive.

## Important note about the weak example

One of the example apps may use a free flowing network layout for prerequisite relationships.

This example is included on purpose as a discussion point.

It shows that a chart can be technically functional, but still be difficult to read or not appropriate for the user’s task. Students should not assume that every working visualisation is a good visualisation.

When looking at the weak example, think about these questions:

1. What information is easy to see?
2. What information is hard to see?
3. Does the layout support comparison and progression clearly?
4. Would another visual form communicate the structure better?

## What students are expected to do in the assessment

Students are expected to go beyond copying an example. A strong submission should show that the student can:

1. gather and organise data carefully
2. handle inconsistencies or missing values appropriately
3. transform the data into a structure suitable for visualisation
4. choose a visual design that matches the data and user task
5. build a clear and usable Shiny app
6. publish the result online
7. explain the purpose and limitations of the app clearly

## Suggested discussion points in class

Lecturers and tutors may use this repository to discuss:

1. the difference between hierarchy and network structure
2. the difference between a technically correct chart and an effective chart
3. how layout affects readability
4. why visualisation choice should depend on data and task
5. how to improve weak visual designs

## Files

A typical repository structure may look like this:

```text
data/
  bachelor_it_subjects.csv
  bachelor_it_prerequisites.csv

examples/
  app_subject_tree.R
  app_subject_tree_with_prereq.R

README.md

Last update May 2026

