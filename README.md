# labofolio-spec

## QuickStart

- This project depends on [labofolio-env.](https://github.com/foway0/labofolio-env/blob/master/README.md)

## installation

```
brew install protobuf
npm install .
```

## compile & copy

```
sh generate.sh


export WEB_BFF_REPOS=../web-bff/src/grpc_spec
export API_REPOS=../api/grpc_spec
export OAS_REPOS=../web-bff/src/api_specs/api.yaml
sh generate.sh
```