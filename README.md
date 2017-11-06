# Docker sbt agent for jenkins pipelines

* To reuse/cache ivy cache : `-v $HOME/.ivy2:/home/sbt/.ivy2`
* Mount your project root directory somewhere and provide the right
  userid in order to be able to full access to project files

Typical usage example ($HOME/myproject owner userid is 1001) :

```
docker run \
   -it -u 1001 --rm \
   -v $HOME/myproject/:/project \
   -v $HOME/.ivy2:/home/sbt/.ivy2 \
   dacr/jenkins-docker-agent-sbt \
   /bin/bash
```
