# dockedOCent
DOCKerizED Open Code agENT workflow framework. The main goal is to make agents in opencode effective to work. One of main feature is parallel development, it's like lead group of juniors. But I also goint to do some another interesting things:
## install
```
make build
make gen-env
```

optional(recommand add it into your ~/.bashrc):
```
source /project_path/.bashrc
```

## opencode
as default is opencode image start with readonly access to git, without docker socket with repository fully mounted to workdir
```
opencode
```
You can run it with docker socket so opencode can run docker commands(be carefull with this as he can potential kill self, so You will lose progress):
```
opencode -s
```
You can make .git writable what allow all commands: for example push, checkout, reset --hard, ...
```
opencode -m
```
You can set feature name, this option disable .git mount. container got name by feature (with oc_ prefix) so name it with underscores instead of space.
```
opencode -f dockerized_opencode
```

## workflow
The main benefit of this is that you can work in parallel.

### start new task
1. create branch
2. opencode -f feature_1
3. make plan
4. build plan
5. instead of waiting start new task

## todos:
- fix: run opencode under user privileges, not root.
- initiators: you can choose what scripts are run before opencode starts.
- verifies: you can choose what scripts are run when opencode ends.
- git restrictions: You can choose what agent can do with git
- databases: you know for longterm planning, history, etc.
- aliases for effective using