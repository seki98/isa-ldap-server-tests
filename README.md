# Ldap server paralel tests

#### usage:
  clone the repo to your project directory
  `https://github.com/seki98/isa-ldap-server-tests.git tests`

  add this target to your Makefile:
  ```
  test:
    sh tests/tests.sh ${SERVER} ${PORT}
  ```

  run tests:

  `make test SERVER=DOMAIN_NAME PORT=PORT_NUMBER`

### Must be run from root folder of the project

#### testing is performed by running diff between expected output and real output. 
  `diff tests/out.# tests/exp.#`

