#!/bin/bash

INPUT_DIR="./proto"
OUTPUT_DIR_NODE="./output/node"
OUTPUT_DIR_GO="./output/go"
OUTPUT_FILE_OAS="./output/result.yaml"
PLUGIN_GRPC="./node_modules/.bin/grpc_tools_node_protoc_plugin"
PLUGIN_TS="./node_modules/.bin/protoc-gen-ts"
GO_OPT="github.com/foway0/labofolio-web-bff/grpc_spec"
GET_ALL_PROTO="$(find ${INPUT_DIR} -iname "*.proto")"

mkdir -p "${OUTPUT_DIR_NODE}"
mkdir -p "${OUTPUT_DIR_GO}"

## init grpc spec
protoc \
--ts_out=import_style=commonjs,binary:"${OUTPUT_DIR_NODE}" \
--js_out=import_style=commonjs,binary:"${OUTPUT_DIR_NODE}" \
--grpc_out="${OUTPUT_DIR_NODE}" \
--plugin=protoc-gen-grpc="${PLUGIN_GRPC}" \
--plugin=protoc-gen-ts="${PLUGIN_TS}" \
-Iproto "${GET_ALL_PROTO}"

protoc \
--go_out=plugins=grpc:"${OUTPUT_DIR_GO}" \
--go_opt=module="${GO_OPT}" \
-I "${INPUT_DIR}" "${GET_ALL_PROTO}"

## init oas spec
npm run merger

if [ -n "${WEB_BFF_REPOS}" ]
then
  cp -r "${OUTPUT_DIR_NODE}/" "${WEB_BFF_REPOS}"
fi

if [ -n "${API_REPOS}" ]
then
  cp -R "${OUTPUT_DIR_GO}/" "${API_REPOS}"
fi

if [ -n "${OAS_REPOS}" ]
then
  cp -R "${OUTPUT_FILE_OAS}" "${OAS_REPOS}"
fi