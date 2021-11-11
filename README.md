# OpenSAFELY Dataset Usage Checker Action

This repo provides a GitHub Action for verifying that
[OpenSAFELY](https://docs.opensafely.org/) research repos 
do not contain calls to 
[cohort extractor](https://github.com/opensafely-core/cohort-extractor) 
methods which access restricted data sets

It is written as a "[composite run steps][1]" action.


## Tests

The action is tested in CI by running it against a known good commit of
a testing project. You can test it locally by running:
```
./test.sh
```

[1]: https://docs.github.com/en/actions/creating-actions/creating-a-composite-run-steps-action
