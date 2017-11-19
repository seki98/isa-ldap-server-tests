# Ldap server paralel tests
  clone the repo to your project directory
  `https://github.com/seki98/isa-ldap-server-tests.git tests`

#### quick usage:
  run from project directory:
  `sh tests/tests.sh {SERVER_DOMAIN_NAME} {PORT_NUMBER}`
  where domain name is where server is running with the given port

#### long usage:

  add this target to your Makefile:
  ```
  test:
    sh tests/tests.sh ${SERVER} ${PORT}
  ```

  run tests:

  `make test SERVER=DOMAIN_NAME PORT=PORT_NUMBER`

  See failed tests and its output. eg tests/out.3

### Must be run from root folder of the project

#### testing is performed by running diff between expected output and real output. 
  `diff tests/out.# tests/exp.#`

