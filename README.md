# Yearn Strategy

[![License: AGPL v3](https://img.shields.io/badge/License-AGPL%20v3-blue.svg)](https://www.gnu.org/licenses/agpl-3.0)

**DISCLAIMER: This code has NOT been externally audited and is actively being developed. Please do not use in production without taking the appropriate steps to ensure maximum security.**

## Testing and Development
#### Setup
```sh
git clone git@github.com:lucas-manuel/yearn-strategy.git
cd yearn-strategy
dapp update
```
#### Running Tests
- To run all tests: `make test` (runs `./test.sh`)
- To run a specific test function: `./test.sh -t <test_name>` (e.g., `./test.sh -t test_strategy`)

This project was built using [dapptools](https://github.com/dapphub/dapptools).
