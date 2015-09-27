# Finances (Perl)
Personal terminal-based financial software.

## Usage

```shell
# List wallets
$ finances wallets

# Add wallet
$ finances wallets add Personal

# Remove wallet
$ finances wallets remove Personal

# Edit wallet
$ perl finances wallets edit Personal
To erase the column content use '-' as value.
name (Personal): Work
description (My personal wallet): My work wallet
Work, My work wallet

# List categories
$ finances categories

# Add category
$ finances categories add "Food & Drink"

# Remove category
$ finances categories remove "Food & Drink"

# Add expense
$ finances expenses add Personal "Food & Drink" 10.50 "Lunch"

# List expenses for wallet
$ finances expenses list Personal
```

### Info
The idea of the project is provide a basic terminal-based financial control system. I am using this project to learn Perl.
