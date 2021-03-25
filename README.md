# Programming Exercise - Grouping

The goal of this exercise is to identify rows in a CSV file that may represent the same person based on a provided Matching Type

## Setup

```sh
./bin/setup
```

## Usage

```sh
grouping <input_file.csv> <matching_type>
```

input_file:       must be a valid CSV file
matching_type:    email|phone|both

output: creates a new file on the same folder of the input_file.csv