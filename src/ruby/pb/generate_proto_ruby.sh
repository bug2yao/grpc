#!/bin/sh
# Copyright 2015 gRPC authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Regenerates gRPC service stubs from proto files.
set -e
cd $(dirname $0)/../../..

# protoc and grpc_*_plugin binaries can be obtained by running
# $ bazel build @com_google_protobuf//:protoc //src/compiler:all
PROTOC=bazel-bin/external/com_google_protobuf/protoc
PLUGIN=protoc-gen-grpc=bazel-bin/src/compiler/grpc_ruby_plugin

$PROTOC -I src/proto src/proto/grpc/health/v1/health.proto \
    --grpc_out=src/ruby/pb \
    --ruby_out=src/ruby/pb \
    --plugin=$PLUGIN

$PROTOC -I . \
    src/proto/grpc/testing/{messages,test,empty}.proto \
    --grpc_out=src/ruby/pb \
    --ruby_out=src/ruby/pb \
    --plugin=$PLUGIN

$PROTOC -I . \
    -I third_party/protobuf/src \
    src/proto/grpc/testing/{messages,payloads,stats,benchmark_service,report_qps_scenario_service,worker_service,control}.proto \
    --grpc_out=src/ruby/qps \
    --ruby_out=src/ruby/qps \
    --plugin=$PLUGIN

$PROTOC -I src/proto/math src/proto/math/math.proto \
    --grpc_out=src/ruby/bin \
    --ruby_out=src/ruby/bin \
    --plugin=$PLUGIN
