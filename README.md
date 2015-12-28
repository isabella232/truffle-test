# truffle-test
A docker container to test truffle support in Passenger

# Usage

  1. Clone this repository to your computer, navigate to it and run `docker build -t truffle-test .`
  2. Run the container by executing ``docker run -d -v `pwd`/app/:/app truffle-test``
  3. Find out the ip address of the container with `docker inspect <idofpreviouscommand> |grep IPA`
  4. Fetch the hello world: `curl <ipaddressyougot>:3000`
