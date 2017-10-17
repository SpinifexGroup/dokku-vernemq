#!/usr/bin/env bats
load test_helper

@test "($PLUGIN_COMMAND_PREFIX:create) success" {
  run dokku "$PLUGIN_COMMAND_PREFIX:create" l
  assert_contains "${lines[*]}" "container created: l"
  run dokku --force "$PLUGIN_COMMAND_PREFIX:destroy" l >&2
}

@test "($PLUGIN_COMMAND_PREFIX:create) error when there are no arguments" {
  run dokku "$PLUGIN_COMMAND_PREFIX:create"
  assert_contains "${lines[*]}" "Please specify a name for the service"
}
