# Knot Theory

## Motivation

This repository contains the code I have created during the Spring 2021 semester for undergraduate research done with Dr. Thomas Kindred on knot theory.

Further, I am using this as an opportunity to experiment with and learn more about programming languages and paradigms beyond that which I am currently familiar with. I am doing this by writing each piece of functionality that I write in Python additionally in Haskell and Prolog.

## Code

You will find three directories within this project.

1. `python/`
    * `convert.py`: This contains two python functions, one that converts a DT Code to a Gauss Code, and one that converts a Gauss Code to a DT Code.
    * `generate_gauss.py`: This contains two python functions, one to generate all possible Gauss Codes from a given Gauss Code, and another function used to "relabel" the generated codes in order to keep them in the correct format.
    * `util.py`: This contains a simple python function that converts an array to a string in a pretty way.
2. `haskell/`
    * `convert.hs`: This contains functionality to convert a DT Code to a Gauss Code (though it's currently not the best...).
3. `prolog/`
    * `dt_to_gauss.pl`: This contains functionality to convert a DT Code to a Gauss Code, done in a much better way than in Haskell (lol).
    * `util.pl`: This contains a bunch of utility predicates, such as converting a string to an array.

I will be adding more functionality to all three of the above directories! If you'd like to learn about some cool programming languages, feel free to compare the implementations and see how I approached the problems differently in each one.

**Research is still currently underway, more will be added as I go!**
